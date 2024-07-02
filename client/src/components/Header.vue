<template>
    <div class="container">
        <div class="left">
            <span @click="router.push('/index')">住了么租房平台</span>
        </div>
        <div class="right">
            <div class="item">
                <text @click="router.push('/index')">首页</text>
            </div>
            <div class="item">
                <text @click="router.push('/notice/all')">平台公告</text>
            </div>
            <div class="item">
                <text @click="router.push('/user/order')">我的订单</text>
            </div>
            <div class="item">
                <text @click="router.push('/message/chat')">消息</text>
                <el-badge class="mark" :value="unreadCount" />
            </div>
            <div class="block">
                <el-dropdown v-if="avatar">
                    <el-avatar :size="60" @error="errorHandler">
                        <img :src="avatar" />
                    </el-avatar>
                    <template #dropdown>
                        <el-dropdown-menu>
                            <el-dropdown-item @click="router.push('/user')">个人中心</el-dropdown-item>
                            <el-dropdown-item @click="router.push('/user/favorite')">我的收藏</el-dropdown-item>
                            <el-dropdown-item @click="router.push('/user/history')">浏览历史</el-dropdown-item>
                            <el-dropdown-item @click="becomeMerchant">商家入驻</el-dropdown-item>
                            <el-dropdown-item @click="loginOut">退出登录</el-dropdown-item>
                        </el-dropdown-menu>
                    </template>
                </el-dropdown>
                <el-button v-else :icon="UserFilled" type="primary" size="large" @click="router.push('/login')"
                    round>去登录</el-button>
            </div>
        </div>
        <!-- dialog弹出框 -->
        <el-dialog v-model="dialogVisible" title="房东入驻申请" width="60%" draggable>
            <el-form label-width="100px" :model="editInfo">
                <el-form-item label="标题">
                    <el-input v-model="editInfo.title" />
                </el-form-item>
                <el-form-item label="证明材料">
                    <span style="font-size: 11px;color:#7f7f7f">请上传房产证等相关证明</span>
                    <!-- 将 editInfo.content 通过 prop 传递给子组件 -->
                    <TextEditor v-if="dialogVisible" v-model="editInfo.content" />
                </el-form-item>
            </el-form>
            <template #footer>
                <span class="dialog-footer">
                    <el-button @click="handleCancel">取消</el-button>
                    <el-button type="primary" @click="handleSubmit">
                        提交申请
                    </el-button>
                </span>
            </template>
        </el-dialog>
    </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useStore } from 'vuex';
import { useRoute, useRouter } from 'vue-router';
import { ArrowDown, UserFilled } from '@element-plus/icons-vue'
import { ElMessage } from 'element-plus';
import request from '@/utils/request'
import TextEditor from './TextEditor.vue'

const store = useStore();
const route = useRoute();
const router = useRouter();

const errorHandler = () => true
const username = ref("");
const avatar = ref("");
const unreadCount = ref(0);

// 获取未读信息数量
const getUnreadMessageCount = () => {
    if (!localStorage.getItem("user")) {
        return
    }
    const user_id = localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")).id : ""
    request.get("/sys/message/unread/count/" + user_id).then(res => {
        // console.log(res);
        unreadCount.value = res.data;
    })
}
// 获取用户信息
const getUserInfo = () => {
    if (!localStorage.getItem("user")) {
        return
    }
    request.get("/sys/userInfo").then(res => {
        // console.log(res.data);
        if (res.code == "200") {
            sessionStorage.setItem("user_id", res.data.id);
            username.value = res.data.username;
            avatar.value = res.data.avatar;
            sessionStorage.setItem("user", JSON.stringify(res.data))
            // 写到personal页面的时候，发现使用了localStorage，所以这里用localStorage吧
            localStorage.setItem("user", JSON.stringify(res.data))
            if (res.data.role == "admin") {
                sessionStorage.setItem("user_role", "admin");
            } else {
                sessionStorage.setItem("user_role", "user");
            }
        }
    })
}
// 退出登录
const loginOut = () => {
    request.post("/logout").then(res => {
        console.log(res);
        if (res.code == "200") {
            // 清除保存的信息
            localStorage.removeItem("token")
            localStorage.removeItem("user")
            ElMessage.success("退出成功");
            avatar.value = ""
            // router.push("/login");
        }
    })
}
onMounted(() => {
    getUserInfo()
    getUnreadMessageCount()
})
// 商家入驻
const dialogVisible = ref(false);
const editInfo = ref({
    userId: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")).id : null
})
const becomeMerchant = () => {
    dialogVisible.value = true
}
const handleCancel = () => {
    dialogVisible.value = false
}
const handleSubmit = () => {
    if (!editInfo.value.userId) {
        return
    }
    request.post("/sys/apply/save", editInfo.value).then((res) => {
        if (res.code == 200) {
            ElMessage.success('申请成功!');
            ElMessage.success('等待管理员审核~');
            handleCancel();
        } else {
            ElMessage.warning(res.msg);
        }
    })
}

</script>
<style scoped lang='less'>
.container {
    width: 100%;
    height: 60px;
    // background: #f0f0f0;
    display: flex;
    align-items: center;
    border-bottom: 1px solid #e2e2e2;
    box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px;
    background-color: #fff;

    .left {
        flex: 3;
        text-align: center;
        font-size: 27px;
        font-weight: bold;
        font-family: 'Courier New', Courier, monospace;

        span:hover {
            cursor: pointer;
        }
    }

    .right {
        flex: 7;
        display: flex;
        align-items: center;
        justify-content: flex-end;
        margin-right: 100px;

        .item {
            // border-bottom: 1px solid #e7e5e5;
            // width: 80px;
            // text-align: center;
            margin: 0 30px;
            // display: flex;
            // align-items: center;
        }

        .item :hover {
            cursor: pointer;
            color: #409EFF;
            // font-weight: bold;
        }

        .block {
            margin: 0 20px;
        }
    }
}

:deep(.el-tooltip__trigger:focus-visible) {
    outline: unset;
}
</style>