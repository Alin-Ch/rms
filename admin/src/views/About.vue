<template>
    <div class="container">
        <el-form :model="form" :rules="rules" ref="formRef" label-width="100px" class="form">
            <h3 class="title">用户名登录</h3>
            <!-- 用户名 -->
            <el-form-item label="用户名" prop="username">
                <el-input v-model="form.username" :prefix-icon="User" placeholder="请输入用户名" clearable></el-input>
            </el-form-item>
            <!-- 手机号 -->
            <el-form-item label="手机号" prop="phone">
                <el-input v-model="form.phone" :prefix-icon="Phone" placeholder="请输入手机号" clearable></el-input>
            </el-form-item>
            <!-- 邮箱 -->
            <el-form-item label="邮箱" prop="email">
                <el-input v-model="form.email" :prefix-icon="Message" placeholder="请输入邮箱" clearable>
                </el-input>
            </el-form-item>
            <!-- 密码 -->
            <el-form-item label="密码" prop="password">
                <el-input v-model="form.password" :prefix-icon="Lock" type="password" placeholder="请输入密码"
                    :show-password="true" clearable suffix-icon="el-icon-view"></el-input>
            </el-form-item>
            <!-- 确认密码 -->
            <el-form-item label="确认密码" prop="confirmPassword">
                <el-input v-model="form.confirmPassword" :prefix-icon="Lock" type="password" placeholder="请确认密码"
                    :show-password="true" clearable suffix-icon="el-icon-view"></el-input>
            </el-form-item>
            <!-- 邮箱验证码 -->
            <el-form-item label="邮箱验证码" prop="emailCode">
                <div class="item">
                    <el-input class="item-left" v-model="form.emailCode" :prefix-icon="Sunrise"
                        placeholder="验证码"></el-input>
                    <el-button class="item-right" type="primary" :disabled="disableButton" @click="sendCode">
                        {{ buttonText }}
                    </el-button>
                </div>
            </el-form-item>
            <!-- 图片验证码 -->
            <el-form-item label="图片验证码" prop="IDcode">
                <div class="item">
                    <el-input class="item-left" v-model="form.IDcode" :prefix-icon="Sunrise"
                        placeholder="图片验证码"></el-input>
                    <div class="item-right">
                        <img :src="captchaUrl" @click="getCaptcha()" width="120px" height="33px" />
                    </div>
                </div>
            </el-form-item>
            <!-- 底部小字 -->
            <el-form-item>
                <div class="item">
                    <el-button class="item-left" link @click="router.push('/forget')">找回密码</el-button>
                    <el-button class="item-right" link @click="router.push('/login')">已有账号?去登录</el-button>
                </div>
            </el-form-item>

            <el-form-item>
                <el-button class="submit" round size="large" type="primary" @click="submit" :loading="loading">
                    提交
                </el-button>
            </el-form-item>


        </el-form>
    </div>
</template>



<script setup>
import { ref, onMounted } from 'vue';
import { useRouter } from 'vue-router';
import request from '@/utils/request';
import { baseURL } from '@/utils/request';
import { User, Lock, Message, Sunrise, Phone } from '@element-plus/icons-vue';
import qs from 'qs';
import axios from 'axios';
import { ElMessage } from 'element-plus';

const router = useRouter();

onMounted(() => {
    getCaptcha()
})
// 提交
const submit = () => {
    formRef.value.validate((valid) => {
        if (valid) {
            ElMessage.success("校验通过！")
            loading.value = true;
            request.post(`/register?emailCode=${form.value.emailCode}`, form.value).then((res) => {
                // request.post(`/updatePassword?emailCode=${userinfo.value.emailCode}`, userinfo.value).then((res) => {
                // request.post(`${baseURL}/login?` + qs.stringify(user)).then((res) => {
                // 这里自己写后续的逻辑
                if (res.code == 200) {
                    ElMessage.success("注册成功");
                    router.push("/login");
                } else {
                    ElMessage.error(res.msg);
                }
            }).finally(() => {
                loading.value = false;
            })
        }
    })
}

// 表单与校验
const formRef = ref(null)
const form = ref({
    username: 'test',
    phone: '18888888888',
    email: '2183999518@qq.com',
    password: '123456',
    confirmPassword: '123456',
    emailCode: '',
    IDcode: '',
})
const rules = {
    username: [
        { required: true, message: '请输入用户名', trigger: 'blur' }
    ],
    email: [
        { required: true, message: '请输入邮箱', trigger: 'blur' },
        // { type: 'email', message: '邮箱格式不正确', trigger: ['blur', 'change'] },
        { pattern: /^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/, message: '邮箱格式不正确', trigger: ['blur', 'change'] }
    ],
    phone: [
        { required: true, message: '请输入手机号', trigger: 'blur' },
        { pattern: /^(13[0-9]|14[01456879]|15[0-35-9]|16[2567]|17[0-8]|18[0-9]|19[0-35-9])\d{8}$/, message: '手机号格式不正确', trigger: ['blur', 'change'] }
    ],
    password: [
        { required: true, message: '请输入密码', trigger: 'blur' },
        { min: 6, message: '密码长度至少为6位', trigger: ['blur'] },
        // { pattern: /^(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&*])[a-zA-Z\d!@#$%^&*]{6,}$/, message: '密码必须包含数字、字母和特殊字符', trigger: ['blur'] }
    ],
    confirmPassword: [
        { required: true, message: '请确认密码', trigger: 'blur' },
        { validator: validateConfirmPassword, trigger: 'blur' }
    ],
    emailCode: [
        { required: true, message: '请输入邮箱验证码', trigger: 'blur' }
    ],
    IDcode: [
        { required: true, message: '请输入图片验证码', trigger: 'blur' }
    ],
}
function validateConfirmPassword(rule, value, callback) {
    if (value === '') {
        callback(new Error('请再次输入密码'));
    } else if (value !== form.value.password) {
        callback(new Error('两次输入密码不一致'));
    } else {
        callback();
    }
}


// 图片验证码
var captchaUrl = ref("")
const getCaptcha = () => {
    request.get("/captcha").then((res) => {
        form.value.token = res.data.token
        captchaUrl.value = res.data.captchaImg
    })
}
// 邮箱验证码
const disableButton = ref(false);
const buttonText = ref("获取验证码");
const loading = ref(false);
// 计时器
const timer = ref(null);
const remainingTime = ref(60);
// 发送验证码
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
            remainingTime.value = 60;
            buttonText.value = '获取验证码';
            clearInterval(timer.value);
        }
    }, 1000);

    request.get("/email/" + form.value.email).then((res) => {
        if (res.code == 200) {
            ElMessage.success("验证码发送成功，请注意查收~");
        } else {
            ElMessage.warning("验证码发送失败，请重新发送~");
        }
    })
}

</script>
<style scoped lang='less'>
.container {
    width: 100vw;
    height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    color: #7f7f7f;

    .form {
        background-color: pink;
        box-shadow: rgba(149, 157, 165, 0.2) 0px 8px 24px;
        padding: 20px;

        // .el-form-item {
        //     /deep/ * {
        //         height: 45px;
        //         display: flex;
        //         justify-content: center;
        //         align-items: center;
        //         background-color: red;
        //     }
        // }


        .title {
            width: 100%;
            height: 60px;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 1.5em;
            color: #7f7f7f;
        }

        .item {
            width: 100%;
            display: flex;
            justify-content: space-between;
            align-items: center;

            .item-left {
                font-size: 12px;
                width: 150px;

                // 深度选择器
                // :deep(.el-input__wrapper) {
                //     width: 90%;
                //     height: 45px;
                //     border: 1px solid white;
                //     background-color: rgba(255, 255, 255, 0.5);
                //     border-radius: 10px;
                //     font-size: inherit;
                //     padding-left: 20px;
                //     outline: none;
                // }
            }

            .item-right {
                font-size: 12px;
                width: 150px;
                display: flex;
                justify-content: center;
                align-items: center;
            }
        }

        .submit {
            width: 200px;
        }
    }
}
</style>