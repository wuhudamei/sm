package cn.damei.core.dto;

public class XhEditorUploadDto {
    private String err = "";  //错误信息
    private String msg = "";  //图片路径

    public String getErr() {
        return err;
    }

    public void setErr(String err) {
        this.err = err;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }
}
