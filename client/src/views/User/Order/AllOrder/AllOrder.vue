<template>
    <div>
        <!-- 展示全部订单的结构 -->
        <el-card class="box-card">
            <template #header>
                <div class="card-header">
                    <span>我的订单</span>
                    <!-- <el-button type="danger" @click="handleDelete">删除订单</el-button> -->
                </div>
            </template>
            <!-- 表格展示订单的数据 -->
            <el-table :data="orderList" border style="width: 100%;max-width: 1000px;">
                <el-table-column type="expand">
                    <template #default="props">
                        <div>
                            <el-table :data="[props.row.house]" border>
                                <el-table-column label="图片" width="120">
                                    <template #default="scope">
                                        <el-image class="table-td-thumb"
                                            :src="scope.row.list.length > 0 && scope.row.list[0].url ? scope.row.list[0].url : ''"
                                            :preview-src-list="scope.row.list.map(item => item.url || '').filter(url => url)"
                                            preview-teleported>
                                        </el-image>
                                    </template>
                                </el-table-column>
                                <el-table-column label="名称" prop="name" width="120" />
                                <el-table-column label="月租金" prop="price" width="120">
                                    <template #default="scope">￥{{ scope.row.price }} / 月</template>
                                </el-table-column>
                                <el-table-column label="地址" prop="location" width="350">
                                    <template #default="scope">{{ scope.row.location }} </template>
                                </el-table-column>
                                <el-table-column label="操作" prop="zip" fixed="right" width="140" align="center">
                                    <template #default="scope">
                                        <el-button type="primary" :icon="ZoomIn"
                                            @click="goHouseDetail(scope.row)">查看详情</el-button>
                                    </template>
                                </el-table-column>
                            </el-table>
                        </div>
                    </template>
                </el-table-column>
                <el-table-column prop="orderNo" label="订单编号" width="200">
                    <template #default="scope">
                        <strong>{{ scope.row.orderNo }}</strong>
                    </template>
                </el-table-column>
                <el-table-column prop="createTime" label="订单创建时间" width="180" sortable>
                    <template #default="scope">
                        <div style="display: flex; align-items: center">
                            <el-icon>
                                <timer />
                            </el-icon>
                            <span style="margin-left: 10px">{{ scope.row.createTime }}</span>
                        </div>
                    </template>
                </el-table-column>
                <el-table-column prop="money" label="订单金额" width="120" sortable>
                    <template #default="scope">
                        <el-tag :type="scope.row.status == 0 ? 'danger' : 'success'" disable-transitions>
                            <strong>￥{{ scope.row.money }}</strong>
                        </el-tag>
                    </template>
                </el-table-column>
                <el-table-column prop="status" label="订单状态" width="100" align="center">
                    <template #default="scope">
                        <el-tag :type="scope.row.status == '1' ? 'success' : scope.row.status == '0' ? 'danger' : ''">
                            <strong v-if="scope.row.status == 0">未支付</strong>
                            <strong v-if="scope.row.status == 1">已支付</strong>
                            <strong v-if="scope.row.status == 2">已退款</strong>
                            <strong v-if="scope.row.status == 4">超时取消</strong>
                        </el-tag>
                    </template>
                </el-table-column>
                <el-table-column label="房东" width="120" sortable>
                    <template #default="scope">
                        <strong style="color: #7f7f7f;">{{ scope.row.owner.username }}</strong>
                    </template>
                </el-table-column>
                <el-table-column label="操作" fixed="right" width="180">
                    <template #="{ row }">
                        <el-button type="primary" @click="goDetail(row)">详情</el-button>
                        <el-button v-if="row.status == 0" type="success" @click="goPay(row)">支付</el-button>
                        <el-button v-if="row.status == 1" type="primary" @click="goRefund(row)">退款</el-button>
                        <el-button v-if="row.status == 2" type="danger" @click="handleDelete(row)">删除</el-button>
                    </template>
                </el-table-column>
            </el-table>
            <!-- 分页器 -->
            <div class="pagination">
                <el-pagination @size-change="pageSizeChange" @current-change="pageChange" :current-page="params.current"
                    :page-sizes="[5, 10, 15, 20]" :page-size="params.size"
                    layout="total, sizes, prev, pager, next, jumper" :total="total">
                </el-pagination>
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
import { Search, Delete, Download, Plus, Timer, ZoomIn } from '@element-plus/icons-vue'

const store = useStore();
const route = useRoute();
const router = useRouter();
// 分页查询、模糊查询所需要的参数
const params = ref({
    orderNo: null,
    userId: null,
    current: 1,
    size: 10
});
onMounted(() => {
    getUserInfo()
    getOrderList()
})
// 获取用户信息
const getUserInfo = () => {
    const user = JSON.parse(localStorage.getItem("user"))
    params.value.userId = user.id
}

// 获取缴费信息
const orderList = ref([])
const getOrderList = () => {
    // console.log(params.value);
    request.get("/sys/order/list", { params: params.value }).then((res) => {
        // console.log(res);
        if (res.code == 200) {
            res.data.records.forEach(item => {
                const date = new Date(item.createTime);
                const year = date.getFullYear();
                const month = String(date.getMonth() + 1).padStart(2, '0');
                const day = String(date.getDate()).padStart(2, '0');
                item.createTime = `${year}-${month}-${day}`;
            });
            orderList.value = res.data.records;

            total.value = res.data.total
        } else {
            ElMessage.warning(res.msg)
        }
    })
}
//跳转详情页
const goDetail = (row) => {
    router.push({ path: "/user/order", query: { orderId: row.id } });
};

// 去支付
const goPay = (row) => {
    const user = JSON.parse(localStorage.getItem("user") || "{}");
    const username = user.username;
    const traceNo = row.orderNo;
    const totalAmount = row.money;
    const date = formatDate(row.createTime);
    var subject = username + '的' + date + '订单';
    // 请求一下，看看订单是否过期
    request.get("/sys/order/check/" + traceNo).then((res) => {
        if (res.data == true) {
            const hrefURL = baseURL + "/alipay/pay?subject=" + subject + "&traceNo=" + traceNo + "&totalAmount=" + totalAmount;
            window.location.href = hrefURL;
        }
    })
    // window.open(hrefURL)
}
// 退款
const goRefund = (row) => {
    console.log(row);
    const traceNo = row.orderNo;
    const alipayNo = row.alipayNo
    const totalAmount = row.money;
    ElMessageBox.confirm('确定要退款吗？', '提示', {
        type: 'warning'
    }).then(() => {
        // const url = `http://localhost:8000/alipay/refund?totalAmount=${totalAmount}&alipayTraceNo=${alipayNo}&traceNo=${traceNo}`
        const url = `${baseURL}/alipay/refund?totalAmount=${totalAmount}&alipayTraceNo=${alipayNo}&traceNo=${traceNo}`
        request.get(url).then(res => {
            // console.log(res);
            if (res.code == 200) {
                ElMessage.success("退款成功")
                getOrderList()
            } else {
                ElMessage.error(res.msg)
            }
        })
    }).catch(() => { })
}
// 删除
const handleDelete = (row) => {
    ElMessageBox.confirm("确定要删除吗？", "提示", { type: "warning", })
        .then(() => {
            request.post("/sys/order/delete", [row.id]).then((res) => {
                if (res.code == 200) {
                    ElMessage.success("删除成功!");
                    getOrderList();
                }
            });
        }).catch(() => {
            ElMessage.error("删除失败!");
        });
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
// 查看房屋详情
const goHouseDetail = (row) => {
    router.push({ path: '/house/detail', query: { id: row.id } })
}
// 分页器功能
const total = ref(0);
const pageSizeChange = (pageSize) => {
    params.value.size = pageSize;
    getCharge();
}
const pageChange = (pageNum) => {
    params.value.current = pageNum;
    getCharge();
}
</script>
<style scoped lang='less'></style>