import axios from "axios";
import { ElMessage } from "element-plus";

// 引入封装的nprogress.js
import { start, close } from '@/utils/nprogress';
// AES
// import { aesEncrypt, aesDecrypt } from '@/utils/AES';
import CryptoJS from 'crypto-js';
const secretKey = 'abcdef0123456789';



const uploadUrl = "http://localhost:8000/upload";
const uploadOssImage = "http://localhost:8000/upload/image";
const uploadOssVideo = "http://localhost:8000/upload/video";
const baseURL = "http://localhost:8000";
const socketURL = "ws://localhost:8000";

// const uploadUrl = "http://47.115.227.101:8000/upload";
// const uploadOssImage = "http://47.115.227.101:8000/upload/image";
// const uploadOssVideo = "http://47.115.227.101:8000/upload/video";
// const baseURL = "http://47.115.227.101:8000";
// const socketURL = "ws://47.115.227.101:8000";
const request = axios.create({
    // baseURL: "http://47.115.227.101:8000/api",
    baseURL: baseURL,
    timeout: 100000,
    headers: {
        "Content-Type": "application/json;charset=utf-8"
    }
});

// axios请求拦截器
request.interceptors.request.use(config => {
    start()  //开启进度条
    config.headers['Authorization'] = localStorage.getItem("token")
    // 加密参数
    // if (config.data) {
    //     const encryptedData = aesEncrypt(JSON.stringify(config.data), secretKey);
    //     config.data = encryptedData;
    // }
    return config;
}, error => {
    return Promise.reject(error);
});

// axios响应式拦截器
request.interceptors.response.use(
    response => {
        close()  //关闭进度条
        let res = response.data;
        if (typeof res === "string") {
            res = res ? JSON.parse(res) : res;
        }
        return res;
    }, error => {
        console.log("error", error.response.data.code);
        // 判断是否是自定义的错误信息
        if (error.response && error.response.data) {
            return Promise.reject(error.response.data);
        }
        // 认证失败跳转到登录页
        else if (error.response.data.code === 401) {
            console.log("认证失败");
            location.href = "/login"
        } else {
            // 网络错误等其他情况
            ElMessage.error("请求出错，请重试");
            return Promise.reject(error);
        }
    }
);


// AES加密函数
const aesEncrypt = (message, secret) => {
    const encrypted = CryptoJS.AES.encrypt(message, secret);
    return encrypted.toString();
};

export default request;
export {
    uploadUrl, baseURL, uploadOssImage, uploadOssVideo, socketURL
};
