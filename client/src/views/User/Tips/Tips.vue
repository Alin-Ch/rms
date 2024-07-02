<template>
    <div v-if="messageList.length > 0">
        <el-collapse v-model="activeNames" @change="handleChange">
            <el-collapse-item v-for="item in messageList" :key="item.id" :name="item.id" @click="readMessage(item)">
                <template #title>
                    {{ item.title }}
                    <el-tag v-if="item.status == 1" style="margin-left:20px;">未读</el-tag>
                    <el-tag v-if="item.status == 2" style="margin-left:20px;" type="success">已读</el-tag>
                </template>
                <div style="color: #7f7f7f;">
                    {{ item.content }}
                    <br>
                    {{ item.create_time }}
                </div>
            </el-collapse-item>
        </el-collapse>
    </div>
    <div v-else>
        <el-empty description="没有消息" />
    </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useStore } from 'vuex';
import { useRoute, useRouter } from 'vue-router';
import request from '@/utils/request'
import { ElMessage } from 'element-plus';

const store = useStore();
const route = useRoute();
const router = useRouter();


onMounted(() => {
    getMessage()
})
// 发请求获取消息
const messageList = ref([])
const getMessage = () => {
    const userid = JSON.parse(localStorage.getItem("user")).id;
    request.get("/message/" + userid).then((res) => {
        console.log(res);
        if (res.code == '200') {
            messageList.value = res.data
        } else {
            ElMessage.warning(res.msg)
        }
    })
}
// 标记消息为已读
const readMessage = (item) => {
    request.post("/message/read", item).then((res) => {
        if (res.code == '200') {
        } else {
        }
    })
}

</script>
<style scoped lang='less'></style>