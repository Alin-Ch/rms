<template>
    <div class="container">
        <!-- 顶部 -->
        <Header />
        <!-- 内容部分 -->
        <div class="user">
            <!-- 左侧导航区域 -->
            <div class="menu">
                <div class="top">
                    <el-icon style="margin-right: 5px">
                        <House />
                    </el-icon>/
                    <span style="color: #7f7f7f; margin-left: 5px">个人中心</span>
                </div>
                <el-menu :default-active="$route.path" class="el-menu-vertical-demo">
                    <el-menu-item index="/user/certification" @click="goUser('/user/certification')">
                        <el-icon>
                            <CreditCard />
                        </el-icon>
                        <span>实名认证</span>
                    </el-menu-item>
                    <el-menu-item index="/user/order" @click="goUser('/user/order')">
                        <el-icon>
                            <Memo />
                        </el-icon>
                        <span>缴费订单</span>
                    </el-menu-item>
                    <el-menu-item index="/user/profile" @click="goUser('/user/profile')">
                        <el-icon>
                            <User />
                        </el-icon>
                        <span>账号信息</span>
                    </el-menu-item>
                    <el-menu-item index="/user/favorite" @click="goUser('/user/favorite')">
                        <el-icon>
                            <Star />
                        </el-icon>
                        <span>我的收藏</span>
                    </el-menu-item>
                    <el-menu-item index="/user/history" @click="goUser('/user/history')">
                        <el-icon>
                            <View />
                        </el-icon>
                        <span>浏览历史</span>
                    </el-menu-item>
                    <!-- <el-menu-item index="/user/feedback" @click="goUser('/user/feedback')">
                        <el-icon>
                            <EditPen />
                        </el-icon>
                        <span>意见反馈</span>
                    </el-menu-item>
                    <el-menu-item index="/user/tips" @click="goUser('/user/tips')">
                        <el-icon>
                            <ChatRound />
                        </el-icon>
                        <span>消息通知</span>
                    </el-menu-item> -->
                </el-menu>
            </div>
            <!-- 右侧展示会员中心的二级路由组件 -->
            <div class="content">
                <router-view></router-view>
            </div>
        </div>
    </div>
</template>

<script setup>
import { ref, reactive, toRefs, onBeforeMount, onMounted, watchEffect, computed } from 'vue';
import { useStore } from 'vuex';
import { useRoute, useRouter } from 'vue-router';
import Header from '@/components/Header.vue';
import Footer from '@/components/Footer.vue';
import { CreditCard, Memo, User, InfoFilled, EditPen, House, ChatRound, View, Star } from "@element-plus/icons-vue";

const store = useStore();
const route = useRoute();
const router = useRouter();

onMounted(() => {

})
// 路由跳转
const goUser = (path) => {
    router.push({ path: path });
};

</script>
<style scoped lang='less'>
.user {
    display: flex;
    justify-content: space-around;
    width: 85%;
    margin: 20px auto;
    padding: 20px 0;

    .menu {
        flex: 2;
        display: flex;
        flex-direction: column;
        align-items: center;

        .el-menu-vertical-demo {
            margin-top: 10px;
        }
    }

    .content {
        flex: 8;
    }
}
</style>