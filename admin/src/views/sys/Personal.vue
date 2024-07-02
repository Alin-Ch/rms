<template>
    <div class="container">
        <el-card class="box-card">
            <template #header>
                <div class="card-header">
                    <span>个人信息</span>
                    <div>
                        <el-button v-if="!edit" type="primary" @click="editInfo">编辑</el-button>
                        <el-button v-if="edit" type="primary" @click="cancelEdit">退出编辑</el-button>
                        <el-button v-if="edit" type="primary" @click="submitUpdate">保存</el-button>
                    </div>
                </div>
            </template>
            <div class="middle">
                <el-form label-width="100px" :disabled="formDisabled" :model="editUserInfo" style="max-width: 460px">
                    <!-- 头像部分，有些长 -->
                    <el-form-item label="头像">
                        <!-- 上传与预览 -->
                        <el-upload :action="uploadUrl" :on-remove="handleRemove" :show-file-list="true" :limit="1"
                            :on-preview="handlePictureCardPreview" :on-success="successUpload" list-type="picture-card"
                            :file-list="fileList">
                            <el-icon>
                                <Plus />
                            </el-icon>
                        </el-upload>

                        <!-- 图片预览 -->
                        <el-dialog v-model="avatarVisible">
                            <img w-full :src="dialogImageUrl" alt="预览图片" />
                        </el-dialog>
                    </el-form-item>
                    <el-form-item label="用户角色">
                        <el-input v-model="editUserInfo.role.name" disabled readonly />
                    </el-form-item>
                    <el-form-item label="用户名">
                        <el-input v-model="editUserInfo.username" />
                    </el-form-item>
                    <el-form-item label="手机号">
                        <el-input v-model="editUserInfo.phone" />
                    </el-form-item>
                    <el-form-item label="邮箱">
                        <el-input v-model="editUserInfo.email" />
                    </el-form-item>
                    <el-form-item label="性别">
                        <el-select v-model="editUserInfo.gender" placeholder="选择性别" style="width: 80px">
                            <el-option label="男" :value="1" />
                            <el-option label="女" :value="0" />
                        </el-select>
                    </el-form-item>
                    <el-form-item label="地址">
                        <elui-china-area-dht :leave="2" @change="areaChange" v-model="showVal"></elui-china-area-dht>
                    </el-form-item>

                </el-form>
                <!-- 大图预览 -->
                <el-image-viewer v-if="showImgViewer" @close="closeImgViewer" :url-list="imagePreviewUrls"
                    :z-index="3000" :initial-index="initialImgPreviewIndex" />
            </div>
            <!-- <template #footer>底部</template> -->
        </el-card>

    </div>
</template>

<script setup>
import { ref, onMounted, onBeforeMount } from 'vue';
import { Iphone, Location, OfficeBuilding, Tickets, User, Search, Delete, Download, Plus, ZoomIn } from '@element-plus/icons-vue'
import { useStore } from 'vuex';
import { useRoute, useRouter } from 'vue-router';
import request from '@/utils/request'
import { uploadUrl } from '@/utils/request';
// 级联选择城市
import { EluiChinaAreaDht } from 'elui-china-area-dht'
const chinaData = new EluiChinaAreaDht.ChinaArea().chinaAreaflat
const showVal = ref([])
const areaChange = (e) => {
    const one = chinaData[e[0]]
    const two = chinaData[e[1]]
    // const three = chinaData[e[2]]
    editUserInfo.value.cityCodeOne = one.value
    editUserInfo.value.cityCodeTwo = two.value
    // editUserInfo.value.cityCodeThree = three.value
    editUserInfo.value.city = one.label + two.label
}


const router = useRouter();

onBeforeMount(() => {
    // 一定要在挂载之前获取，否则获取不到
    getUserInfo()
})
onMounted(() => { })

// 用户编辑
const edit = ref(false)
const formDisabled = ref(true)
const editInfo = () => {
    formDisabled.value = false;
    edit.value = true;
}
const cancelEdit = () => {
    ElMessageBox.confirm(
        '确认退出修改吗？您所做的修改将不被保存',
        '退出修改', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning',
    }).then(() => {
        edit.value = false;
        formDisabled.value = true;
        getUserInfo()
    }).catch(() => {
    })
}
const submitUpdate = () => {
    request.post("/sys/user/update", editUserInfo.value).then((res) => {
        if (res.code == 200) {
            ElMessage.success("修改成功")
            edit.value = false;
            formDisabled.value = true;
            localStorage.setItem("user", JSON.stringify(editUserInfo.value));
        } else {
            ElMessage.warning("修改失败")
        }
    })
}

// 用户信息
const userInfo = ref(null);
const editUserInfo = ref(null)
const getUserInfo = () => {
    const user = localStorage.getItem('user');
    if (user) {
        userInfo.value = JSON.parse(user);
        editUserInfo.value = JSON.parse(user);
        showVal.value.push(editUserInfo.value.cityCodeOne)
        showVal.value.push(editUserInfo.value.cityCodeTwo)
        // 设置头像
        fileList.value = [{
            url: JSON.parse(user).avatar,
            name: JSON.parse(user).avatar,
        }];
    } else {
        router.push('/login');
    }
}
// 头像部分（上传与预览）
const avatarVisible = ref(false)
const dialogImageUrl = ref('')
const fileList = ref([])
const handleRemove = (file) => {
    // 在这里可以做一些清理工作
    // console.log('handleRemove', file, fileList);
    const index = fileList.value.indexOf(file);
    if (index !== -1) {
        fileList.splice(index, 1);
    }
}
const handlePicturePreview = (file) => {
    dialogImageUrl.value = file.url
    avatarVisible.value = true
    const fileType = file.name.split('.').pop().toLowerCase()
    if (['jpg', 'png', 'jpeg', 'gif'].includes(fileType)) {

    } else {

    }
    // if (fileType === 'jpg' || fileType === 'jpeg' || fileType === 'png' || fileType === 'gif') {
    //     dialogImageUrl.value = file.url
    // } else {
    //     dialogImageUrl.value = ''
    //     ElMessage.error('不支持该文件格式')
    // }
}
// 上传头像成功
const successUpload = (res) => {
    editUserInfo.value.avatar = res.data
}

// 头像大图预览
const initialImgPreviewIndex = ref(0) // 预览打开看到的图片下标
const imagePreviewUrls = ref([]) // 预览图片的下标
const showImgViewer = ref(false)
// 图片预览
const handlePictureCardPreview = (file) => {
    initialImgPreviewIndex.value = 0
    imagePreviewUrls.value.push(file.url)
    showImgViewer.value = true
}
const closeImgViewer = () => {
    showImgViewer.value = false
}


</script>
<style scoped lang='less'>
.container {
    height: auto;
    margin: -5px;

    .box-card {
        width: 600px;
        margin: 0 auto;
    }

    .card-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
}
</style>