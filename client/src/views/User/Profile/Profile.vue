<template>
    <div>
        <el-descriptions class="margin-top" :column="2" border style="margin: 20px auto">
            <template #extra>
                <el-button type="primary" @click="edit">修改信息</el-button>
            </template>
            <el-descriptions-item label-align="center">
                <template #label>
                    <div class="cell-item">
                        <el-icon>
                            <User />
                        </el-icon>
                        用户头像
                    </div>
                </template>
                <div class="block">
                    <el-image style="width: 100px; height: 100px; " :preview-teleported="true" :src="userInfo.avatar"
                        :preview-src-list="[userInfo.avatar]" fit="fill">
                    </el-image>
                </div>
            </el-descriptions-item>
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
                            <User />
                        </el-icon>
                        年龄
                    </div>
                </template>
                {{ userInfo.age }}
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
                <!-- {{ userInfo.gender }} -->
                {{ userInfo.gender === 1 ? '男' : '女' }}
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
                            <Clock />
                        </el-icon>
                        最后登录
                    </div>
                </template>
                {{ userInfo.lastLogin }}
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
        <!-- dialog弹出框 -->
        <el-dialog v-model="dialogVisible" title="编辑" width="40%" draggable>
            <el-scrollbar height="60vh">
                <span>
                    <el-form label-width="100px" :model="editUserInfo" style="max-width: 460px">
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
                            <el-input v-model="editUserInfo.id_card" />
                        </el-form-item>
                        <el-form-item label="邮箱">
                            <el-input v-model="editUserInfo.email" />
                        </el-form-item>
                        <el-form-item label="年龄">
                            <el-input v-model="editUserInfo.age" />
                        </el-form-item>
                        <el-form-item label="性别">
                            <el-select v-model="editUserInfo.gender" placeholder="请选择性别">
                                <el-option label="男" :value="1" />
                                <el-option label="女" :value="0" />
                            </el-select>
                        </el-form-item>
                    </el-form>
                </span>
            </el-scrollbar>

            <template #footer>
                <span class="dialog-footer">
                    <el-button @click="dialogVisible = false">取消</el-button>
                    <el-button type="primary" @click="submit">
                        确认
                    </el-button>
                </span>
            </template>
        </el-dialog>
    </div>
</template>

<script setup>
import { ref, reactive, toRefs, onBeforeMount, onMounted, watchEffect, computed } from 'vue';
import { InfoFilled, User, Postcard, Plus, Iphone, Location, Message, Tickets, Male, Clock } from "@element-plus/icons-vue";
import { useStore } from 'vuex';
import { useRoute, useRouter } from 'vue-router';
import request from '@/utils/request'
import { ElMessage } from 'element-plus';
import { uploadUrl } from '@/utils/request';

const store = useStore();
const route = useRoute();
const router = useRouter();

onMounted(() => {
    getUserInfo()
})
// 用户信息
var params = ref({
    pageNum: 1,
    pageSize: 5
})
const userInfo = ref({});
const getUserInfo = () => {
    const user = JSON.parse(localStorage.getItem("user"))
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
// 提交修改
const submit = () => {
    request.post("/sys/user/update", editUserInfo.value).then((res) => {
        if (res.code == 200) {
            ElMessage.success("修改成功")
            // 存储到本地存储
            localStorage.setItem("user", JSON.stringify(editUserInfo.value))
            dialogVisible.value = false
            getUserInfo()
        } else {
            ElMessage.warning("修改失败")
        }
    })
}

// 编辑
const dialogVisible = ref(false)
const edit = () => {
    const originUser = { ...userInfo.value }; // 创建 row 的副本
    dialogVisible.value = true;
    editUserInfo.value = originUser;
    if (userInfo.value.avatar != null) {
        fileList.value = [{
            url: userInfo.value.avatar,
            name: userInfo.value.avatar,
        }];
    }
};

</script>
<style scoped lang='less'>
.previewImg {
    img {
        width: 100%;
        height: 100%;
    }
}
</style>