package com.www.vo;

/**
 * @Author Alin
 * @date 2024/5/3 003 23:21
 * @Description:
 */
import lombok.Data;

@Data
public class R {
    private static final Integer SUCCESS = 0;
    private static final Integer ERROR = -1;

    private Integer errno;
    private String msg;
    private Object data;

    public static R success() {
        R r = new R();
        r.setErrno(SUCCESS);
        return r;
    }

    /**
     * 往前台返回数据
     *
     * @param data
     * @return
     */
    public static R success(Object data) {
        R r = new R();
        r.setErrno(SUCCESS);
        r.setData(data);
        return r;
    }

    /**
     * 返回失败的结果
     *
     * @param msg
     * @return
     */
    public static R error(String msg) {
        R r = new R();
        r.setErrno(ERROR);
        r.setMsg(msg);
        return r;
    }
}
