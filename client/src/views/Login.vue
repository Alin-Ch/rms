<template>
    <div class="box">

        <div class="login-container">
            <el-tabs v-model="loginType" class="demo-tabs" @tab-click="loginTypeChange" stretch>
                <!-- 手机号登录 -->
                <el-tab-pane label="用户名登录" name="username">
                    <el-form :model="loginForm" label-width="80px" class="login-form">
                        <h3 class="title">用户名登录</h3>
                        <!-- 输入用户名 -->
                        <el-form-item label="用户名" prop="username" :rules="[{ required: true, message: '用户名不能为空' },]">
                            <el-input v-model="loginForm.username" :prefix-icon="Iphone" placeholder="请输入用户名"
                                clearable></el-input>
                        </el-form-item>
                        <!-- 输入密码 -->
                        <el-form-item label="密码" prop="password" :rules="[{ required: true, message: '密码不能为空' },]">
                            <el-input v-model="loginForm.password" :prefix-icon="Lock" type="password"
                                placeholder="请输入密码" :show-password="true" clearable
                                suffix-icon="el-icon-view"></el-input>
                        </el-form-item>
                        <!-- 输入验证码 -->
                        <el-form-item label="验证码" prop="IDcode" :rules="[{ required: true, message: '验证码不能为空' },]">
                            <div class="input-with-image">
                                <el-input v-model="loginForm.IDcode" :prefix-icon="Sunrise" placeholder=""></el-input>
                                <!-- 设置验证码图片 -->
                                <img :src="captchaUrl" @click="getVerCode()" width="120px" height="33px" />
                            </div>
                        </el-form-item>
                        <!-- 忘记密码与注册 -->
                        <el-form-item>
                            <el-button link type="primary" @click="forgetPassword">忘记密码</el-button>
                            <el-button link type="primary" style="margin-left: 30%;" @click="register">注册</el-button>
                        </el-form-item>

                        <!-- 登录按钮 -->
                        <el-button class="loginBtn" type="primary" @click="loginByUsername"
                            :loading="loading">登录</el-button>

                    </el-form>
                </el-tab-pane>
                <!-- 手机号登录 -->
                <el-tab-pane label="手机号登录" name="phone">
                    <el-form :model="loginForm" label-width="80px" class="login-form">
                        <h3 class="title">手机号登录</h3>
                        <!-- 输入手机号 -->
                        <el-form-item label="手机号" prop="phone" :rules="[{ required: true, message: '手机号不能为空' },]">
                            <el-input v-model="loginForm.phone" :prefix-icon="Iphone" placeholder="请输入手机号"
                                clearable></el-input>
                        </el-form-item>
                        <!-- 输入密码 -->
                        <el-form-item label="密码" prop="password" :rules="[{ required: true, message: '密码不能为空' },]">
                            <el-input v-model="loginForm.password" :prefix-icon="Lock" type="password"
                                placeholder="请输入密码" :show-password="true" clearable
                                suffix-icon="el-icon-view"></el-input>
                        </el-form-item>
                        <!-- 输入验证码 -->
                        <el-form-item label="验证码" prop="IDcode" :rules="[{ required: true, message: '验证码不能为空' },]">
                            <div class="input-with-image">
                                <el-input v-model="loginForm.IDcode" :prefix-icon="Sunrise" placeholder=""></el-input>
                                <!-- 设置验证码图片 -->
                                <img :src="captchaUrl" @click="getVerCode()" width="120px" height="33px" />
                            </div>
                        </el-form-item>
                        <!-- 忘记密码与注册 -->
                        <el-form-item>
                            <el-button link type="primary" @click="forgetPassword">忘记密码</el-button>
                            <el-button link type="primary" style="margin-left: 30%;" @click="register">注册</el-button>
                        </el-form-item>

                        <!-- 登录按钮 -->
                        <el-button class="loginBtn" type="primary" @click="loginByPhone"
                            :loading="loading">登录</el-button>

                    </el-form>
                </el-tab-pane>

                <!-- 邮箱登录 -->
                <el-tab-pane label="邮箱登录" name="email">
                    <el-form :model="loginForm" label-width="80px" class="login-form">
                        <h3 class="title">邮箱登录</h3>
                        <!-- 输入邮箱 -->
                        <el-form-item label="邮箱" prop="email" :rules="[{ required: true, message: '邮箱不能为空' },]">
                            <el-input v-model="loginForm.email" :prefix-icon="Message" placeholder="请输入邮箱"
                                clearable></el-input>
                        </el-form-item>
                        <!-- 输入验证码 -->
                        <el-form-item label="验证码" prop="emailCode" :rules="[{ required: true, message: '验证码不能为空' },]">
                            <div class="input-with-image">
                                <el-input v-model="loginForm.emailCode" :prefix-icon="Sunrise"
                                    placeholder="邮箱验证码"></el-input>
                                <!-- 发送验证码 -->
                                <el-button class="getCodeBtn" type="primary" :disabled="disableButton"
                                    @click="sendCode">
                                    {{ buttonText }}
                                </el-button>
                            </div>
                        </el-form-item>
                        <!-- 忘记密码与注册 -->
                        <el-form-item class="tips custom-class">
                            <el-button link type="primary" @click="forgetPassword">忘记密码</el-button>
                            <el-button link type="primary" style="margin-left: 30%;" @click="register">注册</el-button>
                        </el-form-item>

                        <!-- 登录按钮 -->
                        <el-button class="loginBtn" type="primary" @click="loginByEmail"
                            :loading="loading">登录</el-button>

                    </el-form>
                </el-tab-pane>
            </el-tabs>

        </div>
    </div>

</template>

<script setup>
import { ref, reactive, onMounted } from 'vue';
import { useRouter } from 'vue-router';
import { useStore } from 'vuex';
import request from '@/utils/request';
import { baseURL } from '@/utils/request';
import { Iphone, Lock, Message, Sunrise } from '@element-plus/icons-vue';
import qs from 'qs';
import axios from 'axios';

const router = useRouter();
const store = useStore();

const loginForm = ref({
    username: "租户-梅兰竹菊",
    phone: "18888888888",
    email: "2183999518@qq.com",
    password: '123456',
    verCode: "",
    IDcode: "",
    emailCode: "",
    token: "",
})
var captchaUrl = ref("")
var loading = ref(false);
const dialogVisible = ref(false)

// 登录模式
const loginType = ref("username")

onMounted(() => {
    getVerCode()
})
// 图片验证码
const getVerCode = () => {
    request.get("/captcha").then((res) => {
        loginForm.value.token = res.data.token
        captchaUrl.value = res.data.captchaImg
    })
}
// 邮箱验证码--计时器
const disableButton = ref(false);
const buttonText = ref("获取验证码");
const timer = ref(null);
const remainingTime = ref(60);
const sendCode = () => {
    disableButton.value = true;
    buttonText.value = `${remainingTime.value} 秒`;
    // 倒计时60秒
    timer.value = setInterval(() => {
        if (remainingTime.value > 1) {
            remainingTime.value--;
            buttonText.value = `${remainingTime.value} 秒`;
        } else {
            disableButton.value = false;
            buttonText.value = '获取验证码';
            clearInterval(timer.value);
        }
    }, 1000);

    request.get("/user/email/" + loginForm.value.email).then((res) => {
        if (res.code == 200) {
            ElMessage.success("验证码已发送")
        } else {
            ElMessage.warning("验证码发送失败,请重试")
        }
    })
}
// 选择登录类型
const loginTypeChange = (e) => {
    // console.log(e);
}
// 用户名密码登录
const loginByUsername = () => {
    var user = {
        username: loginForm.value.username,
        password: loginForm.value.password,
        IDcode: loginForm.value.IDcode,
        token: loginForm.value.token
    }
    loading.value = true
    // 发请求
    axios.post(`${baseURL}/login?` + qs.stringify(user)).then((res) => {
        // console.log(res);
        loading.value = false
        if (res.data.code == 200) {
            // 存储token
            const jwt = res.headers['authorization']
            localStorage.setItem('token', jwt);
            localStorage.setItem('user', JSON.stringify(res.data.data))
            ElMessage({
                message: '登陆成功',
                type: 'success',
            })
            loading.value = false
            //登录成功后跳转系统首页
            setTimeout(() => {
                router.push('/');
            }, 500)
        } else {
            // 重新获取验证码
            getVerCode()
            loginForm.value.verCode = ""
            ElMessage.error(res.data.msg)
            loading.value = false
        }
    }).catch((err) => {
        loading.value = false
        ElMessage({
            message: err.data.msg,
            type: 'error',
        })
    })
};
// 手机号登录
const loginByPhone = () => {
    var user = {
        phone: loginForm.value.phone,
        password: loginForm.value.password,
        IDcode: loginForm.value.IDcode
    }
    loading.value = true

    request.post("/login?" + qs.stringify(user)).then((res) => {
        console.log("---", res);
        return
        loading.value = false
        if (res.code == 200) {
            // 将用户信息存到本地存储
            localStorage.setItem('user', JSON.stringify(res.data));
            ElMessage({
                message: '登陆成功',
                type: 'success',
            })
            loading.value = false
            //登录成功后跳转系统首页
            setTimeout(() => {
                router.push('/');
            }, 500)
        } else {
            // 重新获取验证码
            getVerCode()
            loginForm.value.verCode = ""
            ElMessage.error(res.msg)
            loading.value = false
        }
    }).catch((err) => {
        console.log(err);
        loading.value = false
        ElMessage({
            message: err,
            type: 'warning',
        })

    })
};
// 邮箱登录
const loginByEmail = () => {
    var user = {
        email: loginForm.value.email,
        emailCode: loginForm.value.emailCode
    }
    loading.value = true
    request.post("/user/login/email", user).then((res) => {
        loading.value = false
        if (res.code == 200) {
            // 将用户信息存到本地存储
            localStorage.setItem('user', JSON.stringify(res.data));
            ElMessage.success("登录成功！欢迎回来~")
            setTimeout(() => {
                router.push('/')
            }, 1000)
        } else {
            ElMessage.warning(res.msg)
        }
    }).catch((err) => {
        loading.value = false
        ElMessage({
            message: err.msg,
            type: 'warning',
        })
    })
}
// 注册
const register = () => {
    router.push('/register')
}
// 忘记密码
const forgetPassword = () => {
    router.push('/forget')
}

</script>

<style scoped>
.box {
    width: 100%;
    height: 85vh;
    background-image: url('../assets/login-background.jpg');
    background-repeat: no-repeat;
    background-size: cover;
    padding-top: 7%;
}

.login-container {
    display: flex;
    justify-content: center;
    align-items: flex-start;
    width: 400px;
    height: 400px;
    background-color: #fff;
    border-radius: 20px;
    box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px;
    padding: 20px 0 0 0;
    margin: 0 auto;
}

.login-form {
    width: 300px;
    padding: 10px 20px 20px 0;
    border-radius: 10px;
    /* box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px; */
}

.input-with-image {
    display: flex;
}

.input-with-image>* {
    margin-right: 10px;
    /* 可根据需要调整间距 */
}


.title {
    width: 100%;
    height: 40px;
    line-height: 40px;
    font-size: 20px;
    font-weight: 600;
    text-align: center;
    display: none;
}

.loginBtn {
    width: 85%;
    margin-left: 15%;
}

.getCodeBtn {
    width: 85%;
}

/* 顶部tab */
.demo-tabs>.el-tabs__content {
    padding: 32px;
    color: #6b778c;
    font-size: 32px;
    font-weight: 600;
}
</style>