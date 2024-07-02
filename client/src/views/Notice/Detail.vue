<template>
    <div class="container">
        <div class="top">
            <h2>{{ data.title }}</h2>
            <p>
                来源：社区中心&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                时间：{{ data.createTime }}
            </p>
        </div>
        <div class="content" v-dompurify-html="data.content"></div>
    </div>
</template>

<script setup>
import { ref, reactive, toRefs, onBeforeMount, onMounted, watchEffect, computed } from 'vue';
import { useStore } from 'vuex';
import { useRoute, useRouter } from 'vue-router';
import request from '@/utils/request'
import { ElMessage } from 'element-plus';

const store = useStore();
const route = useRoute();
const router = useRouter();


onMounted(() => {
    getData()
})

// 从路由获取id，再发请求获取数据
const data = ref({})
const getData = async () => {
    const id = route.query.id;
    await request.get("/sys/notice/detail/" + id).then((res) => {
        console.log(res)
        if (res.code == 200) {
            data.value = res.data;
        } else {
            ElMessage.warning(res.msg);
        }
    })
}

// 方案一：使用 vue-dompurify-html 插件
// 方案二：使用html自带的清洗器：sanitize-html
//默认配置
const customConfig = {
    allowedTags: ['b', 'i', 'u', 'p', 'span', 'img'],
    allowedAttributes: {
        img: ['src']
    },
    allowedSchemes: ['http', 'https'],
    allowedClasses: {
        b: ['bold', 'highlight'],
        i: ['italic']
    },
    transformTags: {
        b: 'strong',
        i: 'em'
    },
    nonTextTags: ['style', 'script', 'textarea', 'noscript']
}
//使用sanitizeHtml函数返回干净的dom
// const cleanHtml = sanitizeHtml(richTextValue.value, customConfig);


</script>
<style scoped lang='less'>
.container {
    width: 80%;
    margin: 20px auto;

    .top {
        text-align: center;
        font-family: "KaiTi";

        p {
            color: #7f7f7f;
            font-size: 15px;
        }
    }

    .content {
        width: 50%;
        margin: 0 auto;
        font-size: 16px;
        color: #5a5959;
        font-family: "NSimSun";
    }
}
</style>