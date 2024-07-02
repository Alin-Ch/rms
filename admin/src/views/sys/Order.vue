<template>
    <div>
        <div class="container">
            <!-- 表格顶部搜索 -->
            <div class="handle-box">
                <el-input v-model="params.order_no" placeholder="订单号" class="handle-input mr10"></el-input>
                <el-button type="primary" :icon="Search" @click="handleSearch">搜索</el-button>
                <!-- <el-button type="success" :icon="Plus" @click="handleAdd">新增</el-button>
                <el-button type="danger" :icon="Delete" @click="handleDelete">批量删除</el-button> -->
                <el-button type="primary" :icon="Top" @click="exportExcel">导出为Excel</el-button>
            </div>
            <!-- 表格部分 -->
            <el-table :data="tableData" border class="table" ref="multipleTable" header-cell-class-name="table-header"
                @selection-change="handleSelectionChange">
                <el-table-column type="selection" width="55" align="center" />
                <!-- <el-table-column type="index" label="顺序" width="60" fixed /> -->
                <el-table-column prop="orderNo" label="订单编号" width="220" />
                <el-table-column prop="alipayNo" label="支付编号" width="260" />
                <!-- <el-table-column prop="house.name" label="房屋信息" width="120" />
                <el-table-column prop="owner.username" label="房东名称" width="120" />
                <el-table-column prop="owner.phone" label="房东电话" width="120" /> -->
                <el-table-column prop="user.username" label="租户名称" width="120" />
                <el-table-column prop="user.phone" label="租户电话" width="120" />
                <el-table-column prop="money" label="金额" width="100" align="center">
                    <template #default="scope">
                        <el-tag :type="scope.row.status == 0 ? 'danger' : 'success'" disable-transitions>
                            <strong>￥{{ scope.row.money }}</strong>
                        </el-tag>
                    </template>
                </el-table-column>
                <el-table-column label="订单状态" width="100" align="center">
                    <template #default="scope">
                        <el-tag :type="scope.row.status == '1' ? 'success' : scope.row.status == '0' ? 'danger' : ''">
                            <!-- <strong>{{ scope.row.status == 1 ? '已支付' : (scope.row.status == 0 ? '未支付' : '') }}</strong> -->
                            <strong v-if="scope.row.status == 0">未支付</strong>
                            <strong v-if="scope.row.status == 1">已支付</strong>
                            <strong v-if="scope.row.status == 2">已退款</strong>
                            <strong v-if="scope.row.status == 4">超时取消</strong>
                        </el-tag>
                    </template>
                </el-table-column>

                <el-table-column prop="createTime" label="订单创建时间" min-width="160" sortable></el-table-column>
                <el-table-column prop="updateTime" label="订单支付时间" min-width="160" sortable></el-table-column>
                <el-table-column fixed="right" label="操作" width="270" align="center">
                    <template #default="scope">
                        <el-button v-if="scope.row.status == 0" type="success"
                            @click="sendMessage(scope.row)">提醒</el-button>
                        <!-- <el-button v-if="scope.row.status == 0" type="success" @click="goPay(scope.row)">去支付</el-button> -->
                        <el-button v-if="scope.row.status == 1" @click="goRefund(scope.row)">退款</el-button>
                        <el-button type="primary" @click="handleEdit(scope.row)">编辑</el-button>
                        <!-- <el-button type="danger" @click="handleDelete(scope.row)">删除</el-button> -->
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
        </div>

        <!-- dialog弹出框 -->
        <el-dialog v-model="dialogVisible" :title="dialogMode" width="40%" draggable>
            <el-form label-width="100px" :model="editInfo" style="max-width: 460px">
                <el-form-item label="订单编号">
                    <el-input v-model="editInfo.orderNo" readonly placeholder="订单编号" />
                </el-form-item>
                <el-form-item label="支付编号">
                    <el-input v-model="editInfo.alipayNo" readonly placeholder="支付编号" />
                </el-form-item>
                <el-form-item label="房屋">
                    <el-select v-model="editInfo.houseName" placeholder="房屋" filterable remote reserve-keyword
                        :remote-method="houseRemoteMethod" :loading="loading" remote-show-suffix clearable
                        class="elselect" @clear="clearHouseId">
                        <el-option v-for="item in showHouseList" :key="item.value" :label="item.label"
                            :value="item.value" @click="getHouseId(item)" />
                    </el-select>
                </el-form-item>
                <el-form-item label="租户">
                    <el-select v-model="editInfo.username" placeholder="租户" filterable remote reserve-keyword
                        :remote-method="remoteMethod" :loading="loading" remote-show-suffix clearable class="elselect"
                        @clear="clearUserId">
                        <el-option v-for="item in showUserList" :key="item.value" :label="item.label"
                            :value="item.value" @click="getUserId(item)" />
                    </el-select>
                </el-form-item>
                <el-form-item label="定金">
                    <el-input v-model="editInfo.money" readonly placeholder="定金"
                        :formatter="(value) => `￥ ${value}`.replace(/\B(?=(\d{3})+(?!\d))/g, ',')"
                        :parser="(value) => value.replace(/\￥\s?|(,*)/g, '')" />
                </el-form-item>
                <el-form-item label="订单状态">
                    <el-select v-model="editInfo.status" placeholder="订单状态">
                        <el-option label="未支付" :value="0" />
                        <el-option label="已支付" :value="1" />
                    </el-select>
                </el-form-item>

            </el-form>

            <template #footer>
                <span class="dialog-footer">
                    <el-button @click="handleCancel">取消</el-button>
                    <el-button type="primary" @click="handleSubmit">
                        确认
                    </el-button>
                </span>
            </template>
        </el-dialog>
    </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue';
import { ElMessage, ElMessageBox, ElTable } from 'element-plus';
import { Delete, Edit, Search, Plus, Pointer, Top } from '@element-plus/icons-vue';
import request from '@/utils/request';
import { uploadUrl, baseURL } from '@/utils/request';
// Excel表格导出
import * as XLSX from "xlsx";
const exportExcel = () => {
    const data = XLSX.utils.json_to_sheet(tableData.value)//此处tableData.value为表格的数据
    const wb = XLSX.utils.book_new()
    XLSX.utils.book_append_sheet(wb, data, 'test-data')//test-data为自定义的sheet表名
    XLSX.writeFile(wb, '订单.xlsx')//test.xlsx为自定义的文件名
}

const getUserInfo = () => {
    return request.get("/sys/userInfo").then(res => {
        sessionStorage.setItem("userInfo", JSON.stringify(res.data))
    })
}
const goPay = (row) => {
    const user = JSON.parse(sessionStorage.getItem("userInfo"))
    const username = user.username;
    const traceNo = row.orderNo;
    const totalAmount = row.money;
    var subject = username + '的定金';

    window.open(baseURL + "/alipay/pay?subject=" + subject + "&traceNo=" + traceNo + "&totalAmount=" + totalAmount)
}
const goRefund = (row) => {
    const traceNo = row.orderNo;
    const alipayNo = row.alipayNo
    const totalAmount = row.money;
    ElMessageBox.confirm('确定要退款吗？', '提示', {
        type: 'warning'
    }).then(() => {
        // const url = `http://localhost:8000/alipay/refund?totalAmount=${totalAmount}&alipayTraceNo=${alipayNo}&traceNo=${traceNo}`
        const url = `${baseURL}/alipay/refund?totalAmount=${totalAmount}&alipayTraceNo=${alipayNo}&traceNo=${traceNo}`
        request.get(url).then(res => {
            console.log(res);
            if (res.code == 200) {
                ElMessage.success("退款成功")
                getData()
            } else {
                ElMessage.error(res.msg)
            }
        })
    }).catch(() => { })
}

onMounted(() => {
    getData()
    getAllUser()
    getAllHouse()
    getUserInfo()
})
// selector相关
const loading = ref(false)
const showUserList = ref([])
const userList = ref([])
const showHouseList = ref([])
const houseList = ref([])
const remoteMethod = (query) => {
    // console.log("query", query, "  -----------  ", userList.value);
    loading.value = true
    setTimeout(() => {
        loading.value = false
        showUserList.value = userList.value.filter((item) => {
            return item.label.includes(query)
        })
    }, 200)
}
const houseRemoteMethod = (query) => {
    // console.log("query", query, "  -----------  ", userList.value);
    loading.value = true
    setTimeout(() => {
        loading.value = false
        showHouseList.value = houseList.value.filter((item) => {
            return item.label.includes(query)
        })
    }, 200)
}
const getAllUser = () => {
    request.get('/sys/user/info/list').then((res) => {
        if (res.code == 200) {
            userList.value = res.data.map((item) => {
                return { value: `${item.username}`, label: `${item.username}-${item.phone}`, id: item.id }
            })
        } else {
            ElMessage.warning(res.msg);
        }
    }).catch((err) => {
        ElMessage.error(err);
    })
}
const getAllHouse = () => {
    request.get('/sys/house/info/list').then((res) => {
        // console.log(res);
        if (res.code == 200) {
            houseList.value = res.data.map((item) => {
                return { value: `${item.name}`, label: `${item.name}-${item.owner.username}`, id: item.id, price: item.price, ownerId: item.owner.id }
            })
        } else {
            ElMessage.warning(res.msg);
        }
    }).catch((err) => {
        console.log(err);
        ElMessage.error(err);
    })
}
const getHouseId = (item) => {
    // 其实是获取ownerId，也就是房东的id
    editInfo.value.ownerId = item.ownerId
    editInfo.value.houseId = item.id
    editInfo.value.money = item.price
}
const getUserId = (item) => {
    editInfo.value.userId = item.id
}
const clearUserId = () => {
    editInfo.value.userId = null
}
const clearHouseId = () => {
    editInfo.value.houseId = null
}


// 分页查询、模糊查询所需要的参数
const params = ref({
    order_no: "",
    current: 1,
    size: 10,
})
const tableData = ref([]);
const total = ref(0);
const dialogVisible = ref(false);
// 获取表格数据
const getData = () => {
    request.get('/sys/order/list', { params: params.value }).then((res) => {
        // console.log(res);
        if (res.code == 200) {
            // console.log(res.data.list);
            total.value = res.data.total;
            tableData.value = res.data.records;
        } else {
            ElMessage.warning(res.msg);
        }
    }).catch((err) => {
        ElMessage.warning(err);
    })
}
// 查询操作
const handleSearch = () => {
    params.value.pageNum = 1;
    getData();
}

// 编辑或者新增
const dialogMode = ref('新增');
const editInfo = ref({})
const handleEdit = (row) => {
    dialogMode.value = '编辑';
    const originInfo = { ...row }; // 创建 row 的副本
    dialogVisible.value = true;
    editInfo.value = originInfo;
    editInfo.value.houseName = row.house.name ? row.house.name : ""
    editInfo.value.username = row.user.username ? row.user.username : ""
}
const handleAdd = () => {
    dialogMode.value = '新增';
    dialogVisible.value = true;
    editInfo.value = {};
}
const handleCancel = () => {
    dialogVisible.value = false;
    editInfo.value = {};
}
const handleSubmit = () => {
    // console.log("editInfo.value：", editInfo.value);
    if (dialogMode.value == '新增') {
        request.post("/sys/order/save", editInfo.value).then((res) => {
            if (res.code == 200) {
                ElMessage.success('新增成功!');
                getData();
                handleCancel();
            } else {
                ElMessage.warning(res.msg);
            }
        })
    } else {
        request.post("/sys/order/update", editInfo.value).then((res) => {
            if (res.code == 200) {
                ElMessage.success(`修改成功!`);
                getData();
                handleCancel();
            } else {
                ElMessage.warning(res.msg);
            }
        })
    }

}


// 批量删除
const multipleSelection = ref([])
const handleSelectionChange = (val) => {
    multipleSelection.value = val
    // // console.log(val);
    // const ids = val.map(v => v.id);
    // // console.log(ids);
    // request.post("/sys/order/delete", ids).then((res) => {
    //     if (res.code == 200) {
    //         ElMessage.success('删除成功');
    //         getData();
    //     } else {
    //         ElMessage.warning(res.msg);
    //     }
    // })
}
const handleDelete = (row) => {
    console.log(row);
    var ids = [];
    if (multipleSelection.value.length == 1) {
        ids.push(multipleSelection.value[0].id);
    } else {
        multipleSelection.value.forEach((item) => {
            ids.push(item.id);
        });
    }
    if (row.id) {
        ids.push(row.id);
    }
    if (ids.length == 0) {
        ElMessage.warning("请选择要删除的数据!");
        return;
    }
    ElMessageBox.confirm("确定要删除吗？", "提示", { type: "warning", })
        .then(() => {
            // console.log(ids);
            request.post("/sys/order/delete", ids).then((res) => {
                if (res.code == 200) {
                    ElMessage.success("删除成功!");
                    getData();
                    handleCancel();
                }
            });
        }).catch(() => {
            ElMessage.error("删除失败!");
        });
}
// 提醒
const sendMessage = (row) => {
    const message = {
        title: "订单提醒",
        content: `您有一笔订单需要处理，请及时处理。\n订单号：${row.orderNo}\n房屋信息：${row.house.name}\n应付金额：￥ ${row.money} 元`,
        senderId: JSON.parse(sessionStorage.getItem("user")).id,
        receiverId: row.user.id
    }
    console.log(message);
    ElMessageBox.confirm('确定要提醒吗？', '提示', {
        type: 'warning'
    }).then(() => {
        request.post("/sys/message/send", message).then((res) => {
            if (res.code == 200) {
                ElMessage.success('提醒成功');
            } else {
                ElMessage.warning(res.msg);
            }
        })
    }).catch(() => { });
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

<style scoped>
.container {
    width: 95%;
    height: 100%;
    margin: -5px;
}

.handle-box {
    margin-bottom: 20px;
}

.handle-select {
    width: 120px;
}

.handle-input {
    width: 300px;
}

.table {
    width: 100%;
    font-size: 14px;
}

.red {
    color: #F56C6C;
}

.mr10 {
    margin-right: 10px;
}

.table-td-thumb {
    display: block;
    margin: auto;
    width: 50px;
    height: 50px;
}


/* 头像预览 */
.previewImg img {
    width: 100%;
    height: 100%;
}
</style>