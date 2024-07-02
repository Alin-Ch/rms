<template>
    <div>
        <el-card class="box-card">
            <!-- 卡片的头部 -->
            <template #header>
                <div class="card-header">
                    <h1 style="font-size: 20px; font-weight: 600">实名信息</h1>
                </div>
            </template>
            <!-- 实名认证提示部分 -->
            <div class="tip">
                <p class="title">
                    <el-icon>
                        <InfoFilled />
                    </el-icon>
                    <span>
                        完成实名认证并绑定邮箱，才能找回密码，为了不影响后续步骤，建议提前进行实名认证
                    </span>
                </p>
            </div>
            <!-- 卡片身体底部：认证成功的结构 或 未认证的结构 -->
            <!-- 已认证的结构 -->
            <el-descriptions v-if="haveAuth" class="margin-top" :column="2" border style="margin: 20px auto">
                <el-descriptions-item label-align="center">
                    <template #label>
                        <div class="cell-item">
                            <el-icon>
                                <User />
                            </el-icon>
                            用户姓名
                        </div>
                    </template>
                    {{ userInfo.username }}
                </el-descriptions-item>
                <el-descriptions-item label-align="center">
                    <template #label>
                        <div class="cell-item">
                            <el-icon>
                                <Male />
                            </el-icon>
                            性别
                        </div>
                    </template>
                    {{ userInfo.gender }}
                    <!-- {{ userInfo.gender === 1 ? '男' : '女'}} -->
                </el-descriptions-item>
                <el-descriptions-item label-align="center">
                    <template #label>
                        <div class="cell-item">
                            <el-icon>
                                <Iphone />
                            </el-icon>
                            手机号码
                        </div>
                    </template>
                    {{ userInfo.phone }}
                </el-descriptions-item>
                <el-descriptions-item label-align="center">
                    <template #label>
                        <div class="cell-item">
                            <el-icon>
                                <Message />
                            </el-icon>
                            邮箱
                        </div>
                    </template>
                    {{ userInfo.email }}
                </el-descriptions-item>
                <el-descriptions-item label-align="center">
                    <template #label>
                        <div class="cell-item">
                            <el-icon>
                                <Postcard />
                            </el-icon>
                            证件号码
                        </div>
                    </template>
                    {{ userInfo.idCard }}
                </el-descriptions-item>
            </el-descriptions>
            <!-- 未认证的结构 -->
            <el-form v-else style="width: 60%; margin: 20px auto" label-width="80" :model="editUserInfo" ref="form">
                <!-- 头像部分，有些长 -->
                <el-form-item label="头像">
                    <!-- 上传与预览 -->
                    <el-upload :action="uploadUrl" :on-remove="handleRemove" :show-file-list="true" :limit="1"
                        :on-preview="handlePicturePreview" :on-success="successUpload" list-type="picture-card"
                        :file-list="fileList">
                        <el-icon>
                            <Plus />
                        </el-icon>
                    </el-upload>

                    <!-- 图片预览 -->
                    <el-dialog class="previewImg" v-model="avatarVisible">
                        <img w-full :src="dialogImageUrl" alt="预览图片" />
                    </el-dialog>
                </el-form-item>
                <el-form-item label="用户名">
                    <el-input v-model="editUserInfo.username" />
                </el-form-item>
                <el-form-item label="手机号">
                    <el-input v-model="editUserInfo.phone" />
                </el-form-item>
                <el-form-item label="身份证号">
                    <el-input v-model="editUserInfo.idCard" />
                </el-form-item>
                <el-form-item label="邮箱">
                    <el-input v-model="editUserInfo.email" />
                </el-form-item>
                <el-form-item label="性别">
                    <el-select v-model="editUserInfo.gender" placeholder="请选择性别">
                        <el-option label="男" :value="1" />
                        <el-option label="女" :value="0" />
                    </el-select>
                </el-form-item>
                <el-form-item>
                    <el-button type="primary" size="default" @click="submit">提交修改</el-button>
                </el-form-item>
            </el-form>
        </el-card>
    </div>
</template>

<script setup>
import { ref, reactive, toRefs, onBeforeMount, onMounted, watchEffect, computed } from 'vue';
import { useStore } from 'vuex';
import { useRoute, useRouter } from 'vue-router';
import { InfoFilled, User, Postcard, Plus, Iphone, Location, Message, Tickets, Male } from "@element-plus/icons-vue";
import { ElMessage } from 'element-plus';
import request from '@/utils/request'
import { uploadUrl } from '@/utils/request';

const store = useStore();
const route = useRoute();
const router = useRouter();

onMounted(() => {
    getUserInfo()
})

// 用户信息
const haveAuth = ref(false)
const userInfo = ref({});
const getUserInfo = () => {
    const user = JSON.parse(localStorage.getItem("user"))
    if (user.idCard != null) {
        haveAuth.value = true
    }
    userInfo.value = user
    editUserInfo.value = user
    if (user.avatar != null) {
        fileList.value = [{
            url: user.avatar,
            name: user.avatar,
        }];
    }
}

// form表单
let editUserInfo = ref({});
const avatarVisible = ref(false)
const dialogImageUrl = ref('')
const fileList = ref([])
const handleRemove = (file) => {
    const index = fileList.value.indexOf(file);
    if (index !== -1) {
        fileList.splice(index, 1);
    }
}
const handlePicturePreview = (file) => {
    dialogImageUrl.value = file.url
    avatarVisible.value = true
}
// 上传头像成功
const successUpload = (res) => {
    editUserInfo.value.avatar = res.data
}

const submit = () => {
    request.post("/sys/user/update", editUserInfo.value).then((res) => {
        if (res.code == 200) {
            ElMessage.success("修改成功")
            // 存储到本地存储
            localStorage.setItem("user", JSON.stringify(editUserInfo.value))
            haveAuth.value = true
        } else {
            ElMessage.warning("修改失败")
        }
    })
}



</script>
<style scoped lang='less'>
.box-card {
    .tip {
        .title {
            display: flex;
            justify-content: center;
            color: #7f7f7f;

            span {
                margin-left: 10px;
            }
        }
    }

    .previewImg {
        img {
            width: 100%;
            height: 100%;
        }
    }
}
</style>