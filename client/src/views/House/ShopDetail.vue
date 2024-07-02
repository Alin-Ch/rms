<template>
    <div class="container">
        <div class="top">
            <el-card class="card">
                <div class="userInfo">
                    <div class="info">
                        <div class="left">
                            <el-image style="width: 100px; height: 100px" :src="owner.avatar" fit="cover" />
                        </div>
                        <div class="right">
                            <span><strong>房东名称: </strong>{{ owner.username }}</span>
                            <span><strong>所处地区: </strong>{{ owner.city }}</span>
                            <span><strong>联系方式: </strong>{{ owner.phone }}</span>
                            <span><strong>邮箱号: </strong>{{ owner.email }}</span>
                        </div>
                    </div>
                    <el-button type="primary" :icon="Message" round size="large">打个招呼</el-button>
                </div>
            </el-card>
        </div>
        <div class="middle">
            <el-card class="card" v-for="(item, index) in data" :key="index" shadow="hover" @click="goDetail(item)">
                <template #header>
                    <div class="text-overflow">{{ item.name }}</div>
                </template>
                <el-image style="width: 100%; height: 300px"
                    :src="item.list && item.list.length > 0 ? item.list[0].url : ''" fit="cover" />
                <template #footer>
                    <!-- <div class="text-overflow">{{ item.description }}</div> -->
                    <div>{{ item.description }}</div>
                </template>
            </el-card>
        </div>
    </div>
</template>

<script setup>
import { ref, reactive, toRefs, onBeforeMount, onMounted, watchEffect, computed } from 'vue';
import { useStore } from 'vuex';
import { useRoute, useRouter } from 'vue-router';
import { Message } from '@element-plus/icons-vue'
import request from '@/utils/request'

const route = useRoute();
const router = useRouter();


onMounted(() => {
    getData()
})

// 从路由获取id，再发请求获取数据
const data = ref({})
const owner = ref({})
const ownerId = computed(() => parseInt(route.query.id))
const getData = async () => {
    owner.value = JSON.parse(sessionStorage.getItem("owner"))
    if (!route.query.id) {
        ElMessage.warning("id不存在");
        router.push({ path: "/house" });
        return
    }
    const id = route.query.id;
    await request.get("/sys/house/shop/detail/" + id).then((res) => {
        console.log(res)
        if (res.code == 200) {
            data.value = res.data;
        } else {
            ElMessage.warning(res.msg);
        }
    })
}
// 点击查看详情
const goDetail = (item) => {
    sessionStorage.setItem('house', JSON.stringify(item))
    router.push({ path: '/house/detail', query: { id: item.id } })
}

</script>
<style scoped lang='less'>
.container {
    width: 80%;
    margin: 0 auto;

    .top {
        .card {
            max-width: 100%;
            margin-bottom: 10px;

            .userInfo {
                display: flex;
                justify-content: space-between;
                align-items: center;

                .info {
                    display: flex;
                    align-items: center;

                    .right {
                        margin-left: 20px;
                        display: flex;
                        flex-direction: column;
                        justify-content: space-around;
                        color: #7f7f7f;
                    }
                }
            }
        }
    }

    .middle {
        display: flex;
        flex-wrap: wrap;
        justify-content: space-between;

        .card {
            width: 350px;
            margin-bottom: 20px;

            .text-overflow {
                overflow: hidden;
                white-space: nowrap;
                text-overflow: ellipsis;
            }
        }
    }
}
</style>