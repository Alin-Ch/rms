<template>
    <div class="container">
        <el-row :gutter="20">
            <el-col :span="6">
                <div class="top-item">
                    <el-statistic title="平台用户数量" :value="outputUserCountValue" />
                </div>
            </el-col>
            <el-col :span="6">
                <div class="top-item">
                    <el-statistic title="平台现有房屋数量" :value="outputHouseCountValue" />
                </div>
            </el-col>
            <el-col :span="6">
                <div class="top-item">
                    <el-statistic title="用户访问数量" :value="outputVisitCountValue" />
                </div>
            </el-col>
            <el-col :span="6">
                <div class="top-item">
                    <el-statistic title="平台总交易金额" :value="outputTradedCountValue" />
                </div>
            </el-col>
        </el-row>
        <el-row style="display: flex;align-items: center;">
            <el-col :span="12">
                <div class="log">
                    <div ref="logChart" id="logChart" :style="{ width: '500px', height: '400px' }"></div>
                </div>
            </el-col>
            <el-col :span="12">
                <div class="log">
                    <CusCalendar />
                </div>
            </el-col>
        </el-row>
        <br />
        <el-row :gutter="20">
            <el-col :span="12">
                <div style="width: 100%;display: flex;justify-content: center;">
                    <div ref="userGenderChart" id="userGenderChart" :style="{ width: '400px', height: '400px' }"></div>
                </div>
            </el-col>
            <el-col :span="12">
                <div style="width: 100%;display: flex;justify-content: center;">
                    <div ref="houseStatusChart" id="houseStatusChart" :style="{ width: '400px', height: '400px' }">
                    </div>
                </div>
            </el-col>
        </el-row>
    </div>
</template>



<script setup>
import { ArrowUpBold } from '@element-plus/icons-vue'
import { ref, reactive, onMounted, getCurrentInstance } from 'vue';
// 统计
import { useTransition } from '@vueuse/core'
import { useStore } from 'vuex';
import { useRoute, useRouter } from 'vue-router';
import request from '@/utils/request'
import { ElMessage } from 'element-plus';
import CusCalendar from '@/components/Calendar.vue';

const store = useStore();
const route = useRoute();
const router = useRouter();

// 通过 internalInstance.appContext.config.globalProperties 获取全局属性或方法
let internalInstance = getCurrentInstance();
let echarts = internalInstance.appContext.config.globalProperties.$echarts;
onMounted(() => {
    getUserLogData()
    getUserCount()
    getHouseCount()
    getVisitCount()
    getTradedCount()
    getUserGenderData()
    getHouseStatusData()
})

// 顶部的数据
const userCount = ref(0)
const outputUserCountValue = useTransition(userCount, {
    duration: 1500,
})
const houseCount = ref(0)
const outputHouseCountValue = useTransition(houseCount, {
    duration: 1500,
})
const visitCount = ref(0)
const outputVisitCountValue = useTransition(visitCount, {
    duration: 1500,
})
const tradedCount = ref(0)
const outputTradedCountValue = useTransition(tradedCount, {
    duration: 1500,
})
const getUserCount = () => {
    request.get("/sys/echarts/user/count").then(res => {
        userCount.value = res.data
    })
}
const getHouseCount = () => {
    request.get("/sys/echarts/house/count").then(res => {
        houseCount.value = res.data
    })
}
const getVisitCount = () => {
    request.get("/sys/echarts/visit/count").then(res => {
        visitCount.value = res.data
    })
}
const getTradedCount = () => {
    request.get("/sys/echarts/trade/count").then(res => {
        tradedCount.value = res.data
    })
}


// 获取用户登录的折线图数据
const getUserLogData = () => {
    var chartDom = document.getElementById('logChart');
    var logChart = echarts.init(chartDom);
    var option;
    option = {
        title: {
            // text: '用户登录趋势'
        },
        legend: {
            data: ['七天内用户登录趋势']
        },
        toolbox: {
            feature: {
                saveAsImage: {}
            }
        },
        tooltip: {
            trigger: 'axis'
        },
        xAxis: {
            type: 'category',
            data: [],
            axisLabel: {
                rotate: 45, // X 轴标签文字旋转角度
            },
        },
        yAxis: {
            type: 'value'
        },
        series: [{
            name: '七天内用户登录趋势',
            stack: 'Total',
            data: [],
            type: 'line',
            smooth: true
        }]
    };
    // 请求后台数据
    request.get("/sys/echarts/logs/bie").then((res) => {
        // console.log(res);
        if (res.code == 200) {
            // option.xAxis.data = res.data.map(item => item.date.split(' ')[0]);
            // option.series[0].data = res.data.map(item => item.value);
            option.xAxis.data = res.data.map(item => item.date.split(' ')[0]).reverse()
            option.series[0].data = res.data.map(item => item.value).reverse()
            logChart.setOption(option);
        } else {
            // 处理错误响应  
            ElMessage.warning(res.msg);
        }
    })
}
// 饼状图
// 获取用户性别数据
const getUserGenderData = () => {
    const dom = document.getElementById('userGenderChart');
    const userGenderChart = echarts.init(dom); // 初始化echarts实例

    var option = {
        // 标题
        title: {
            text: '用户性别分布',
            subtext: '性别比例',
            left: 'center'
        },
        // 鼠标悬停的提示
        tooltip: {
            trigger: 'item'
        },
        legend: {
            orient: 'vertical',
            bottom: 'bottom'
        },
        series: [{
            name: '性别人数',
            type: 'pie',
            radius: '50%',
            data: [],
            emphasis: {
                itemStyle: {
                    shadowBlur: 10,
                    shadowOffsetX: 0,
                    shadowColor: 'rgba(0, 0, 0, 0.5)'
                }
            }
        }]
    };
    // 发请求获取数据
    request.get("/sys/echarts/user/gender/bie").then((res) => {
        if (res.code == 200) {
            // 遍历 res.data
            res.data.forEach(function (item) {
                // 根据条件修改 name 字段
                if (item.name == '1') {
                    item.name = '男';
                } else if (item.name == '0') {
                    item.name = '女';
                } else {
                    item.name = '未知';
                }
            })
            option.series[0].data = res.data;
            userGenderChart.setOption(option); // 确保在数据更新后设置选项  
        } else {
            // 处理错误情况，例如设置默认数据或显示错误消息  
        }
    });
    // 当窗口或者大小发生改变时执行resize，重新绘制图表 
    window.onresize = userGenderChart.resize;
}
// 获取用户性别数据
const getHouseStatusData = () => {
    const dom = document.getElementById('houseStatusChart');
    const houseStatusChart = echarts.init(dom); // 初始化echarts实例

    var option = {
        // 标题
        title: {
            text: '房屋状态分布',
            subtext: '房屋状态比例',
            left: 'center'
        },
        // 鼠标悬停的提示
        tooltip: {
            trigger: 'item'
        },
        legend: {
            orient: 'vertical',
            bottom: 'bottom'
        },
        series: [{
            name: '房屋数量',
            type: 'pie',
            radius: '50%',
            data: [],
            emphasis: {
                itemStyle: {
                    shadowBlur: 10,
                    shadowOffsetX: 0,
                    shadowColor: 'rgba(0, 0, 0, 0.5)'
                }
            }
        }]
    };
    // 发请求获取数据
    request.get("/sys/echarts/house/status/bie").then((res) => {
        if (res.code == 200) {
            // console.log(res);
            res.data.forEach(function (item) {
                // 根据条件修改 name 字段
                if (item.name == '1') {
                    item.name = '已出租';
                } else if (item.name == '0') {
                    item.name = '未出租';
                } else {
                    item.name = '未知';
                }
            })
            option.series[0].data = res.data;
            houseStatusChart.setOption(option); // 确保在数据更新后设置选项  
        } else {
            // 处理错误情况，例如设置默认数据或显示错误消息  
        }
    });
    // 当窗口或者大小发生改变时执行resize，重新绘制图表 
    window.onresize = houseStatusChart.resize;
}





</script>

<style scoped lang='less'>
.container {
    width: auto;
    padding: 10px;
    box-sizing: border-box;

    .top-item {
        width: 100%;
        height: 100px;
        display: flex;
        justify-content: center;
        align-items: center;
        margin-bottom: 20px;
        text-align: center;
        border-radius: 10px;
        user-select: none;
        box-shadow: rgba(149, 157, 165, 0.2) 0px 8px 24px;
    }

    .log {
        width: 100%;
        display: flex;
        justify-content: center;

        div {
            padding: 10px 0;
            box-shadow: rgba(149, 157, 165, 0.2) 0px 8px 24px;
        }
    }

    .house {
        width: 100%;
        display: flex;
        justify-content: space-between;
        // background-color: pink;

        div {
            padding: 10px 0;
            // box-shadow: rgba(149, 157, 165, 0.2) 0px 8px 24px;
        }
    }

}
</style>