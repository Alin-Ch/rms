<template>
    <div>
        <el-breadcrumb separator=">">
            <!-- <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item> -->
            <el-breadcrumb-item v-for="(item, index) in breadcrumbList" :key="index" :to="item.path">
                {{ item.meta.title }}
            </el-breadcrumb-item>
        </el-breadcrumb>
    </div>
</template>

<script setup>
import { ref, onMounted, watch, computed } from 'vue';
import { useRouter, useRoute } from 'vue-router';

let router = useRouter();
let route = useRoute();

const breadcrumbList = ref([]);

let getMatched = () => {
    // console.log(route.matched);
    breadcrumbList.value = route.matched
    // console.log(route.matched);
    // breadList.value = route.matched.filter(item => item.meta && item.meta.title);
}
onMounted(() => {
    getMatched();
})

watch(() => route.path, (newValue, oldValue) => { //监听路由路径是否发生变化，之后更改面包屑
    // console.log(route.matched);
    breadcrumbList.value = route.matched.filter(item => item.meta && item.meta.title);
})

</script>

<style scoped lang='less'></style>