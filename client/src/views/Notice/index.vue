<template>
  <div>
    <!-- 顶部 -->
    <Header />
    <CommonTag />
    <!-- 内容区域 -->
    <router-view></router-view>
    <!-- 底部 -->
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
import Detail from './Detail.vue';
import CommonTag from '@/components/CommonTag.vue';

const store = useStore();
const route = useRoute();
const router = useRouter();

onMounted(() => {

})

</script>
<style scoped lang='less'></style>