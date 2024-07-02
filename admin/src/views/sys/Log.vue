<template>
    <div>
        <div class="container">
            <!-- 表格顶部搜索 -->
            <div class="handle-box">
                <el-input v-model="params.order_no" placeholder="订单号" class="handle-input mr10"></el-input>
                <el-button type="primary" :icon="Search" @click="handleSearch">搜索</el-button>
                <el-button type="danger" :icon="Delete" @click="handleDelete">批量删除</el-button>
            </div>
            <!-- 表格部分 -->
            <el-table :data="tableData" border class="table" ref="multipleTable" header-cell-class-name="table-header"
                @selection-change="handleSelectionChange">
                <el-table-column type="selection" width="55" align="center" />
                <el-table-column prop="id" label="ID" width="60" />
                <el-table-column prop="username" label="用户名称" width="150" />
                <el-table-column prop="operateName" label="操作" width="200" />
                <el-table-column prop="ip" label="用户IP" width="130" />
                <el-table-column prop="createTime" label="操作时间" width="180" />

                <el-table-column fixed="right" label="操作" width="150" align="center">
                    <template #default="scope">
                        <el-button type="danger" @click="handleDelete(scope.row)">
                            删除
                        </el-button>
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

    </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue';
import { ElMessage, ElMessageBox, ElTable } from 'element-plus';
import { Delete, Edit, Search, Plus, Pointer, Top } from '@element-plus/icons-vue';
import request from '@/utils/request';



onMounted(() => {
    getData()
})


// 分页查询、模糊查询所需要的参数
const params = ref({
    current: 1,
    size: 10,
})
const tableData = ref([]);
const total = ref(0);
// 获取表格数据
const getData = () => {
    request.get('/sys/logs/list', { params: params.value }).then((res) => {
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



const multipleSelection = ref([])
const handleSelectionChange = (val) => {
    multipleSelection.value = val
}
const handleDelete = (row) => {
    // console.log(row);
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
            request.post("/sys/logs/delete", ids).then((res) => {
                if (res.code == 200) {
                    ElMessage.success("删除成功!");
                    getData();
                    handleCancel();
                }
            });
        }).catch(() => {
        })
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