<template>
    <div class="container">
        <div class="top">
            <img src="../../assets/images/58tc.png" alt="">
            <div style="width: 800px;margin-left: 100px;">
                <el-input v-model="params.name" style="width: 350px;height: 40px;" size="large" placeholder="请输入关键词"
                    :prefix-icon="Search" />
                <el-button type="primary" style="height: 40px;" :icon="Search" @click="handleSearch">搜房源</el-button>
            </div>
        </div>
        <div class="tags-box">
            <el-tabs v-model="activeName" @tab-click="handleTabClick">
                <el-tab-pane label="附近房源" name="nearby">
                    <!-- 百度地图 -->
                    <div v-if="activeName == 'nearby'" style="width:100%;height:300px;">
                        <BaiduMap :houses="tableData" />
                    </div>
                    <!-- 商品展示 -->
                    <el-card style="max-width:100%;" shadow="hover" @click="goDetail(item)" v-for="item in tableData"
                        :key="item.id">
                        <div class="house-item">
                            <div class="item-left">
                                <el-image style="width: 100px; height: 100px"
                                    :src="item.list && item.list.length > 0 ? item.list[0].url : ''" fit="cover" />
                                <div class="left-desc">
                                    <div class="desc-top">
                                        <span>整租</span> |
                                        <span>{{ item.name }}</span>
                                    </div>
                                    <div class="desc-bottom">
                                        <span>描述：{{ item.description ? item.description : "暂无信息" }} &emsp; </span>
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
                <el-tab-pane label="所有房屋" name="all">
                    <!-- 百度地图 -->
                    <div v-if="activeName == 'all'" style="width:100%;height:300px;">
                        <BaiduMap :houses="tableData" />
                    </div>
                    <!-- 商品展示 -->
                    <el-card style="max-width:100%;" shadow="hover" @click="goDetail(item)" v-for="item in tableData"
                        :key="item.id">
                        <div class="house-item">
                            <div class="item-left">
                                <el-image style="width: 100px; height: 100px"
                                    :src="item.list && item.list.length > 0 ? item.list[0].url : ''" fit="cover" />
                                <div class="left-desc">
                                    <div class="desc-top">
                                        <span>整租</span> |
                                        <span>{{ item.name }}</span>
                                    </div>
                                    <div class="desc-bottom">
                                        <span>描述：{{ item.description ? item.description : "暂无信息" }} &emsp; </span>
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
                    <!-- 分页器 -->
                    <div style="margin: 10px 0;">
                        <el-pagination @size-change="pageSizeChange" @current-change="pageChange"
                            :current-page="params.current" :page-sizes="[5, 10, 15, 20]" :page-size="params.size"
                            layout="total, sizes, prev, pager, next, jumper" :total="total">
                        </el-pagination>
                    </div>
                </el-tab-pane>
                <el-tab-pane label="出租房推荐" name="recommend">
                    <!-- 商品展示 -->
                    <el-card style="max-width:100%;" shadow="hover" @click="goDetail(item)" v-for="item in tableData"
                        :key="item.id">
                        <div class="house-item">
                            <div class="item-left">
                                <el-image style="width: 100px; height: 100px"
                                    :src="item.list && item.list.length > 0 ? item.list[0].url : ''" fit="cover" />
                                <div class="left-desc">
                                    <div class="desc-top">
                                        <span>整租</span> |
                                        <span>{{ item.name }}</span>
                                    </div>
                                    <div class="desc-bottom">
                                        <span>描述：{{ item.description ? item.description : "暂无信息" }} &emsp; </span>
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
                <el-tab-pane label="核验真房" name="real">核验真房</el-tab-pane>
                <el-tab-pane label="安选房源" name="safty">安选房源</el-tab-pane>
                <el-tab-pane label="视频房源" name="video">视频房源</el-tab-pane>
                <el-tab-pane label="VR看房" name="VR">VR看房</el-tab-pane>

            </el-tabs>
        </div>
    </div>

    <el-backtop :right="100" :bottom="50" />
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useStore } from 'vuex';
import { useRoute, useRouter } from 'vue-router';
import request from '@/utils/request'
import { ElMessage } from 'element-plus';
import { Search, Delete, Download, Plus, ZoomIn, ArrowRight, Bell, Van } from '@element-plus/icons-vue'
// 百度地图
import BaiduMap from '@/components/BaiduMapShow.vue';

const store = useStore();
const route = useRoute();
const router = useRouter();

// 搜索
const handleSearch = () => {
    activeName.value = 'all'
    getData()
}
// 分页查询、模糊查询所需要的参数
const params = ref({
    name: '',
    current: 1,
    size: 10,
})
const tableData = ref([])
const total = ref(0)
// 获取表格数据
const getData = () => {
    request.get('/sys/house/list', { params: params.value }).then((res) => {
        // console.log(res.data);
        if (res.code == 200) {
            total.value = res.data.total;
            tableData.value = res.data.records;
        } else {
            ElMessage.warning(res.msg);
        }
    }).catch((err) => {
        ElMessage.warning(err);
    })
}
onMounted(() => {
    if (activeName.value == 'all') {
        getData()
    } else if (activeName.value == 'recommend') {
        getRandom()
    } else if (activeName.value == 'nearby') {
        getNearby()
    }
    // getData()
    // getRandom()
})
// 推荐
const getRandom = () => {
    request.get('/sys/house/random').then((res) => {
        if (res.code == 200) {
            tableData.value = res.data;
        } else {
            ElMessage.warning(res.msg);
        }
    })
}
// 附近房源
const getNearby = () => {
    getLocation()

}
// 获取用户地理位置信息
const getLocation = () => {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition((position) => {
            params.value.jingdu = position.coords.longitude;
            params.value.weidu = position.coords.latitude;
            // console.log(params.value);
            // 在获取到位置信息后，立即发起数据请求
            // getData();
            request.get('/sys/house/nearby', { params: params.value }).then((res) => {
                // console.log(res);
                if (res.code == 200) {
                    tableData.value = res.data;
                    // res.data.forEach(item => {
                    //     console.log("经纬度", item.jingdu, "---", item.weidu);
                    // })
                } else {
                    ElMessage.warning(res.msg);
                }
            })
        }, (error) => {
            console.error('获取位置信息失败:', error);
            // 处理位置信息获取失败的情况
        });
    } else {
        console.error('浏览器不支持Geolocation');
        // 处理浏览器不支持Geolocation的情况
    }
};

// 出租房相关
const activeName = ref('nearby')
const handleTabClick = (tab, event) => {
    // console.log(tab, event)
    // console.log(tab.props.name);
    if (tab.props.name == 'recommend') {
        getRandom()
    } else if (tab.props.name == 'all') {
        getData()
    } else if (tab.props.name == 'nearby') {
        getNearby()
    }
}
// 点击查看详情
const goDetail = (item) => {
    sessionStorage.setItem('house', JSON.stringify(item))
    router.push({ path: '/house/detail', query: { id: item.id } })
}

// 分页器功能
const pageSizeChange = (pageSize) => {
    params.value.size = pageSize;
    getData();
}
const pageChange = (pageNum) => {
    params.value.current = pageNum;
    getData();
}
</script>
<style scoped lang='less'>
.container {
    width: 100%;
    height: 100%;
    // background-color: pink;

    .top {
        width: 100%;
        display: flex;
        justify-content: center;
        align-items: center;
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
</style>