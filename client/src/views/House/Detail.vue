<template>
    <div class="container">
        <div class="top">
            <div class="left">{{ data.name }}</div>
            <div class="right">
                <div class="item" v-if="!hasFavor" @click="handleFavor">
                    <el-icon color="red" size="24px">
                        <Star />
                    </el-icon>
                    <span>加入收藏</span>
                </div>
                <div class="item" v-if="hasFavor" @click="handleDisFavor">
                    <el-icon color="red" size="24px">
                        <StarFilled />
                    </el-icon>
                    <span>取消收藏</span>
                </div>
                <div class="item">
                    <el-icon color="red" size="24px">
                        <Discount />
                    </el-icon>
                    <span>举报</span>
                </div>
            </div>
        </div>
        <div class="middle">
            <div class="left">
                <div class="left-image">
                    <el-carousel height="300px" :autoplay="false" trigger="click">
                        <!-- 判断 videoList 是否存在视频，如果有则先展示视频 -->
                        <el-carousel-item v-if="hasVideos" v-for="(video, index) in data.videoList"
                            :key="`video-${index}`">
                            <video controls style="width: 100%; height: 100%;">
                                <source :src="video.url" type="video/mp4">
                                Your browser does not support the video tag.
                            </video>
                        </el-carousel-item>
                        <!-- 再展示图片 -->
                        <el-carousel-item v-for="(item, index) in data.list" :key="`image-${index}`">
                            <el-image style="width: 100%; height: 100%" :src="item.url" fit="cover"
                                @click="goThreeJS(item)" />
                        </el-carousel-item>
                    </el-carousel>
                </div>
                <div class="left-content">
                    <span>
                        <text style="font-size:26px;color:red;">
                            <strong>
                                {{ data.price }}
                            </strong>元/月
                        </text> 押二付一
                    </span>
                    <span>{{ data.name }}</span>
                    <span>{{ data.description }}</span>
                    <span>{{ data.area }}</span>
                    <span>{{ data.address }}</span>
                    <span>
                        <el-button type="danger" size="large" round @click="handleContact">立即联系</el-button>
                        <el-button type="danger" size="large" round @click="goPay">付定金</el-button>
                    </span>
                    <!-- <span>{{ data.type }}</span>
                    <span>{{ data.floor }}</span>
                    <span>{{ data.elevator }}</span>
                    <span>{{ data.decoration }}</span>
                    <span>{{ data.heating }}</span> -->
                </div>
            </div>
            <div class="right" v-if="data.owner" @click="goShopDetail">
                <el-image style="width:100px;height:100px;margin:0 auto;" :src="data.owner.avatar" fit="cover" />
                <span>{{ data.owner.username }}</span>
                <span>{{ data.owner.phone }}</span>
                <span>{{ data.owner.email }}</span>
                <!-- <span>{{ data.owner.idCard }}</span>
                <span>{{ data.owner.gender == 1 ? "男" : "女" }}</span>
                <span>{{ data.owner.birthday }}</span>
                <span>{{ data.owner.address }}</span>
                <span>{{ data.owner.introduction }}</span> -->
            </div>
        </div>
        <div style="width:100%;height:300px;">
            <BaiduMap :houses="[data]" />
        </div>
        <div class="bottom">
            <el-tabs v-model="activeName" class="demo-tabs">
                <el-tab-pane label="宝贝详情" name="Detail">
                    <template #label><span class="my-label">宝贝详情</span></template>
                    <div v-html="data.detail"></div>
                </el-tab-pane>
                <el-tab-pane label="租户评价" name="Comment">
                    <template #label><span class="my-label">租户评价</span></template>
                    <!-- 评价的组件 bright-comment     undraw-ui -->
                    <UComment :houseId="houseId" />
                </el-tab-pane>
            </el-tabs>
        </div>
    </div>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue';
import { useStore } from 'vuex';
import { useRoute, useRouter } from 'vue-router';
import { ElMessage, ElLoading, ElNotification } from 'element-plus';
import request from '@/utils/request'
import { Star, StarFilled, Bell, Discount } from '@element-plus/icons-vue'
// undrawui的评论组件
import UComment from '@/components/Comment.vue';
// 百度地图
import BaiduMap from '@/components/BaiduMapShow.vue';

const route = useRoute();
const router = useRouter();
// tab标签
const activeName = ref('Detail')
onMounted(() => {
    getData()
    checkIfFavor()
    ElNotification({
        title: '全景看房',
        message: '点击轮播图可查看全景图片',
        type: 'info',
        duration: 2000,
    })
})
// 从路由获取id，再发请求获取数据
const data = ref({})
const houseId = computed(() => parseInt(route.query.id))
const getData = async () => {
    if (!route.query.id) {
        ElMessage.warning("id不存在");
        router.push({ path: "/house" });
        return
    }
    const id = route.query.id;
    await request.get("/sys/house/detail/" + id).then((res) => {
        // console.log(res)
        if (res.code == 200) {
            data.value = res.data;
        } else {
            ElMessage.warning(res.msg);
        }
    })
}
// 去店铺详情
const goShopDetail = () => {
    sessionStorage.setItem("owner", JSON.stringify(data.value.owner));
    router.push({ path: "/house/shop/detail", query: { id: data.value.owner.id } })
}
// 查看全景图
const goThreeJS = (item) => {
    console.log(item);
    sessionStorage.setItem("image", JSON.stringify(item));
    router.push({ path: "/house/threejs", query: { id: item.id } })
}
// 按钮     立即联系 和 支付定金
const handleContact = () => {
    localStorage.setItem("house", JSON.stringify(data.value));
    router.push({ path: "/message/chat", query: { userid: data.value.id } });
}
const goPay = () => {
    // 判断用户有没有登录
    if (!localStorage.getItem("user")) {
        ElMessage.warning("请先登录~");
        localStorage.removeItem("token");
        router.push({ path: "/login" });
        return
    }
    // 创建order对象
    var order = {
        money: data.value.price,
        houseId: data.value.id,
        ownerId: data.value.owner.id,
        userId: JSON.parse(localStorage.getItem("user")).id,
    }
    request.post("/sys/order/save", order).then((res) => {
        if (res.code == 200) {
            ElMessage.success("创建订单成功")
        } else {
            ElMessage.warning(res.msg)
        }
    })
}
// 全屏loading效果
const openFullScreen = () => {
    const loading = ElLoading.service({
        lock: true,
        text: '创建订单中...',
        background: 'rgba(0, 0, 0, 0.7)',
    })
    setTimeout(() => {
        loading.close()
    }, 2000)
}
// 是否收藏
const hasFavor = ref(false)
const checkIfFavor = () => {
    if (localStorage.getItem("user") == null) {
        return
    }
    const userid = localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")).id : ""
    const houseid = route.query.id
    request.get("/sys/favor/check/" + userid + "/" + houseid).then((res) => {
        if (res.code == 200) {
            hasFavor.value = res.data
        }
    })
}
// 加入收藏、取消收藏
const handleFavor = () => {
    if (localStorage.getItem("user") == null) {
        ElMessage.warning("请先登录~");
        localStorage.removeItem("user");
        localStorage.removeItem("token");
        router.push({ path: "/login" });
        return
    }
    var favor = {}
    favor.userId = localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")).id : ""
    favor.houseId = route.query.id
    favor.houseName = data.value.name
    request.post("/sys/favor/add/", favor).then((res) => {
        // console.log(res);
        if (res.code == 200) {
            hasFavor.value = true
            ElMessage.success("收藏成功~");
        }
    })
}
const handleDisFavor = () => {
    // 能显示取消收藏的，说明用户已经登录并且查询出来是收藏的，所以可以直接取消收藏
    const userid = JSON.parse(localStorage.getItem("user")).id
    const houseid = route.query.id
    request.post("/sys/favor/delete/" + userid + "/" + houseid).then((res) => {
        // console.log(res);
        if (res.code == 200) {
            hasFavor.value = false
            ElMessage.success("取消收藏成功~");
        }
    })
}


// 商品详情页轮播图
const hasVideos = computed(() => {
    // 判断 videoList 是否存在视频
    return data.value.videoList && data.value.videoList.length > 0;
})
</script>
<style scoped lang='less'>
.container {
    width: 80%;
    margin: 0 auto;

    .top {
        display: flex;
        justify-content: space-between;
        align-items: center;
        height: 60px;
        border-bottom: 1px solid #d8d8d8;

        .left {
            font-size: 25px;
            font-weight: bolder;
            color: #7f7f7f;
        }

        .right {
            display: flex;
            align-items: center;
            box-shadow: rgba(0, 0, 0, 0.04) 0px 5px 8px;

            .item {
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                margin-right: 30px;
                cursor: pointer;
                user-select: none;

                span {
                    color: #7f7f7f;
                    font-size: 12px;
                }
            }
        }
    }

    .middle {
        display: flex;
        justify-content: space-between;
        // align-items: center;
        height: 300px;
        // margin-top: 20px;
        color: #7f7f7f;

        .left {
            display: flex;
            align-items: center;

            .left-image {
                width: 350px;
                height: 300px;
                // background-color: pink;
            }

            .left-content {
                margin-left: 20px;
                height: 100%;
                display: flex;
                flex-direction: column;
                justify-content: space-around;
                color: #7f7f7f;
            }
        }

        .right {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            width: 200px;
            height: 300px;
            font-size: 15px;
            box-shadow: rgba(0, 0, 0, 0.04) 0px 3px 5px;
        }
    }

    .bottom {
        margin-top: 20px;

        .my-label {
            font-size: 20px;
            // color: orange;
        }

        // :deep(.el-tabs__nav-wrap::after) {
        //     position: static !important;
        //     background-color: orange;
        // }
        // :deep(.el-tabs__active-bar) {
        //     background-color: transparent !important;
        //     background-color: orange;
        // }


    }
}
</style>