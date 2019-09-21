package com.company.csi.utils;

/**
 *
 */
public class Result {

    static int SUCCESS_CODE = 0;
    static int FAIL_CODE = 1;

    //状态码
    int code;
    //错误信息
    String message;
    //数据
    Object data;

    public Result() {

    }

    public Result(int code, String message, Object data) {
        this.code = code;
        this.message = message;
        this.data = data;
    }

    //不包含数据的成功，比如注册、登录，只需要返回成功状态码
    public static Result success() {
        return new Result(SUCCESS_CODE, null, null);
    }

    //包含数据的成功,返回成功状态码和数据
    public static Result success(Object data) {
        return new Result(SUCCESS_CODE, null, data);
    }

    //包含错误信息的失败，返回失败状态码和错误信息
    public static Result fail(String msg) {
        return new Result(FAIL_CODE, msg, null);
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }
}
