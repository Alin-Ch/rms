<template>
    <div>
        <div class="container">
            <!-- 表格顶部搜索 -->
            <div class="handle-box">
                <el-input v-model="params.username" placeholder="用户名" class="handle-input mr10"></el-input>
                <el-button type="primary" :icon="Search" @click="handleSearch">搜索</el-button>
                <el-button type="primary" :icon="Plus" @click="handleAdd">新增</el-button>
            </div>
            <!-- 表格部分 -->
            <el-table :data="tableData" border class="table" ref="multipleTable" header-cell-class-name="table-header">
                <el-table-column type="index" label="顺序" width="60" fixed />
                <el-table-column prop="name" label="名称" width="120" />
                <el-table-column prop="code" label="唯一编码" width="120" />
                <el-table-column prop="statu" label="状态" width="120">
                    <template #default="scope">
                        <el-tag size="small" v-if="scope.row.statu === 1" type="success">正常</el-tag>
                        <el-tag size="small" v-else-if="scope.row.statu === 0" type="danger">禁用</el-tag>
                    </template>
                </el-table-column>
                <el-table-column prop="remark" label="描述" />
                <el-table-column fixed="right" label="操作" width="270" align="center">
                    <template #default="scope">
                        <el-button type="primary" @click="dispatchRole(scope.row, this)">
                            分配权限
                        </el-button>
                        <el-button type="primary" @click="handleEdit(scope.row)">
                            编辑
                        </el-button>
                        <el-button type="danger" @click="handleDelete(scope.row)">
                            删除
                        </el-button>
                    </template>
                </el-table-column>
            </el-table>
            <!-- 分页器 -->
            <div class="pagination">
                <el-pagination @size-change="pageSizeChange" @current-change="pageChange" :current-page="params.pageNum"
                    :page-sizes="[5, 10, 15, 20]" :page-size="params.pageSize"
                    layout="total, sizes, prev, pager, next, jumper" :total="total">
                </el-pagination>
            </div>
        </div>

        <!-- dialog弹出框 -->
        <el-dialog v-model="dialogVisible" :title="dialogMode" width="40%" draggable>
            <el-form label-width="100px" :model="editInfo" style="max-width: 460px">
                <!-- 角色名称 -->
                <el-form-item label="角色名称" prop="name" label-width="100px">
                    <el-input v-model="editInfo.name" auto-complete="off"></el-input>
                </el-form-item>
                <!-- 唯一编码 -->
                <el-form-item label="唯一编码" prop="code" label-width="100px">
                    <el-input v-model="editInfo.code" auto-complete="off"></el-input>
                </el-form-item>
                <!-- 描述 -->
                <el-form-item label="描述" prop="remark" label-width="100px">
                    <el-input v-model="editInfo.remark" auto-complete="off"></el-input>
                </el-form-item>
                <!-- 状态单选 -->
                <el-form-item label="状态" prop="statu" label-width="100px">
                    <el-radio-group v-model="editInfo.statu">
                        <el-radio :label=1>正常</el-radio>
                        <el-radio :label=0>禁用</el-radio>
                    </el-radio-group>
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
        <el-dialog v-model="roleVisible" title="分配角色" width="40%" draggable>
            <el-form :model="roleForm">
                <el-tree :data="roleTreeData" show-checkbox :default-expand-all="true" :check-strictly=checkStrictly
                    node-key="id" ref="roleTree" :props="defaultProps">
                </el-tree>
            </el-form>
            <template #footer>
                <span class="dialog-footer">
                    <el-button @click="handleCancel">取消</el-button>
                    <el-button type="primary" @click="submitRole">
                        确认
                    </el-button>
                </span>
            </template>
        </el-dialog>
    </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue';
import { ElMessage, ElMessageBox } from 'element-plus';
import { Delete, Edit, Search, Plus } from '@element-plus/icons-vue';
import request from '@/utils/request';
import { uploadUrl } from '@/utils/request';

onMounted(() => {
    getData();
    getTreeData()
})

// 分页查询、模糊查询所需要的参数
const params = ref({
    username: '',
    phone: '',
    id_card: '',
    email: '',
    current: 1,
    size: 10,
})
const tableData = ref([]);
const total = ref(0);
const dialogVisible = ref(false);
// 获取表格数据
const getData = () => {
    request.get('/sys/role/list', { params: params.value }).then((res) => {
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
};
// 树形相关
const roleForm = ref({})
const roleTreeData = ref([])
const checkStrictly = ref(true)
const defaultProps = {
    children: 'children',
    label: 'name'
}
const roleVisible = ref(false)
const roleTree = ref(null)
const dispatchRole = (row, vm) => {
    roleVisible.value = true;
    request.get("/sys/role/info/" + row.id).then((res) => {
        // console.log(res);
        if (res.code == 200) {
            roleForm.value = res.data
            vm.$nextTick(() => {
                vm.$refs.roleTree.setCheckedKeys(res.data.menusIds)
            })
        } else {
            ElMessage.warning(res.msg);
        }
    })
}
const submitRole = function () {
    var roleIds = roleTree.value.getCheckedKeys();
    // console.log(roleIds);
    request.post("/sys/role/perm/" + roleForm.value.id, roleIds).then((res) => {
        console.log(res);
        if (res.code == 200) {
            ElMessage.success('分配权限成功!');
            getData();
            handleCancel();
        } else {
            ElMessage.warning(res.msg);
        }
    })
}
const getTreeData = () => {
    request.get('/sys/menu/list').then(res => {
        // console.log(res);
        const modifiedRecords = res.data.map(item => {
            return { ...item, label: item.name };
        });
        roleTreeData.value = modifiedRecords
    })
}

// 查询操作
const handleSearch = () => {
    params.value.pageNum = 1;
    getData();
};
// 编辑或者新增
const dialogMode = ref('新增');
const editInfo = ref({})
const handleEdit = (row) => {
    dialogMode.value = '编辑';
    const originInfo = { ...row }; // 创建 row 的副本
    dialogVisible.value = true;
    editInfo.value = originInfo;
}
const handleAdd = () => {
    dialogMode.value = '新增';
    dialogVisible.value = true;
    editInfo.value = {};
}
const handleCancel = () => {
    dialogVisible.value = false;
    roleVisible.value = false;
    editInfo.value = {};
}
const handleSubmit = () => {
    if (dialogMode.value == '新增') {
        request.post("/sys/role/save", editInfo.value).then((res) => {
            if (res.code == 200) {
                ElMessage.success('新增成功!');
                getData();
                handleCancel();
            } else {
                ElMessage.warning(res.msg);
            }
        })
    } else {
        request.post("/sys/role/update", editInfo.value).then((res) => {
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

// 删除操作
const handleDelete = (row) => {
    // 二次确认删除
    ElMessageBox.confirm('确定要删除吗？', '提示', {
        type: 'warning'
    }).then(() => {
        ElMessage.success('删除成功');
    }).catch(() => { });
};
// 分页器功能
const pageSizeChange = (pageSize) => {
    params.value.pageSize = pageSize;
    getData();
}
const pageChange = (pageNum) => {
    params.value.pageNum = pageNum;
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