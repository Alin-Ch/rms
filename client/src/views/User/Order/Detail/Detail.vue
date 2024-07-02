<template>
    <div>
        <!-- 订单详情 -->
        <el-card class="box-card">
            <!-- 卡片头部 -->
            <template #header>
                <div class="title">缴费详情</div>
            </template>
            <!-- 展示身体部分顶部结构 -->
            <div class="top">
                <!-- 左侧的标签 -->
                <el-tag class="ml-2" :type="orderInfo.status == 0 ? 'danger' : 'success'">
                    <div class="tag">
                        <span>
                            <svg t="1688905606401" class="icon" viewBox="0 0 1024 1024" version="1.1"
                                xmlns="http://www.w3.org/2000/svg" p-id="2909" width="16" height="16">
                                <path
                                    d="M512 1024C229.248 1024 0 794.752 0 512S229.248 0 512 0s512 229.248 512 512-229.248 512-512 512z m-114.176-310.954667a53.333333 53.333333 0 0 0 75.434667 0l323.328-323.328a53.333333 53.333333 0 1 0-75.434667-75.434666l-287.914667 283.306666-128.853333-128.853333a53.333333 53.333333 0 1 0-75.434667 75.434667l168.874667 168.874666z"
                                    fill="#79c25c" p-id="2910"></path>
                            </svg>
                        </span>
                        <span>{{ orderInfo.status == 0 ? "待支付" : "已支付" }}</span>
                    </div>
                </el-tag>
                <!-- 右侧信息 -->
                <div class="right_info">
                    <img src="../../../../assets/code_app.png" alt="" />
                    <div>
                        微信
                        <svg t="1688906186073" class="icon" viewBox="0 0 1024 1024" version="1.1"
                            xmlns="http://www.w3.org/2000/svg" p-id="4093" width="16" height="16">
                            <path
                                d="M664.250054 368.541681c10.015098 0 19.892049 0.732687 29.67281 1.795902-26.647917-122.810047-159.358451-214.077703-310.826188-214.077703-169.353083 0-308.085774 114.232694-308.085774 259.274068 0 83.708494 46.165436 152.460344 123.281791 205.78483l-30.80868 91.730191 107.688651-53.455469c38.558178 7.53665 69.459978 15.308661 107.924012 15.308661 9.66308 0 19.230993-0.470721 28.752858-1.225921-6.025227-20.36584-9.521864-41.723264-9.521864-63.862493C402.328693 476.632491 517.908058 368.541681 664.250054 368.541681zM498.62897 285.87389c23.200398 0 38.557154 15.120372 38.557154 38.061874 0 22.846334-15.356756 38.156018-38.557154 38.156018-23.107277 0-46.260603-15.309684-46.260603-38.156018C452.368366 300.994262 475.522716 285.87389 498.62897 285.87389zM283.016307 362.090758c-23.107277 0-46.402843-15.309684-46.402843-38.156018 0-22.941502 23.295566-38.061874 46.402843-38.061874 23.081695 0 38.46301 15.120372 38.46301 38.061874C321.479317 346.782098 306.098002 362.090758 283.016307 362.090758zM945.448458 606.151333c0-121.888048-123.258255-221.236753-261.683954-221.236753-146.57838 0-262.015505 99.348706-262.015505 221.236753 0 122.06508 115.437126 221.200938 262.015505 221.200938 30.66644 0 61.617359-7.609305 92.423993-15.262612l84.513836 45.786813-23.178909-76.17082C899.379213 735.776599 945.448458 674.90216 945.448458 606.151333zM598.803483 567.994292c-15.332197 0-30.807656-15.096836-30.807656-30.501688 0-15.190981 15.47546-30.477129 30.807656-30.477129 23.295566 0 38.558178 15.286148 38.558178 30.477129C637.361661 552.897456 622.099049 567.994292 598.803483 567.994292zM768.25071 567.994292c-15.213493 0-30.594809-15.096836-30.594809-30.501688 0-15.190981 15.381315-30.477129 30.594809-30.477129 23.107277 0 38.558178 15.286148 38.558178 30.477129C806.808888 552.897456 791.357987 567.994292 768.25071 567.994292z"
                                fill="#79c25c" p-id="4094"></path>
                        </svg>
                        关注桂鹏世纪城公众号<br />“快速缴费”
                    </div>
                </div>
            </div>
            <!-- 订单详情底部结构 -->
            <div class="bottom">
                <div class="left">
                    <el-descriptions class="margin-top" :column="1" border>
                        <el-descriptions-item>
                            <template #label>
                                <div class="cell-item">缴费单号</div>
                            </template>
                            {{ orderInfo.orderNo }}
                        </el-descriptions-item>
                        <el-descriptions-item>
                            <template #label>
                                <div class="cell-item">商品名称</div>
                            </template>
                            {{ orderInfo.house ? orderInfo.house.name : "" }}
                        </el-descriptions-item>
                        <el-descriptions-item>
                            <template #label>
                                <div class="cell-item">商品图片</div>
                            </template>
                            <el-image class="table-td-thumb" style="width: 100px;height: 100px;" v-if="orderInfo.house"
                                :src="orderInfo.house.list.length > 0 && orderInfo.house.list[0].url ? orderInfo.house.list[0].url : ''"
                                :preview-src-list="orderInfo.house.list.map(item => item.url || '').filter(url => url)"
                                preview-teleported>
                            </el-image>
                        </el-descriptions-item>
                        <el-descriptions-item>
                            <template #label>
                                <div class="cell-item">缴费开始时间</div>
                            </template>
                            {{ orderInfo.createTime }}
                        </el-descriptions-item>
                        <el-descriptions-item>
                            <template #label>
                                <div class="cell-item">房东</div>
                            </template>
                            {{ orderInfo.owner ? orderInfo.owner.username : "" }}
                        </el-descriptions-item>
                        <el-descriptions-item>
                            <template #label>
                                <div class="cell-item">缴费金额</div>
                            </template>
                            ￥ {{ orderInfo.money }}
                        </el-descriptions-item>
                    </el-descriptions>
                    <div class="btn">
                        <el-button type="primary" size="default" @click="chat">
                            联系商家
                        </el-button>
                        <el-button type="primary" size="default" @click="goPay" v-if="orderInfo.status == 0">
                            去支付
                        </el-button>
                    </div>
                </div>
            </div>
        </el-card>
    </div>
</template>

<script setup>
import { ref, reactive, toRefs, onBeforeMount, onMounted, watchEffect, computed } from 'vue';
import { useStore } from 'vuex';
import { useRoute, useRouter } from 'vue-router';
import request from '@/utils/request'
import { baseURL } from '@/utils/request';

const store = useStore();
const route = useRoute();
const router = useRouter();

onMounted(() => {
    getOrderInfo()
})
//获取订单数据
const orderInfo = ref({});
const getOrderInfo = async () => {
    let orderId = route.query.orderId;
    request.get("/sys/order/detail/" + orderId).then((res) => {
        console.log(res);
        if (res.code == 200) {
            orderInfo.value = res.data;
        } else {
        }
    })
};
// 去支付
const goPay = () => {
    const user = JSON.parse(localStorage.getItem("user") || "{}");
    const username = user.username;
    const traceNo = orderInfo.value.charge_no;
    const totalAmount = orderInfo.value.money;
    const date = formatDate(orderInfo.value.create_time);
    var subject = username + '的' + date + '账单';

    window.open(`${baseURL}/alipay/pay?subject=` + subject + "&traceNo=" + traceNo + "&totalAmount=" + totalAmount)
}
// 联系商家
const chat = () => {
    let orderId = route.query.orderId;
    let houseId = orderInfo.value.house.id;
    router.push({
        path: '/chat',
        query: {
            orderId: orderId,
            houseId: houseId
        }
    })
}
// 格式化时间
const formatDate = (time) => {
    // 原始日期字符串
    var createTimeString = time;
    // 将字符串转换为日期对象
    var createTime = new Date(createTimeString);
    // 获取年份和月份
    var year = createTime.getFullYear();
    var month = createTime.getMonth() + 1; // 月份从0开始，所以要加1
    // 格式化年月字符串
    var formattedDateString = year + '年' + month + '月份';
    return formattedDateString;
}
</script>
<style scoped lang='less'>
.box-card {
    .title {
        color: #7f7f7f;
        font-size: 18px;
        font-weight: 550;
    }

    .top {
        display: flex;
        justify-content: space-between;
        border-bottom: 1px solid #ccc;
        padding-bottom: 5px;

        .tag {
            display: flex;
            justify-content: center;
            align-items: center;

            span {
                margin-right: 10px;
            }
        }

        .right_info {
            display: flex;
            align-items: center;

            img {
                width: 50px;
                height: 50px;
            }

            div {
                color: #7f7f7f;
                font-size: 13px;
                line-height: 18px;
                margin-left: 5px;
            }
        }
    }

    .bottom {
        display: flex;
        margin-top: 10px;

        .left {
            flex: 4;

            .btn {
                margin: 10px 0;
            }
        }

        .right {
            flex: 5;
            margin-left: 10px;

            p {
                color: #7f7f7f;
                line-height: 30px;
            }
        }
    }
}

.qrcode {
    display: flex;
    flex-direction: column;
    align-items: center;

    p {
        margin-top: 10px;
    }
}
</style>