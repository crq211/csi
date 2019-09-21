package com.company.csi.controller;

import com.company.csi.pojo.User;
import com.company.csi.service.UserService;
import com.company.csi.utils.FaceClient;
import com.company.csi.utils.ImageToBase;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import sun.misc.BASE64Decoder;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.*;

@Controller
public class FaceController {

    @Autowired
    UserService userService;

    /**
     * 跳转到人脸注册页面
     * @return
     */
    @RequestMapping(value = "/faceRegister", method = RequestMethod.GET)
    public String register() {
        return "face/register";
    }

    /**
     * 跳转到人脸识别页面
     * @return
     */
    @RequestMapping(value = "/faceLogin", method = RequestMethod.GET)
    public String login()    {
        return "face/login";
    }


    /**
     * 人脸注册
     */
    @RequestMapping(value = "/faceRegister", produces = "application/json; charset=utf-8",
            method = RequestMethod.POST)
    @ResponseBody
    public String faceRegister(HttpServletRequest request, String base) {
        HttpSession session = request.getSession();
        JSONObject json = new JSONObject();
        json.put("message", "");
        // 获取session中的用户信息
        User user = (User) session.getAttribute("user");
        // 定义图片的存储目录
        String path = request.getServletContext().getRealPath("/") + "headPhoto/";
        // 检查目录该存储是否存在，如果不存在，则创建该目录
        File uploadDir = new File(path);
        if (!uploadDir.exists() && !uploadDir.isDirectory()) {
            uploadDir.mkdirs();
        }
        // 目录创建后，完善图片的存储路径名
        path += user.getUserName() + ".jpg";

        System.out.println("path" + path);
        // 定义图片存储数据库中的url
        String urlPath = request.getContextPath() + "/headPhoto/" + user.getUserName() + ".jpg";

        System.out.println("urlPath" + path);

        // ============将图片存入到硬盘中===============
        OutputStream out = null;
        InputStream is = null;
        try {
            // 将base64图片数据解码成字节数组
            byte[] imgByte = new byte[0];
            try {
                imgByte = new BASE64Decoder().decodeBuffer(base);
            } catch (IOException e) {
                e.printStackTrace();
            }
            // 调整异常数据 base64数据解码可能会出现负数
            for (int i = 0; i < imgByte.length; ++i) {
                if (imgByte[i] < 0) {
                    imgByte[i] += 256;
                }
            }
            out = new FileOutputStream(path);
            is = new ByteArrayInputStream(imgByte);

            byte[] buff = new byte[1024];
            int len = 0;
            while ((len = is.read(buff)) != -1) {
                out.write(buff, 0, len);
            }
        } catch (IOException e) {
            // 捕获到异常则表示上传出错
            json.put("message", "注册失败");
            e.printStackTrace();
            return json.toString();
        } finally {
            if (is != null) {
                try {
                    is.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (out != null) {
                try {
                    out.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        // 更新登录用户的faceurl(服务器存储路径)字段和facepath(实际存储路径)字段
        userService.updateFaceUrlByName(user.getUserName(), urlPath, path);
        json.put("message", "注册成功");
        return json.toString();
    }


    /**
     * 人脸登录
     */
    @RequestMapping(value = "/faceLogin", produces = "application/json; charset=utf-8",
                    method = RequestMethod.POST)
    @ResponseBody
    public String faceLogin(HttpServletRequest request, String base) {
        String APP_ID = "17073172";
        String API_KEY = "nvfZ0MZCHZovtyfGlYem6w6H";
        String SECRET_KEY = "uyiN9a8ymZrhkGWdnK9PuDwjU2oxgPyu";
        HttpSession session = request.getSession();
        JSONObject json = new JSONObject();
        json.put("message", "");

        // 查询出所有的用户信息，进行照片比对
        List<User> userList = userService.list();
        for (User user : userList) {
            if (user.getFacePath() != null && !user.getFacePath().trim().equals("")) {
                String localImgBase = ImageToBase.getImageStr(user.getFacePath());
                FaceClient faceClient = FaceClient.getInstance(APP_ID, API_KEY, SECRET_KEY);
                boolean loginBool = faceClient.faceContrast(localImgBase, base);
                if (loginBool) {
                    System.out.println("登录成功");
                    session.setAttribute("user", user);
                    json.put("message", "登录成功");
                    return json.toString();
                }
            }
        }
        return json.toString();
    }

}
