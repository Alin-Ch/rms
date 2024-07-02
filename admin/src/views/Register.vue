<template>
    <div class="box">
        <div class="login-container">
            <el-form :model="userinfo" :rules="rules" ref="userForm" label-width="80px" class="login-form">
                <h2 style="text-align: center;padding: 0 0 20px 0;color: #7f7f7f;">注册</h2>
                <!-- 输入用户名 -->
                <el-form-item label="昵称" prop="username">
                    <el-input v-model="userinfo.username" :prefix-icon="User" placeholder="请输入昵称" clearable></el-input>
                </el-form-item>
                <el-form-item label="手机号" prop="phone">
                    <el-input v-model="userinfo.phone" :prefix-icon="Phone" placeholder="请输入手机号" clearable></el-input>
                </el-form-item>
                <!-- 输入邮箱 -->
                <el-form-item label="邮箱" prop="email">
                    <el-input v-model="userinfo.email" :prefix-icon="Message" placeholder="请输入邮箱" clearable>
                    </el-input>
                </el-form-item>
                <!-- 输入手机号 -->
                <!-- <el-form-item label="手机号" prop="phone">
                <el-input v-model="userinfo.phone" placeholder="请输入手机号" clearable></el-input>
            </el-form-item> -->
                <!-- 输入密码 -->
                <el-form-item label="密码" prop="password">
                    <el-input v-model="userinfo.password" :prefix-icon="Lock" type="password" placeholder="请输入密码"
                        :show-password="true" clearable suffix-icon="el-icon-view"></el-input>
                </el-form-item>
                <!-- 输入验证码 -->
                <el-form-item label="验证码" prop="emailCode">
                    <div class="input-with-image">
                        <el-input v-model="userinfo.emailCode" :prefix-icon="Sunrise" placeholder="验证码"></el-input>
                        <!-- 发送验证码 -->
                        <el-button class="getCodeBtn" type="primary" :disabled="disableButton" @click="sendCode">
                            {{ buttonText }}
                        </el-button>
                    </div>
                </el-form-item>
                <!-- 忘记密码与注册 -->
                <el-form-item>
                    <el-button class="backLogin" link @click="backLogin">已有账号?去登录</el-button>
                </el-form-item>

                <!-- 注册按钮 -->
                <el-button class="registerBtn" type="primary" @click="register" :loading="loading">注册</el-button>

            </el-form>
        </div>
    </div>
</template>

<script setup>
import { onMounted, reactive, ref } from "vue";
import { ElMessage } from "element-plus";
import request from "@/utils/request";
import { useRouter } from "vue-router";
import { User, Lock, Message, Sunrise, Phone } from '@element-plus/icons-vue';

const router = useRouter();
const radio1 = ref('1');
// 注册时候用户填写的信息
const userinfo = ref({
    username: "两人",
    email: "2183999518@qq.com",
    // phone: "18815555555",
    password: "123456",
    emailCode: "",
    type: 1
})
const rules = {
    username: [
        { required: true, message: '请输入昵称', trigger: 'blur' }
    ],
    email: [
        { required: true, message: '请输入邮箱', trigger: 'blur' },
        { type: 'email', message: '邮箱格式不正确', trigger: ['blur', 'change'] }
    ],
    phone: [
        { required: true, message: '请输入手机号', trigger: 'blur' },
        { pattern: /^1[3456789]\d{9}$/, message: '手机号格式不正确', trigger: ['blur', 'change'] }
    ],
    password: [
        { required: true, message: '请输入密码', trigger: 'blur' },
        { min: 6, message: '密码长度至少为6位', trigger: ['blur'] },
        // { pattern: /^(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&*])[a-zA-Z\d!@#$%^&*]{6,}$/, message: '密码必须包含数字、字母和特殊字符', trigger: ['blur'] }
    ],
    emailCode: [
        { required: true, message: '请输入验证码', trigger: 'blur' }
    ]
};
const userForm = ref(null);
// 获取验证码的
const disableButton = ref(false);
const buttonText = ref("获取验证码");
const loading = ref(false);
// 计时器
const timer = ref(null);
const remainingTime = ref(60);
// 发送验证码
const sendCode = () => {
    if (!userForm.value.validateField('email')) return;
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

    request.get("/email/" + userinfo.value.email).then((res) => {
        console.log(res);
        if (res.code == 200) {
            ElMessage.success("验证码发送成功，请注意查收~");
        } else {
            ElMessage.warning("验证码发送失败，请重新发送~");
        }
    }).catch((err) => {
        ElMessage.error(err.msg)
    })
}

onMounted(() => {

})
// 注册
const register = () => {
    // 表单验证
    userForm.value.validate((valid) => {
        if (valid) {
            request.post(`/register?emailCode=${userinfo.value.emailCode}`, userinfo.value).then((res) => {
                // console.log(res);
                if (res.code == 200) {
                    ElMessage.success("注册成功~");
                    setTimeout(function () {
                        router.push("/login");
                    }, 1000);
                } else {
                    ElMessage.warning(res.msg);
                }
            }).catch((err) => {
                console.log("err---" + err);
                ElMessage.error(err.msg);
            })
        } else {
            ElMessage.warning("请填写完整信息~");
            return false;
        }
    });
}
// 返回登录页面
const backLogin = () => {
    router.push("/login");
}

</script>
<style scoped lang='less'>
.box {
    width: 100%;
    height: 85vh;
    background-image: url('../assets/login-background.jpg');
    background-repeat: no-repeat;
    background-size: cover;
    padding-top: 7%;

    .login-container {
        display: flex;
        justify-content: center;
        align-items: center;
        // height: 90vh;
        margin: 0 auto;
        width: 400px;
        padding-top: 20px;
        border-radius: 20px;
        background-color: #fff;
        box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px;

        .login-form {
            width: 300px;
            padding: 10px 20px 20px 10px;
            border-radius: 10px;
            // box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px;

            .input-with-image {
                display: flex;
            }

            .input-with-image>* {
                margin-right: 10px;
                /* 可根据需要调整间距 */
            }

            .getCodeBtn {
                width: 85%;
            }

            .backLogin {
                margin-left: 50%;
                color: #3097fe;
            }

            .backLogin:hover {
                color: #8ac5ff;
            }

            .registerBtn {
                width: 80%;
                margin-left: 50px;
            }
        }
    }
}
</style>