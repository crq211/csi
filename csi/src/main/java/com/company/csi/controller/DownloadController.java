package com.company.csi.controller;


import com.company.csi.pojo.Download;
import com.company.csi.service.DownloadService;
import com.company.csi.utils.Result;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.util.*;

/**
 * 下载中心控制器
 */
@Controller
public class DownloadController {

    @Autowired
    DownloadService downloadService;

    /**
     * 使用json方式分页查询全部文档
     */
    @RequestMapping("/downloads")
    @ResponseBody
    public Object list(@RequestParam(value = "start", defaultValue = "1") int start) {
        PageHelper.startPage(start, 5);
        List<Download> downloadList = downloadService.list();
        PageInfo page = new PageInfo(downloadList, 5);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("page", page);
        return Result.success(map);
    }

    /**
     * 增加单个文档
     */
//    @RequestMapping(value = "/download", method = RequestMethod.POST)
//    @ResponseBody
//    public Object add(String title, String message, String userId, MultipartFile image, HttpSession session)
//            throws IOException {
//        Download bean = new Download();
//        bean.setTitle(title);
//        bean.setMessage(message);
//        bean.setUserId(Integer.parseInt(userId));
//        bean.setCreateDate(new Date());
//        downloadService.add(bean);
//        saveOrUpdateImageFile(image, session);
//        return Result.success();
//    }

    @RequestMapping(value = "/download", method = RequestMethod.POST)
    @ResponseBody
    public Object add(Download bean, MultipartFile image, HttpSession session)
            throws IOException {
        bean.setCreateDate(new Date());
        bean.setFileName(image.getOriginalFilename());
        downloadService.add(bean);
        //调用方法
        saveOrUpdateImageFile(image, session);
        return Result.success();
    }

    /**
     * 获取单个文档
     */
    @RequestMapping(value = "/download/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Object get(@PathVariable int id) {
        Download download = downloadService.get(id);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("download", download);
        return Result.success(map);
    }

    /**
     * 修改单个文档
     */
    @RequestMapping(value = "/download/{id}", method = RequestMethod.POST)
    @ResponseBody
    public Object update(Download bean, MultipartFile image, HttpSession session)
            throws IOException {
        System.out.println(bean);

        if (image != null) {
            /**
             * 根据已有的id获取原有的bean，再获取已有的fileName，删除它，再上传新的
             */
            bean = downloadService.get(bean.getId());
            String imageFolder = session.getServletContext().getRealPath("/image");
            File file = new File(imageFolder, bean.getFileName());
            System.out.println( "获取原先的文件名：" + bean.getFileName());
            file.delete();
            //设置新的文件名
            bean.setFileName(image.getOriginalFilename());
            saveOrUpdateImageFile(image, session);
        }
        downloadService.update(bean);
        return Result.success();
    }

    /**
     * 删除多个文档和删除一个用户 二合一
     * 1-2-3-
     * 1
     */
    @RequestMapping(value = "/download/{ids}", method = RequestMethod.DELETE)
    @ResponseBody
    public Object delete(@PathVariable String ids, HttpSession session) {
        if (ids.contains("-")) {
            List<Integer> idList = new ArrayList<Integer>();
            String[] strIds = ids.split("-");
            for (String strId : strIds) {
                int id = Integer.parseInt(strId);
                idList.add(id);
                //同时删除上传的文件
                Download download = downloadService.get(id);
                System.out.println("删除多个文件：" + download.getFileName());
                String imageFolder = session.getServletContext().getRealPath("/image");
                File file = new File(imageFolder, download.getFileName());
                file.delete();
            }
            downloadService.deleteAll(idList);
        } else {
            int id = Integer.parseInt(ids);
            /**
             * 先获取Download，拿到fileName，删除文件，再删除数据库数据
             */
            Download download = downloadService.get(id);
            System.out.println("删除文件：" + download.getFileName());
            String imageFolder = session.getServletContext().getRealPath("/image");
            File file = new File(imageFolder, download.getFileName());
            file.delete();
            downloadService.delete(id);
        }
        return Result.success();
    }


    /**
     * 保存 或 修改图片文件的方法
     */
    private void saveOrUpdateImageFile(MultipartFile image, HttpSession session)
            throws IOException {
        //获取文件名
        String fileName = image.getOriginalFilename();
        System.out.println("新上传的文件名：" + fileName);
        //前半部分路径
        String imageFolder = session.getServletContext().getRealPath("/image");
        //进行路径拼接，加起来
        File file = new File(imageFolder, fileName);

        //创建父文件夹
        if (!file.getParentFile().exists()) {
            file.getParentFile().mkdirs();
        }
        //把浏览器上传的文件(临时文件)复制到file这个位置
        image.transferTo(file);
    }

    /**
     * 根据文档标题模糊搜索文档
     */
    @RequestMapping(value = "/searchByDownloadTitle", method = RequestMethod.GET)
    @ResponseBody
    public Object searchByFullName(@RequestParam(value = "downloadTitle") String downloadTitle,
                                   @RequestParam(value = "start", defaultValue = "1") int start) {
        PageHelper.startPage(start, 5);
        List<Download> downloadList = downloadService.search(downloadTitle);
        PageInfo page = new PageInfo(downloadList, 5);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("page", page);
        return Result.success(map);
    }

    /**
     * 下载当前文件
     */
    @RequestMapping(value = "/downloadFile")
    public HttpServletResponse download(HttpSession session, int id, HttpServletResponse response)
            throws IOException {
        Download bean = downloadService.get(id);
        String imageFolder = session.getServletContext().getRealPath("/image");
        File file = new File(imageFolder, bean.getFileName());
        String fileName = file.getName();
        // 以流的形式下载文件。
        InputStream is = new BufferedInputStream(new FileInputStream(imageFolder + "\\" + bean.getFileName()));
        byte[] buffer = new byte[is.available()];
        is.read(buffer);
        is.close();
        // 清空response
        response.reset();
        /**
         * 设置response的Header，解决文件名中文乱码问题
         */
        //告诉客户端以什么方式打开响应头，attachment附件方式
        response.addHeader("Content-Disposition",
                "attachment;filename=" + new String(fileName.getBytes("UTF-8"), "iso-8859-1"));
        //响应头长度
        response.addHeader("Content-Length", "" + file.length());

        //告诉客户端响应体数据格式
        response.setContentType("application/octet-stream");
        OutputStream os = new BufferedOutputStream(response.getOutputStream());
        os.write(buffer);
        os.flush();
        os.close();
        return response;
    }


}
