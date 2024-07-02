<template>
    <div class="box">
        <div class="login-container">
            <el-form :model="userinfo" label-width="80px" class="login-form" ref="userForm">
                <h2 style="text-align: center;padding: 0 0 20px 0;color: #7f7f7f;">忘记密码</h2>
                <el-form-item label="邮箱" prop="email" :rules="[
                { required: true, message: '请输入邮箱', trigger: 'blur' },
                { type: 'email', message: '邮箱格式不正确', trigger: ['blur', 'change'] }]">
                    <el-input v-model="userinfo.email" :prefix-icon="Message" placeholder="请输入邮箱" clearable></el-input>
                </el-form-item>
                <el-form-item label="新密码" prop="password" :rules="[
                { required: true, message: '请输入新密码', trigger: 'blur' },
                { min: 6, message: '密码长度至少为6位', trigger: 'blur' }]">
                    <el-input v-model="userinfo.password" :prefix-icon="Lock" type="password" placeholder="请输入新密码"
                        :show-password="true" clearable suffix-icon="el-icon-view"></el-input>
                </el-form-item>
                <el-form-item label="确认密码" prop="confirmPassword" :rules="[
                { required: true, message: '请再次输入密码', trigger: 'blur' },
                { validator: checkPassword, trigger: 'blur' }]">
                    <el-input v-model="userinfo.confirmPassword" :prefix-icon="Lock" type="password"
                        placeholder="请再次输入密码" :show-password="true" clearable suffix-icon="el-icon-view"></el-input>
                </el-form-item>
                <el-form-item label="验证码" prop="emailCode" :rules="[
                { required: true, message: '请输入验证码', trigger: 'blur' },
                { min: 4, message: '验证码至少为4位', trigger: 'blur' }]">
                    <div class="input-with-image">
                        <el-input v-model="userinfo.emailCode" :prefix-icon="Sunrise"></el-input>
                        <el-button class="getCodeBtn" type="primary" :disabled="disableButton" @click="sendCode">
                            {{ buttonText }}
                        </el-button>
                    </div>
                </el-form-item>
                <el-form-item>
                    <el-button class="backLogin" link @click="backLogin">找到密码了,去登录</el-button>
                </el-form-item>
                <el-button class="registerBtn" type="primary" @click="register" :loading="loading">修改密码</el-button>
            </el-form>
        </div>
    </div>
</template>

<script setup>
import { onMounted, reactive, ref } from "vue";
import { ElMessage } from "element-plus";
import request from "@/utils/request";
import { useRouter } from "vue-router";
import { Iphone, Lock, Message, Sunrise } from '@element-plus/icons-vue';

const router = useRouter()


// 注册时候用户填写的信息
const userinfo = ref({
    email: "2183999518@qq.com",
    // phone: "18815555555",
    password: "123456",
    // 再次输入密码
    confirmPassword: "123456",
    emailCode: "",
})
// 校验
const checkPassword = (rule, value, callback) => {
    // console.log(value);
    if (value !== userinfo.value.password) {
        callback(new Error('两次输入密码不一致'));
    } else {
        callback();
    }
};
// 计时器 与 发送验证码
const disableButton = ref(false);
const buttonText = ref("获取验证码");
const loading = ref(false);
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

    request.get("/email/" + userinfo.value.email).then((res) => {
        if (res.code == 200) {
            ElMessage.success("验证码已发送")
        } else {
            ElMessage.error("验证码发送失败,请重试")
        }
    })
}

onMounted(() => {

})
// 修改密码
const userForm = ref(null);
const register = () => {
    userForm.value.validate((valid) => {
        if (valid) {
            // 执行修改密码逻辑
            // console.log('密码修改成功', userinfo.value);
            loading.value = true;
            setTimeout(() => {
                // 发请求
                request.post(`/updatePassword?emailCode=${userinfo.value.emailCode}`, userinfo.value).then((res) => {
                    // console.log(res);
                    loading.value = false;
                    if (res.code == 200) {
                        ElMessage.success("修改成功！快去登录吧~");
                        setTimeout(() => {
                            router.push("/login")
                        }, 1000)
                    } else {
                        ElMessage.warning(res.msg);
                    }
                }).catch((err) => {
                    loading.value = false;
                    ElMessage.error(res.msg + "修改失败！");
                });
            }, 2000);
        } else {
            console.log('表单校验未通过');
            return false;
        }
    });
    return

}
// 返回登录
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
        margin: 0 auto;
        width: 400px;
        padding-top: 20px;
        border-radius: 20px;
        background-color: #fff;
        box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px;

        .login-form {
            width: 300px;
            padding: 0 20px 20px 0;
            border-radius: 10px;
            // box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px;

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
                margin-left: 45%;
                color: #409EFF;
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