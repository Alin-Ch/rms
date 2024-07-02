<template>
    <div>
        <div class="container">
            <!-- 表格顶部搜索 -->
            <div class="handle-box">
                <el-button type="primary" :icon="Plus" @click="handleAdd">新增</el-button>
            </div>
            <!-- 表格部分 -->
            <el-table :data="tableData" default-expand-all row-key="id" border class="table" ref="multipleTable"
                header-cell-class-name="table-header">
                <el-table-column type="index" label="顺序" width="60" fixed />
                <el-table-column prop="name" label="名称" width="200" />
                <el-table-column prop="perms" label="权限编码" width="200" />
                <el-table-column prop="icon" label="图标" width="120">
                    <template #default="scope">
                        <el-icon>
                            <component :is="scope.row.icon"></component>
                        </el-icon>
                    </template>
                </el-table-column>
                <el-table-column prop="type" label="类型" width="120">
                    <template #default="scope">
                        <el-tag size="small" v-if="scope.row.type === 0">目录</el-tag>
                        <el-tag size="small" v-else-if="scope.row.type === 1" type="success">菜单</el-tag>
                        <el-tag size="small" v-else-if="scope.row.type === 2" type="info">按钮</el-tag>
                    </template>
                </el-table-column>
                <el-table-column prop="path" label="菜单URL" width="120" />
                <el-table-column prop="component" label="菜单组件" width="120" />
                <el-table-column prop="orderNum" label="排序号" width="80" />
                <el-table-column prop="statu" label="状态" width="100" align="center">
                    <template #default="scope">
                        <el-tag size="small" v-if="scope.row.statu === 0">禁用</el-tag>
                        <el-tag size="small" v-else-if="scope.row.statu === 1" type="success">正常</el-tag>
                    </template>
                </el-table-column>
                <el-table-column fixed="right" label="操作" min-width="200" align="center">
                    <template #default="scope">
                        <el-button type="primary" @click="handleEdit(scope.row)">
                            编辑
                        </el-button>
                        <el-button type="danger" @click="handleDelete(scope.row)">
                            删除
                        </el-button>
                    </template>
                </el-table-column>
            </el-table>
        </div>

        <!-- dialog弹出框 -->
        <el-dialog v-model="dialogVisible" :title="dialogMode" width="40%" draggable>
            <el-form label-width="100px" :model="editInfo" style="max-width: 460px">
                <!-- 上级菜单 -->
                <el-form-item label="上级菜单" prop="parentName" label-width="100px">
                    <el-select v-model="editInfo.parentId" placeholder="请选择上级菜单">
                        <div v-for="(item, index) in tableData" :key="index">
                            <el-option :label="item.name" :value="item.id"></el-option>
                            <div v-for="(child, index) in item.children" :key="index">
                                <el-option :label="child.name" :value="child.id">
                                    <span>{{ "- " + child.name }}</span>
                                </el-option>
                            </div>
                        </div>

                        <!-- <el-option-group v-for="item in tableData" :key="item.id" :label="item.name">
                            <el-option v-for="child in item.children" :key="child.id" :label="child.name"
                                :value="child.name" @click="selectId(child.id)">
                            </el-option>
                        </el-option-group> -->
                        <!-- <template>
                            <div v-for="(item, index) in tableData" :key="index">
                                <el-option :label="item.name" :value="item.id"></el-option>
                                <template>
                                    <div v-for="(child, index) in item.children" :key="index">
                                        <el-option :label="child.name" :value="child.id">
                                            <span>{{ "- " + child.name }}</span>
                                        </el-option>
                                    </div>
                                </template>
                            </div>
                        </template> -->
                    </el-select>
                </el-form-item>
                <!-- 菜单名称 -->
                <el-form-item label="菜单名称" prop="name" label-width="100px">
                    <el-input v-model="editInfo.name" auto-complete="off"></el-input>
                </el-form-item>
                <!-- 权限编码 -->
                <el-form-item label="权限编码" prop="perms" label-width="100px">
                    <el-input v-model="editInfo.perms" auto-complete="off"></el-input>
                </el-form-item>
                <!-- 图标 -->
                <el-form-item v-if="editInfo.type !== 2" label="图标" prop="icon" label-width="100px">
                    <el-input v-model="editInfo.icon" auto-complete="off"></el-input>
                </el-form-item>
                <!-- 菜单URL -->
                <el-form-item label="菜单URL" prop="path" label-width="100px">
                    <el-input v-model="editInfo.path" auto-complete="off"></el-input>
                </el-form-item>
                <!-- 菜单组件 -->
                <el-form-item label="菜单组件" prop="component" label-width="100px">
                    <el-input v-model="editInfo.component" auto-complete="off"></el-input>
                </el-form-item>
                <!-- 菜单类型 -->
                <el-form-item label="类型" prop="type" label-width="100px">
                    <el-radio-group v-model="editInfo.type">
                        <el-radio :label=0>目录</el-radio>
                        <el-radio :label=1>菜单</el-radio>
                        <el-radio :label=2>按钮</el-radio>
                    </el-radio-group>
                </el-form-item>
                <!-- 状态单选 -->
                <el-form-item label="状态" prop="statu" label-width="100px">
                    <el-radio-group v-model="editInfo.statu">
                        <el-radio :label=1>正常</el-radio>
                        <el-radio :label=0>禁用</el-radio>
                    </el-radio-group>
                </el-form-item>
                <!-- 排序号 -->
                <el-form-item label="排序号" prop="orderNum" label-width="100px">
                    <el-input-number v-model="editInfo.orderNum" :min="1" label="排序号">1</el-input-number>
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
import { ElMessage, ElMessageBox, selectKey } from 'element-plus';
import { Delete, Edit, Search, Plus } from '@element-plus/icons-vue';
import request from '@/utils/request';
import { uploadUrl } from '@/utils/request';

onMounted(() => {
    getData()
})

const tableData = ref([]);
const dialogVisible = ref(false);
// 获取表格数据
const getData = () => {
    request.get('/sys/menu/list').then((res) => {
        // console.log(res.data);
        if (res.code == 200) {
            tableData.value = res.data;
            // 遍历 tableData.value 中的每一项  
            tableData.value.forEach(item => {
                // 给当前项添加 parentName 属性，并赋值为它的 name 属性  
                item.parentName = item.name;
                // 如果当前项有 children 属性且是一个数组  
                if (Array.isArray(item.children)) {
                    // 遍历 children 数组中的每一项  
                    item.children.forEach(child => {
                        // 给子项添加 parentName 属性，并赋值为父项的 name 属性  
                        child.parentName = item.name;
                        // 如果子项还有更深的 children，递归处理  
                        if (Array.isArray(child.children)) {
                            addParentNameToChildren(child.children, item.name);
                        }
                    });
                }
            });
        } else {
            ElMessage.warning(res.msg);
        }
    }).catch((err) => {
        ElMessage.warning(err);
    })
};
// 递归函数，用于处理更深层次的 children  
function addParentNameToChildren(children, parentName) {
    children.forEach(child => {
        child.parentName = parentName;

        if (Array.isArray(child.children)) {
            addParentNameToChildren(child.children, parentName);
        }
    });
}
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
    editInfo.value = {};
}
const handleSubmit = () => {
    if (dialogMode.value == '新增') {
        request.post("/sys/menu/save", editInfo.value).then((res) => {
            if (res.code == 200) {
                ElMessage.success('新增成功!');
                getData();
                handleCancel();
            } else {
                ElMessage.warning(res.msg);
            }
        })
    } else {
        request.post("/sys/menu/update", editInfo.value).then((res) => {
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
// select选择器
const selectId = (id) => {
    editInfo.value.parentId = id
    console.log(editInfo.value);
}
// 删除操作
const handleDelete = (row) => {
    // 二次确认删除
    ElMessageBox.confirm('确定要删除吗？', '提示', {
        type: 'warning'
    }).then(() => {
        request.post("/sys/menu/delete/" + row.id).then((res) => {
            if (res.code == 200) {
                ElMessage.success('删除成功');
                getData();
            } else {
                ElMessage.warning(res.msg);
            }
        })
    }).catch(() => { });
};


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