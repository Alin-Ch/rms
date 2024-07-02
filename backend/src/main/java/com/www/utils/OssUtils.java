package com.www.utils;

import cn.hutool.core.date.DateTime;
import com.aliyun.oss.OSS;
import com.aliyun.oss.OSSClientBuilder;
import com.www.common.exception.CustomException;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * @Author Alin
 * @date 2024/2/5 005 20:37
 * @Description:
 */
@Component
public class OssUtils implements InitializingBean {
    private String endpoint;
    private String accessKeyID;
    private String accesskeySecret;
    private String bucketName;

    public static String END_POINT;
    public static String ACCESS_KEY_ID;
    public static String ACCESS_KEY_SECRET;
    public static String BUCKET_NAME;
    @Override
    public void afterPropertiesSet() throws Exception {
        END_POINT = endpoint;
        ACCESS_KEY_ID = accessKeyID;
        ACCESS_KEY_SECRET = accesskeySecret;
        BUCKET_NAME = bucketName;
    }


    public String uploadOneFile(MultipartFile file) {
        if (!(file.getOriginalFilename().endsWith(".png")) && !(file.getOriginalFilename().endsWith(".jpg"))) {
            throw new CustomException("文件类型错误，只能为png或者jpg");
        }
        // 创建OSSClient实例。
        OSS ossClient = new OSSClientBuilder().build(endpoint, accessKeyID, accesskeySecret);
        //设置文件名
        String fileName = new DateTime().toString("yyyy/MM/dd")
                + UUID.randomUUID().toString().replace("-", "")
                + file.getOriginalFilename();

        try {
            // 创建PutObject请求。
            ossClient.putObject(bucketName, fileName, file.getInputStream());

            String url = "http://" + bucketName + "." + endpoint + "/" + fileName;
            // System.out.println(url);
            return url;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            if (ossClient != null) {
                ossClient.shutdown();
            }
        }
    }

    public List<String> uploadArrayFile(MultipartFile[] files) {
        // 创建OSSClient实例。
        OSS ossClient = new OSSClientBuilder().build(endpoint, accessKeyID, accesskeySecret);
        List<String> list = new ArrayList<>();
        try {
            //设置文件名
            for (MultipartFile file : files) {
                String fileName = new DateTime().toString("yyyy/MM/dd")
                        + UUID.randomUUID().toString().replace("-", "")
                        + file.getOriginalFilename();
                // 创建PutObject请求。
                ossClient.putObject(bucketName, fileName, file.getInputStream());
                String url = "http://" + bucketName + "." + endpoint + "/" + fileName;
                // System.out.println(url);
                list.add(url);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            if (ossClient != null) {
                ossClient.shutdown();
            }
        }
        return list;

    }

    public boolean deleteFile(String fileUrl) {
        // 创建OSSClient实例。
        OSS ossClient = new OSSClientBuilder().build(endpoint, accessKeyID, accesskeySecret);
        /** oss删除文件是根据文件完成路径删除的，但文件完整路径中不能包含Bucket名称。
         * 比如文件路径为：http://edu-czf.oss-cn-guangzhou.aliyuncs.com/2022/08/abc.jpg",
         * 则完整路径就是：2022/08/abc.jpg
         */
        int begin = ("http://" + bucketName + "." + endpoint + "/").length(); //找到文件路径的开始下标
        String deleteUrl = fileUrl.substring(begin);
        try {
            // 删除文件请求
            ossClient.deleteObject(bucketName, deleteUrl);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            if (ossClient != null) {
                ossClient.shutdown();
            }
        }
    }



}


