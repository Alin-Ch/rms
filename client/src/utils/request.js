import axios from "axios";
import { ElMessage } from "element-plus";
// 引入封装的nprogress.js
import { start, close } from '@/utils/nprogress';

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
        // 判断是否是自定义的错误信息
        if (error.response && error.response.data) {
            return Promise.reject(error.response.data);
        }
        // 没有权限跳转到登录页
        else if (error.response.data.code === 401) {
            location.href = "/login"
        } else {
            // 网络错误等其他情况
            ElMessage.error("请求出错，请重试");
            return Promise.reject(error);
        }
    }
);

export default request;
export {
    uploadUrl, baseURL, uploadOssImage, uploadOssVideo, socketURL
};
