package com.www.controller;

import cn.hutool.core.date.DateUnit;
import cn.hutool.core.date.DateUtil;
import cn.hutool.json.JSONObject;
import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.internal.util.AlipaySignature;
import com.alipay.api.request.AlipayTradePagePayRequest;
import com.alipay.api.request.AlipayTradeRefundRequest;
import com.alipay.api.response.AlipayTradeRefundResponse;
import com.www.config.alipay.AliPay;
import com.www.config.alipay.AliPayConfig;
import com.www.mapper.SysOrderMapper;
import com.www.pojo.SysOrder;
import com.www.service.SysOrderService;
import com.www.vo.Result;
import io.swagger.annotations.Api;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * @Author Alin
 * @date 2024/5/3 003 16:14
 * @Description:
 */
// 支付账号：bcvqkw6031@sandbox.com   密码：111111
@RestController
@Api(tags = "沙箱支付")
@RequestMapping("/alipay")
public class AliPayController {
    //        private static final String GATEWAY_URL = "https://openapi.alipaydev.com/gateway.do";
    private static final String GATEWAY_URL = "https://openapi-sandbox.dl.alipaydev.com/gateway.do"; //沙箱环境
    private static final String FORMAT = "JSON";
    private static final String CHARSET = "UTF-8";
    //签名方式
    private static final String SIGN_TYPE = "RSA2";

    private final SysOrderService sysOrderService;

    @Resource
    private AliPayConfig aliPayConfig;
    @Resource
    private SysOrderMapper sysOrderMapper;

    public AliPayController(SysOrderService sysOrderService) {
        this.sysOrderService = sysOrderService;
    }

    @GetMapping("/pay") // &subject=xxx&traceNo=xxx&totalAmount=xxx
    public void pay(AliPay aliPay, HttpServletResponse httpResponse) throws Exception {
        // 1. 创建Client，通用SDK提供的Client，负责调用支付宝的API
        AlipayClient alipayClient = new DefaultAlipayClient(GATEWAY_URL, aliPayConfig.getAppId(),
                aliPayConfig.getAppPrivateKey(), FORMAT, CHARSET, aliPayConfig.getAlipayPublicKey(), SIGN_TYPE);

        // 2. 创建 Request并设置Request参数
        AlipayTradePagePayRequest request = new AlipayTradePagePayRequest();  // 发送请求的 Request类
        request.setNotifyUrl(aliPayConfig.getNotifyUrl());
        request.setReturnUrl(aliPayConfig.getReturnUrl());
        JSONObject bizContent = new JSONObject();
        bizContent.set("out_trade_no", aliPay.getTraceNo());  // 我们自己生成的订单编号
        bizContent.set("total_amount", aliPay.getTotalAmount()); // 订单的总金额
        bizContent.set("subject", aliPay.getSubject());   // 支付的名称
        bizContent.set("product_code", "FAST_INSTANT_TRADE_PAY");  // 固定配置
        request.setBizContent(bizContent.toString());

        // 执行请求，拿到响应的结果，返回给浏览器
        String form = "";
        try {
            form = alipayClient.pageExecute(request).getBody(); // 调用SDK生成表单
        } catch (AlipayApiException e) {
            e.printStackTrace();
        }
        httpResponse.setContentType("text/html;charset=" + CHARSET);
        httpResponse.getWriter().write(form);// 直接将完整的表单html输出到页面
        httpResponse.getWriter().flush();
        httpResponse.getWriter().close();
    }

    @PostMapping("/notify")  // 注意这里必须是POST接口
    public String payNotify(HttpServletRequest request) throws Exception {
        if (request.getParameter("trade_status").equals("TRADE_SUCCESS")) {
            System.out.println("=========支付宝异步回调========");

            Map<String, String> params = new HashMap<>();
            Map<String, String[]> requestParams = request.getParameterMap();
            for (String name : requestParams.keySet()) {
                params.put(name, request.getParameter(name));
                // System.out.println(name + " = " + request.getParameter(name));
            }

            String outTradeNo = params.get("out_trade_no");
            String gmtPayment = params.get("gmt_payment");
            String alipayTradeNo = params.get("trade_no");

            String sign = params.get("sign");
            String content = AlipaySignature.getSignCheckContentV1(params);
            boolean checkSignature = AlipaySignature.rsa256CheckContent(content, sign, aliPayConfig.getAlipayPublicKey(), "UTF-8"); // 验证签名
            // 支付宝验签
            if (checkSignature) {
                // 验签通过
                System.out.println("交易名称: " + params.get("subject"));
                System.out.println("交易状态: " + params.get("trade_status"));
                System.out.println("支付宝交易凭证号: " + params.get("trade_no"));
                System.out.println("商户订单号: " + params.get("out_trade_no"));
                System.out.println("交易金额: " + params.get("total_amount"));
                System.out.println("买家在支付宝唯一id: " + params.get("buyer_id"));
                System.out.println("买家付款时间: " + params.get("gmt_payment"));
                System.out.println("买家付款金额: " + params.get("buyer_pay_amount"));

                // 查询订单
                SysOrder sysOrder = sysOrderMapper.findByOrderNo(outTradeNo);

                if (sysOrder != null) {
                    sysOrder.setAlipayNo(alipayTradeNo);
                    sysOrder.setUpdateTime(new Date());
                    sysOrder.setPaymentTime(new Date());
                    sysOrder.setStatus(1);
                    sysOrderService.updateById(sysOrder);
                }
            }
        }
        return "success";
    }

    @GetMapping("/refund")
    public Result returnPay(AliPay aliPay) throws AlipayApiException {
        // 7天无理由退款
        String now = DateUtil.now();
        SysOrder sysOrder = sysOrderMapper.findByOrderNo(aliPay.getTraceNo());
        if (sysOrder != null) {
            if (sysOrder.getStatus() == 0) {
                return Result.fail("订单还未支付");
            }
            // hutool工具类，判断时间间隔  如果数据库存时间字段是string类型，就用第一行
            // long between = DateUtil.between(DateUtil.parseDateTime(sysOrder.getUpdateTime()), DateUtil.parseDateTime(now), DateUnit.DAY);
            long between = DateUtil.between(sysOrder.getUpdateTime(), DateUtil.date(), DateUnit.DAY);
            if (between > 7) {
                return Result.fail("该订单已超过7天，不支持退款");
            }
            if (sysOrder.getStatus() == 2) {
                return Result.fail("订单已经退款");
            }
        }

        // 1. 创建Client，通用SDK提供的Client，负责调用支付宝的API
        AlipayClient alipayClient = new DefaultAlipayClient(GATEWAY_URL,
                aliPayConfig.getAppId(), aliPayConfig.getAppPrivateKey(), FORMAT, CHARSET,
                aliPayConfig.getAlipayPublicKey(), SIGN_TYPE);
        // 2. 创建 Request，设置参数
        AlipayTradeRefundRequest request = new AlipayTradeRefundRequest();
        JSONObject bizContent = new JSONObject();
        bizContent.set("trade_no", aliPay.getAlipayTraceNo());  // 支付宝回调的订单流水号
        bizContent.set("refund_amount", aliPay.getTotalAmount());  // 订单的总金额
        bizContent.set("out_request_no", aliPay.getTraceNo());   //  我的订单编号

        // 返回参数选项，按需传入
        //JSONArray queryOptions = new JSONArray();
        //queryOptions.add("refund_detail_item_list");
        //bizContent.put("query_options", queryOptions);

        request.setBizContent(bizContent.toString());

        // 3. 执行请求
        AlipayTradeRefundResponse response = alipayClient.execute(request);
        if (response.isSuccess()) {  // 退款成功，isSuccess 为true
            System.out.println("调用成功");

            // 4. 更新数据库状态
//            sysOrderMapper.updatePayState(aliPay.getTraceNo(), "已退款", now);
            sysOrder.setUpdateTime(new Date());
            sysOrder.setStatus(2);
            sysOrderService.updateById(sysOrder);

            return Result.success("退款成功");
        } else {   // 退款失败，isSuccess 为false
            System.out.println(response.getBody());
//            return Result.error(response.getCode(), response.getBody());
            return Result.fail(response.getBody());
        }

    }


}
