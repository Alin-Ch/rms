<template>
    <div>
        <Header />
        <CommonTag />
        <router-view v-slot="{ Component }">
            <keep-alive>
                <component :is="Component" :key="$route.fullPath" />
            </keep-alive>
        </router-view>
        <Footer />
    </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useStore } from 'vuex';
import { useRoute, useRouter } from 'vue-router';
import request from '@/utils/request'
import Header from '@/components/Header.vue';
import Footer from '@/components/Footer.vue';
import { ElMessage, ElNotification } from 'element-plus';
import { Search, Delete, Download, Plus, ZoomIn, ArrowRight, Bell, Van } from '@element-plus/icons-vue'
import CommonTag from '@/components/CommonTag.vue';

const store = useStore();
const route = useRoute();
const router = useRouter();


onMounted(() => {
})

</script>
<style scoped lang='less'></style>