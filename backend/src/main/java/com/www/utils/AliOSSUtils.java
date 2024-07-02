package com.www.utils;

import com.aliyun.oss.OSS;
import com.aliyun.oss.OSSClientBuilder;
import com.aliyun.oss.model.ObjectMetadata;
import com.aliyun.oss.model.PutObjectRequest;
//import com.sun.deploy.net.URLEncoder;
import com.www.config.aliyun.OSSConfig;
import lombok.Data;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.InputStream;
import java.util.UUID;

/**
 * Created with IntelliJ IDEA 2021.
 *
 * @Author: Mr Qin
 * @Date: 2024/04/04/15:23
 * @Description:
 */
@Component
@Data
//@ConfigurationProperties(prefix = "aliyun.oss.file")
public class AliOSSUtils {

    private String endpoint;
    private String accessKeyID;
    private String accessKeySecret;
    private String bucketName;
    private static final String basePath = "image/"; // 存储路径
    private static final String imageBasePath = "image/"; // 图片存储路径
    private static final String videoBasePath = "video/"; // 视频存储路径

    private final OSSConfig ossConfig;


    /**
     * 实现上传图片到OSS
     *
     * @param file 图片上传信息
     * @return
     */
    public String upload1(MultipartFile file) throws IOException {
        String resultFile = "失败";
        // 创建OSSClient实例。
        OSS ossClient = new OSSClientBuilder().build(endpoint, accessKeyID, accessKeySecret);
        String fileExtension = getFileExtension(file.getOriginalFilename());
        String fileName = getUniqueFileName(fileExtension);
        try {
            // 获取文件输入流
            InputStream inputStream = file.getInputStream();
            // 判断是否为有效文件
            if (isImageFile(fileExtension)) {
                BufferedImage bufferedImage = ImageIO.read(inputStream);
                if (bufferedImage == null || bufferedImage.getWidth() == 0 || bufferedImage.getHeight() == 0) {
                    return resultFile;
                }
            }
            // 指定文件存储的路径和名称
            String basePath = isImageFile(fileExtension) ? imageBasePath : videoBasePath;
            String filePath = basePath + fileName;
            // 创建PutObject请求。
            ossClient.putObject(bucketName, filePath, file.getInputStream());
            inputStream.close();
            String url = "https://" + bucketName + "." + endpoint + "/" + filePath;
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

    public String upload(MultipartFile multipartFile) throws IOException {

        //获取相关配置
        String bucketName = ossConfig.getBucketName();
        String endPoint = "https://" + ossConfig.getEndPoint();
        String accessKeyId = ossConfig.getAccessKeyID();
        String accessKeySecret = ossConfig.getAccessKeySecret();

        // 获取上传的文件的输入流
        InputStream inputStream = multipartFile.getInputStream();
        // 生成UUID作为文件名的一部分
        String uuid = UUID.randomUUID().toString().replace("-", "");
        // 获取原始文件名的扩展名
        String originalFilename = multipartFile.getOriginalFilename();
        String fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));
        // 组合新的文件名
        String fileName = "rms/" + uuid + "_" + originalFilename;
        // 最终完整的文件路径
        String filePath = "rms/" + fileName;

//        String fileName = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd-HH-mm-ss")) + multipartFile.getOriginalFilename().trim();

        // 解决threejs访问图片跨域问题
        ObjectMetadata metadata = new ObjectMetadata();
        // 取消文件缓存，文件每次都会从OSS服务器获取
        metadata.setHeader("Cache-Control", "no-cache");
        metadata.setHeader("Expires", "0");

        //创建OSS对象
        OSS ossClient = new OSSClientBuilder().build(endPoint, accessKeyId, accessKeySecret);

        try {
            PutObjectRequest putObjectRequest = new PutObjectRequest(bucketName, fileName, inputStream, metadata);
            ossClient.putObject(putObjectRequest);

            // 文件访问路径到 OSS
            String url = endPoint.split("//")[0] + "//" + bucketName + "." + endPoint.split("//")[1] + "/" + fileName;
            // 关闭OSSClient
//            ossClient.shutdown();
            // 返回OSS上传路径
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


    // 生成唯一的文件名，防止文件名冲突
    private String getUniqueFileName(String fileExtension) {
        return UUID.randomUUID().toString().replace("-", "") + fileExtension;
    }

    // 获取文件后缀
    private String getFileExtension(String fileName) {
        if (fileName != null && fileName.contains(".")) {
            return fileName.substring(fileName.lastIndexOf("."));
        }
        return "";
    }

    // 判断是否为图片文件
    private boolean isImageFile(String fileExtension) {
        return fileExtension.equalsIgnoreCase(".jpg") ||
                fileExtension.equalsIgnoreCase(".jpeg") ||
                fileExtension.equalsIgnoreCase(".png") ||
                fileExtension.equalsIgnoreCase(".gif");
    }


}
