<template>
    <div class="login-container">
        <el-form :model="userinfo" label-width="80px" class="login-form">
            <h3 class="title">注册</h3>
            <!-- 输入用户名 -->
            <el-form-item label="昵称" prop="username">
                <el-input v-model="userinfo.username" placeholder="请输入昵称" clearable></el-input>
            </el-form-item>
            <!-- 输入邮箱 -->
            <el-form-item label="邮箱" prop="email">
                <el-input v-model="userinfo.email" placeholder="请输入邮箱" clearable>
                </el-input>
            </el-form-item>
            <!-- 输入手机号 -->
            <!-- <el-form-item label="手机号" prop="phone">
                <el-input v-model="userinfo.phone" placeholder="请输入手机号" clearable></el-input>
            </el-form-item> -->
            <!-- 输入密码 -->
            <el-form-item label="密码" prop="password">
                <el-input v-model="userinfo.password" type="password" placeholder="请输入密码" :show-password="true"
                    clearable suffix-icon="el-icon-view"></el-input>
            </el-form-item>
            <!-- 输入验证码 -->
            <el-form-item label="验证码" prop="emailCode">
                <div class="input-with-image">
                    <el-input v-model="userinfo.emailCode" placeholder="邮箱验证码"></el-input>
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
</template>

<script setup>
import { onMounted, reactive, ref } from "vue";
import { ElMessage } from "element-plus";
import request from "@/utils/request";
import { useRouter } from "vue-router";

const router = useRouter();

// 注册时候用户填写的信息
const userinfo = ref({
    username: "两人",
    email: "2183999518@qq.com",
    // phone: "18815555555",
    password: "123456",
    emailCode: "",
})
// 
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
            buttonText.value = '获取验证码';
            clearInterval(timer.value);
        }
    }, 1000);

    request.get("/email/" + userinfo.value.email).then((res) => {
        if (res.code == 200) {
            ElMessage.success("验证码发送成功，请注意查收~");
        } else {
            ElMessage.warning("验证码发送失败，请重新发送~");
        }
    })
}

onMounted(() => {

})
// 注册
const register = () => {
    // console.log(userinfo);
    request.post(`/register?emailCode=${userinfo.value.emailCode}`, userinfo.value).then((res) => {
        console.log(res);
        if (res.code == 200) {
            ElMessage.success("注册成功~");
            setTimeout(function () {
                router.push("/login");
            }, 1000);
        } else {
            ElMessage.warning(res.msg);
        }
    }).catch((err) => {
        console.log("err---", err);
        ElMessage.error(err.msg);
    })
}
// 返回登录页面
const backLogin = () => {
    router.push("/login");
}

</script>
<style scoped lang='less'>
.login-container {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 90vh;

    .login-form {
        width: 300px;
        padding: 0 20px 20px 0;
        border-radius: 10px;
        box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px;

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
            width: 85%;
            margin-left: 15%;
        }
    }
}
</style>