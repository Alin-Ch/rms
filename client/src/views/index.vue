<template>
    <div class="affix-container">
        <el-affix target=".affix-container" :offset="0">
            <Header />
        </el-affix>

        <div class="middle">
            <!-- 轮播图 -->
            <el-carousel :interval="4000" class="carousel">
                <el-carousel-item v-for="item in bannerList" :key="item">
                    <img :src="item.url" alt="" class="carousel-image">
                </el-carousel-item>
            </el-carousel>
            <div class="content-box">
                <!-- 公告 -->
                <div class="notice">
                    <el-card class="box-card" shadow="always">
                        <div class="card-container">
                            <div class="header">
                                <div class="left">
                                    <svg t="1688029763062" class="icon" viewBox="0 0 1126 1024" version="1.1"
                                        xmlns="http://www.w3.org/2000/svg" p-id="6471" width="16" height="16">
                                        <path
                                            d="M384 399.36c-5.12 5.12-8.533333 8.533333-17.066667 8.533333h-78.506666c-13.653333 0-25.6 13.653333-25.6 25.6v160.426667c0 13.653333 13.653333 25.6 25.6 25.6h78.506666c5.12 0 13.653333 5.12 17.066667 8.533333l155.306667 160.426667c5.12 5.12 5.12 8.533333 8.533333 8.533333V232.106667l-8.533333 8.533333-155.306667 158.72z"
                                            fill="#19ADF4" p-id="6472"></path>
                                        <path
                                            d="M742.4 0h-358.4C199.68 0 51.2 148.48 51.2 332.8v358.4C51.2 875.52 199.68 1024 384 1024h358.4C926.72 1024 1075.2 875.52 1075.2 691.2v-358.4C1075.2 148.48 926.72 0 742.4 0z m-143.36 805.546667c0 39.253333-22.186667 51.2-39.253333 51.2-17.066667 0-34.133333-8.533333-56.32-30.72l-145.066667-153.6h-64.853333c-42.666667 0-78.506667-39.253333-78.506667-81.92v-160.426667c0-47.786667 34.133333-81.92 78.506667-81.92H358.4l146.773333-150.186667c22.186667-22.186667 39.253333-30.72 56.32-30.72s39.253333 13.653333 39.253334 47.786667v590.506667z m121.173333-138.24l-8.533333 13.653333c-5.12 8.533333-13.653333 13.653333-22.186667 13.653333-5.12 0-8.533333 0-13.653333-5.12-8.533333-8.533333-13.653333-25.6-5.12-39.253333l8.533333-13.653333c25.6-34.133333 47.786667-68.266667 47.786667-124.586667s-22.186667-87.04-47.786667-121.173333c-5.12-5.12-8.533333-8.533333-13.653333-17.066667-8.533333-13.653333-8.533333-30.72 5.12-39.253333 8.533333-8.533333 25.6-8.533333 34.133333 5.12 5.12 5.12 8.533333 13.653333 13.653334 17.066666 30.72 39.253333 56.32 81.92 59.733333 150.186667 3.413333 73.386667-32.426667 121.173333-58.026667 160.426667z m78.506667 112.64c-5.12 5.12-8.533333 8.533333-17.066667 8.533333s-13.653333-5.12-17.066666-8.533333c-13.653333-13.653333-13.653333-25.6-5.12-39.253334 51.2-59.733333 98.986667-129.706667 98.986666-228.693333 0-95.573333-47.786667-168.96-98.986666-228.693333-8.533333-13.653333-5.12-30.72 5.12-39.253334 8.533333-8.533333 25.6-8.533333 34.133333 5.12 51.2 64.853333 107.52 146.773333 112.64 267.946667-1.706667 110.933333-56.32 197.973333-112.64 262.826667z"
                                            fill="#19ADF4" p-id="6473"></path>
                                    </svg>
                                    <span>平台公告</span>
                                </div>
                                <div class="right" @click="router.push('/notice/all')">
                                    <span>全部</span>
                                    <svg t="1688028732748" class="icon" viewBox="0 0 1024 1024" version="1.1"
                                        xmlns="http://www.w3.org/2000/svg" p-id="4430" width="16" height="16">
                                        <path
                                            d="M761.055557 532.128047c0.512619-0.992555 1.343475-1.823411 1.792447-2.848649 8.800538-18.304636 5.919204-40.703346-9.664077-55.424808L399.935923 139.743798c-19.264507-18.208305-49.631179-17.344765-67.872168 1.888778-18.208305 19.264507-17.375729 49.631179 1.888778 67.872168l316.960409 299.839269L335.199677 813.631716c-19.071845 18.399247-19.648112 48.767639-1.247144 67.872168 9.407768 9.791372 21.984142 14.688778 34.560516 14.688778 12.000108 0 24.000215-4.479398 33.311652-13.439914l350.048434-337.375729c0.672598-0.672598 0.927187-1.599785 1.599785-2.303346 0.512619-0.479935 1.056202-0.832576 1.567101-1.343475C757.759656 538.879828 759.199462 535.391265 761.055557 532.128047z"
                                            fill="#1296db" p-id="4431"></path>
                                    </svg>
                                </div>
                            </div>
                            <div class="content">
                                <ul>
                                    <li v-for="item in noticeList" :key="item.id" @click="goNoticeDetail(item.id)">
                                        <span style="display: flex; align-items: center;">
                                            <el-icon color="#409EFF">
                                                <Bell />
                                            </el-icon>
                                            <span
                                                style="margin-left: 10px;width: 200px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap">
                                                {{ item.title }}
                                            </span>
                                        </span>
                                        <span>{{ item.createTime }}</span>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </el-card>
                </div>
                <!-- 右侧的商品展示 -->
                <div class="tags-box">
                    <el-tabs v-model="activeName" @tab-click="handleTabClick">
                        <el-tab-pane label="房源推荐|全部房源" name="recommend">
                            <el-card style="max-width:100%;" shadow="hover" @click="goHouseDetail(item)"
                                v-for="item in recommendList" :key="item.id">
                                <div class="house-item">
                                    <div class="item-left">
                                        <el-image style="width: 100px; height: 100px"
                                            :src="item.list && item.list.length > 0 ? item.list[0].url : ''"
                                            fit="cover" />
                                        <div class="left-desc">
                                            <div class="desc-top">
                                                <span>整租</span> |
                                                <span>{{ item.name }}</span>
                                            </div>
                                            <div class="desc-bottom">
                                                <span>描述：{{ item.description ? item.description : "暂无信息" }} &emsp;
                                                </span>
                                                <span>地址：{{ item.location ? item.location : "暂无信息" }} &emsp; </span>
                                                <span>房东：{{ item.owner ? item.owner.username : '暂无信息' }}</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="item-right">
                                        <span>{{ item.price }}元/月</span>
                                    </div>
                                </div>
                            </el-card>
                        </el-tab-pane>
                        <el-tab-pane label="个人房源" name="personal">个人房源</el-tab-pane>
                        <el-tab-pane label="核验真房" name="real">核验真房</el-tab-pane>
                        <el-tab-pane label="安选房源" name="safty">安选房源</el-tab-pane>
                        <el-tab-pane label="视频房源" name="video">视频房源</el-tab-pane>
                        <el-tab-pane label="VR看房" name="VR">VR看房</el-tab-pane>
                    </el-tabs>
                </div>
            </div>

        </div>

        <Footer />
    </div>
    <el-backtop :right="100" :bottom="50" />
</template>

<script setup>
import { ref, onMounted, h } from 'vue';
import { useStore } from 'vuex';
import { useRoute, useRouter } from 'vue-router';
import request from '@/utils/request'
import Header from '../components/Header.vue';
import Footer from '../components/Footer.vue';
import { ElMessage, ElNotification } from 'element-plus';
import { Search, Delete, Download, Plus, ZoomIn, ArrowRight, Bell, Van } from '@element-plus/icons-vue'

const store = useStore();
const route = useRoute();
const router = useRouter();
// 查询需要的参数
const params = ref({
    user_id: JSON.parse(localStorage.getItem('user')) ? JSON.parse(localStorage.getItem('user')).id : null,
    name: '',
    current: 1,
    size: 10,
})
// 每日一言
const getSentence = () => {
    fetch('https://api.gumengya.com/Api/YiYan?format=json')
        .then(response => response.json())
        .then(data => {
            // 处理成功响应
            // console.log(data);
            ElNotification({
                title: '',
                message: h('i', { style: 'color: teal' }, data.data.text),
            })
        })
        .catch(error => {
            // 处理错误
            console.error(error);
        });
}

onMounted(() => {
    getBanner()
    getNotice()
    getRandom()
    // getSentence()
})
// 获取轮播图
const bannerList = ref([])
const getBanner = () => {
    request.get("/sys/carousel/banner").then((res) => {
        // console.log(res);
        if (res.code == 200) {
            bannerList.value = res.data
        } else {
            ElMessage.warning(res.msg)
        }
    })
}
// 获取公告
const noticeList = ref([])
const getNotice = () => {
    request.get("/sys/notice/limit").then((res) => {
        // console.log(res);
        if (res.code == 200) {
            noticeList.value = res.data
            // 遍历res.data 将时间戳转换为年月日的格式
            noticeList.value.forEach((item) => {
                // 将时间只截取前面的年月日
                item.createTime = new Date(item.createTime).toLocaleDateString()
                // 或者使用dayjs
                // item.createTime = dayjs(item.createTime).format('YYYY-MM-DD HH:mm:ss')
            })
        } else {
            // ElMessage.warning(res.msg)
        }
    })
}
const goNoticeDetail = (id) => {
    router.push({ path: '/notice/detail', query: { id: id } })
}
// 获取推荐
const recommendList = ref([])
const getRecommend = () => {
    request.get("/sys/house/recommend/list", params.value).then((res) => {
        console.log(res);
        if (res.code == 200) {
            recommendList.value = res.data
        } else {
            ElMessage.warning(res.msg)
        }
    })
}
const getRandom = () => {
    request.get('/sys/house/random').then((res) => {
        // console.log(res.data);
        if (res.code == 200) {
            recommendList.value = res.data;
        } else {
            ElMessage.warning(res.msg);
        }
    })
}
// 点击查看详情
const goHouseDetail = (item) => {
    sessionStorage.setItem('house', JSON.stringify(item))
    router.push({ path: '/house/detail', query: { id: item.id } })
}

// 出租房相关
const activeName = ref('recommend')
const handleTabClick = (tab, event) => {
    // console.log(tab, event)
    // console.log(tab.props.name);
    if (tab.props.name == 'recommend') {
        router.push({ path: '/house' })
    } else if (tab.props.name == 'all') {
        router.push({ path: '/house' })
    }
}
</script>
<style scoped lang='less'>
.middle {
    .carousel {
        text-align: center;
        height: 300px;
    }

    .carousel-image {
        margin: 0 auto;
        text-align: center;
        width: 100%;
        height: 100%;
        object-fit: cover;
        /* 保持图片比例并填充整个容器 */
    }

    .content-box {
        display: flex;
        justify-content: space-around;
        align-items: start;

        .notice {
            width: 350px;
            // background-color: pink;
            display: flex;
            flex-direction: column;
            justify-content: space-around;
            margin-right: 10px;

            .box-card {
                width: 100%;
                // margin: 20px auto;

                .header {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;

                    .left {
                        display: flex;
                        align-items: center;
                        width: 150px;
                        overflow: hidden;
                        text-overflow: ellipsis;
                        white-space: nowrap;

                        span {
                            margin-left: 10px;
                        }

                        span:hover {
                            cursor: pointer;
                        }
                    }

                    .right {
                        display: flex;
                        align-items: center;

                        span {
                            margin-right: 10px;
                        }

                        span:hover {
                            color: #55a6fe;
                            cursor: pointer;
                        }
                    }
                }

                .content {
                    display: flex;
                    justify-content: space-around;

                    ul {
                        margin-left: -40px;

                        li {
                            margin-top: 20px;
                            overflow: hidden;
                            text-overflow: ellipsis;
                            white-space: nowrap;

                            display: flex;
                            justify-content: space-between;
                        }

                        li:hover {
                            color: #55a6fe;
                            cursor: pointer;
                        }
                    }
                }
            }
        }

        .tags-box {
            width: 90%;
            margin: 0 auto;

            .house-item {
                display: flex;

                :hover {
                    cursor: pointer;
                }

                .item-left {
                    flex: 8;
                    padding-right: 10px;
                    // background-color: pink;
                    display: flex;

                    .left-desc {
                        padding: 10px;
                        display: flex;
                        flex-direction: column;
                        justify-content: space-between;

                        .desc-top {
                            font-size: 1.2em;
                            font-weight: 600;
                            width: 600px;
                            color: #6a6a6a;
                            overflow: hidden;
                            text-overflow: ellipsis;
                            white-space: nowrap;
                        }

                        .desc-bottom {
                            display: flex;
                            flex-direction: column;
                            justify-content: space-between;
                            align-items: start;
                            font-size: 12px;
                            color: #7f7f7f
                        }
                    }
                }

                .item-right {
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    flex: 2;
                    width: 100%;
                    text-align: center;
                    color: red;
                    font-size: 1.8em;
                    // background-color: skyblue;
                }
            }
        }

    }
}
</style>