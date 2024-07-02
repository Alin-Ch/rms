package com.www.controller;

import cn.hutool.core.lang.UUID;
import cn.hutool.core.map.MapUtil;
import cn.hutool.core.util.RandomUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.google.code.kaptcha.Producer;
import com.www.common.exception.CustomException;
import com.www.common.lang.Const;
import com.www.pojo.*;
import com.www.service.SysUserRoleService;
import com.www.service.SysUserService;
import com.www.utils.AliOSSUtils;
import com.www.utils.RedisUtil;
import com.www.vo.R;
import com.www.vo.Result;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import sun.misc.BASE64Encoder;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.security.Principal;
import java.util.Date;

/**
 * Created with IntelliJ IDEA 2021.
 *
 * @Author: Mr Qin
 * @Date: 2024/03/24/22:53
 * @Description:
 */
@RestController
@Validated
public class AuthController {

    private final HttpServletRequest request;

    private final Producer producer;

    private final RedisUtil redisUtil;

    private final SysUserService sysUserService;

    private final SysUserRoleService sysUserRoleService;

    private final AliOSSUtils aliOSSUtils;

    private final PasswordEncoder passwordEncoder;

    private final JavaMailSender javaMailSender;

    public static final String EMAIL_REGEX =
            "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";

    String password = null;

    @Value(value = "${spring.mail.username}")
    private String sender;

    public AuthController(HttpServletRequest request,
                          Producer producer,
                          RedisUtil redisUtil,
                          SysUserService sysUserService,
                          SysUserRoleService sysUserRoleService,
                          AliOSSUtils aliOSSUtils,
                          PasswordEncoder passwordEncoder,
                          JavaMailSender javaMailSender) {
        this.request = request;
        this.producer = producer;
        this.redisUtil = redisUtil;
        this.sysUserService = sysUserService;
        this.sysUserRoleService = sysUserRoleService;
        this.aliOSSUtils = aliOSSUtils;
        this.passwordEncoder = passwordEncoder;
        this.javaMailSender = javaMailSender;
    }

    /**
     * 获取用户个人信息接口
     *
     * @param principal
     * @return
     */
    @GetMapping("/sys/userInfo")
    public Result userInfo(Principal principal) {
        SysUser sysUser = sysUserService.getByUsername(principal.getName());
        SysRole sysRole = sysUserRoleService.getByUserId(sysUser.getId());
        sysUser.setRole(sysRole);
        return Result.success(sysUser);
//        return Result.success(MapUtil.builder()
//                .put("id", sysUser.getId())
//                .put("username", sysUser.getUsername())
//                .put("avatar", sysUser.getAvatar())
//                .put("created", sysUser.getCreated())
//                .map()
//        );
    }

    /**
     * 用户注册
     *
     * @param sysUser
     * @return
     */
    @PostMapping("/register")
    public Result register(@Validated @RequestBody SysUser sysUser,
                           @RequestParam("emailCode") String emailCode) {
        // 在这里通过request绝对拿不到，key，在Spring框架中，使用@RequestBody注解接收前端传递的JSON数据时，
        // 无法直接使用request.getParameter()来获取请求参数，因为请求体中的参数已经被框架解析为对象，并绑定到了相应的Java对象上。

        // 先从数据库查询这个邮箱号有没有人，如果有就不给注册，邮箱号是唯一的（这里根据业务需求，可以让手机号或用户名等唯一）
        SysUser sysUser1 = sysUserService.getOne(new QueryWrapper<SysUser>().eq("email", sysUser.getEmail()));
        if (sysUser1 != null) {
            return Result.fail("用户已存在！");
        }

        // 在注册接口中直接从请求参数中获取 token 和 IDcode
        String key = sysUser.getEmail();
        String code = emailCode;

        if (StrUtil.isBlank(code) || StrUtil.isBlank(key)) {
            throw new CustomException("验证码输入错误！");
        }

        if (redisUtil.isExpire(key)) {
            throw new CustomException("验证码已过期，请重新获取！");
        }

        if (!code.equals(redisUtil.get(key))) {
            throw new CustomException("验证码输入错误！");
        }

        sysUser.setCreated(new Date());
        // 数据库状态默认为1，表示正常
        // 默认加密密码，888888
        if (sysUser.getPassword() == null) {
            password = passwordEncoder.encode(Const.DEFAULT_PASSWORD);
        } else {
            password = passwordEncoder.encode(sysUser.getPassword());
        }
        sysUser.setPassword(password);
        // 设置默认头像
        sysUser.setAvatar(Const.DEFAULT_AVATAR);
        sysUserService.save(sysUser);

        // 添加用户时设置默认角色
        SysUserRole sysUserRole = new SysUserRole();
        sysUserRole.setUserId(sysUser.getId());
        sysUserRole.setRoleId(1L);
        sysUserRoleService.save(sysUserRole);
        return Result.success("注册成功");
    }

    /**
     * 重置密码接口
     *
     * @param sysUser
     * @param emailCode
     * @return
     */
    @PostMapping("/updatePassword")
    public Result foundMinePwd(@RequestBody SysUser sysUser,
                               @RequestParam("emailCode") String emailCode) {

        String email = sysUser.getEmail();
        String code = emailCode;

        if (StrUtil.isBlank(code) || StrUtil.isBlank(email)) {
            throw new CustomException("验证码输入错误！");
        }

        if (redisUtil.isExpire(email)) {
            throw new CustomException("验证码已过期，请重新获取！");
        }

        if (!code.equals(redisUtil.get(email))) {
            throw new CustomException("验证码输入错误！");
        }
        if (sysUser.getPassword() == null) {
            throw new CustomException("密码不能为空");
        }
        // 先校验再执行，根据email更新用户密码
        sysUser.setUpdated(new Date());
        String newPwd = passwordEncoder.encode(sysUser.getPassword());
        sysUser.setPassword(newPwd);
        sysUserService.update(sysUser, new QueryWrapper<SysUser>().eq("email", email));
        return Result.success("操作成功");
    }

    /**
     * 登录验证码接口
     *
     * @return
     * @throws IOException
     */
    @GetMapping("/captcha")
    public Result captcha() throws IOException {

        String key = UUID.randomUUID().toString();
        // 生成验证码字符串
        String code = RandomUtil.randomNumbers(4);
//        String code = producer.createText();

        // 为了测试
        //key = "aaaaa";
        //code = "11111";

        BufferedImage image = producer.createImage(code);
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        ImageIO.write(image, "jpg", outputStream);

        // base64编码
        BASE64Encoder encoder = new BASE64Encoder();
        // 字符前缀
        String str = "data:image/jpeg;base64,";

        String base64Img = str + encoder.encode(outputStream.toByteArray());

        // 普通缓存，key: UUID value: code   过期时间：120秒
        redisUtil.set(key, code, 120);

        return Result.success(
                MapUtil.builder()
                        .put("token", key)
                        .put("captchaImg", base64Img)
                        .build()
        );
    }

    /**
     * 注册邮箱验证码接口
     *
     * @param email
     * @return
     */
    @GetMapping("/email/{email}")
    public Result sendEmailCode(@PathVariable("email")
                                @NotBlank(message = "邮箱不能为空")
                                @Pattern(regexp = "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$", message = "邮箱格式不正确")
                                        String email) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom(sender);
        message.setTo(email);
        message.setSubject("邮箱验证码");
        // 生成验证码字符串
//        String code = producer.createText();
        String code = RandomUtil.randomNumbers(4);//随机生成四位数字验证码
//        String key = UUID.randomUUID().toString();
        // 普通缓存，key: UUID value: code   过期时间：5分钟
        redisUtil.set(email, code, 300);
        message.setText("您本次注册的验证码为：" + code + "，有效时间5分钟，如果不是您本人操作请忽略。");

        javaMailSender.send(message);
        return Result.success(
                MapUtil.builder()
                        .put("regEmail", email)
                        .build()
        );
    }

    /**
     * 上传头像接口
     *
     * @param file
     * @return
     * @throws IOException
     */
    @PostMapping("/upload")
    public Result upload(@RequestParam("file") MultipartFile file) throws IOException {
        String url = aliOSSUtils.upload(file);
        return Result.success(url);
    }

    @PostMapping("/upload/image")
    public R uploadImage(@RequestParam("file") MultipartFile file) throws IOException {
        String filename = file.getOriginalFilename();
        String result = "失败";
        wangEditorImage image = new wangEditorImage();
        if (!file.isEmpty()) {
            String path = aliOSSUtils.upload(file);
            if (path.equals(result)) {
                return R.error("上传失败");
            } else {
                System.out.println("阿里云返回的图片链接是：" + path);
                // 七牛云返回的path中含有一些敏感字段，需要进一步处理
                int index = path.indexOf("?");
                String url = index != -1 ? path.substring(0, index) : path;

                image.setAlt(filename);
                image.setUrl(url);
                image.setHref(url);
                return R.success(image);
            }
        }
        return R.error("上传失败");
    }

    @PostMapping("/upload/video")
    public R uploadVideo(@RequestParam("file") MultipartFile file) throws IOException {
        String filename = file.getOriginalFilename();
        String result = "失败";
        wangEditorVideo video = new wangEditorVideo();
        if (!file.isEmpty()) {
            String path = aliOSSUtils.upload(file);
            if (path.equals(result)) {
                return R.error("上传失败");
            } else {
                // 七牛云返回的path中含有一些敏感字段，需要进一步处理
                int index = path.indexOf("?");
                String url = index != -1 ? path.substring(0, index) : path;

                video.setUrl(url);
                return R.success(video);
            }
        }
        return R.error("上传失败");
    }

}
