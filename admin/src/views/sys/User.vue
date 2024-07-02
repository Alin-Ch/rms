<template>
    <div>
        <div class="container">
            <!-- 表格顶部搜索 -->
            <div class="handle-box">
                <el-input v-model="params.username" placeholder="用户名" class="handle-input mr10"></el-input>
                <el-input v-model="params.phone" placeholder="手机号" class="handle-input mr10"></el-input>
                <el-button type="primary" :icon="Search" @click="handleSearch">搜索</el-button>
                <el-button type="primary" :icon="Plus" @click="handleAdd">新增</el-button>
            </div>
            <!-- 表格部分 -->
            <el-table :data="tableData" border class="table" ref="multipleTable" header-cell-class-name="table-header"
                @selection-change="handleSelectionChange">
                <el-table-column type="selection" width="55" align="center" />
                <el-table-column prop="id" label="ID" width="60" fixed />
                <el-table-column label="头像(查看大图)" align="center" width="120">
                    <template #default="scope">
                        <el-image class="table-td-thumb" :src="scope.row.avatar" :z-index="10"
                            :preview-src-list="[scope.row.avatar]" preview-teleported>
                        </el-image>
                    </template>
                </el-table-column>
                <el-table-column prop="username" label="用户名" width="120"></el-table-column>
                <el-table-column prop="code" label="角色名称" width="120">
                    <template #default="scope">
                        <el-tag size="small" type="success" v-for="(item, index) in scope.row.sysRoles" :key="index">
                            {{ item.name }}
                        </el-tag>
                    </template>
                </el-table-column>
                <el-table-column label="手机号" width="120">
                    <template #default="scope">{{ scope.row.phone }}</template>
                </el-table-column>
                <el-table-column prop="email" label="邮箱" width="180"></el-table-column>
                <el-table-column prop="age" label="年龄" width="80"></el-table-column>
                <el-table-column prop="idCard" label="身份证号" width="180"></el-table-column>
                <el-table-column prop="gender" label="性别" width="80">
                    <template #default="scope">
                        <!-- <el-tag :type="scope.row.gender == '1' ? 'success' : scope.row.gender == '0' ? 'danger' : ''">
                            {{ scope.row.gender == 1 ? '男' : '女' }}
                        </el-tag> -->
                        <el-tag>
                            {{ scope.row.gender == 1 ? '男' : '女' }}
                        </el-tag>
                    </template>
                </el-table-column>
                <el-table-column label="状态" align="center">
                    <template #default="scope">
                        <el-tag :type="scope.row.statu == '1' ? 'success' : scope.row.statu == '0' ? 'danger' : ''">
                            {{ scope.row.statu == 1 ? '启用' : (scope.row.statu == 0 ? '禁用' : '') }}
                        </el-tag>
                    </template>
                </el-table-column>
                <el-table-column prop="statu" label="账户状态" width="180">
                    <template v-slot="scope">
                        <el-switch v-model="scope.row.statu" size="large" active-text="启用" inactive-text="禁用"
                            :loading="switchLoading" :before-change="beforeStatusChange" :active-value="1"
                            :inactive-value="0" @change="statusChange(scope.row)" />
                    </template>
                </el-table-column>

                <el-table-column prop="created" label="注册时间" min-width="160" sortable></el-table-column>
                <el-table-column fixed="right" label="操作" width="270" align="center">
                    <template #default="scope">
                        <el-button type="primary" @click="dispatchRole(scope.row, this)">
                            分配角色
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
                <el-pagination @size-change="pageSizeChange" @current-change="pageChange" :current-page="params.current"
                    :page-sizes="[5, 10, 15, 20]" :page-size="params.size"
                    layout="total, sizes, prev, pager, next, jumper" :total="total">
                </el-pagination>
            </div>
        </div>

        <!-- dialog弹出框 -->
        <el-dialog v-model="dialogVisible" :title="dialogMode" width="40%" draggable>
            <el-scrollbar height="60vh">
                <span>
                    <el-form label-width="100px" :model="editInfo" style="max-width: 460px">
                        <!-- 头像部分，有些长 -->
                        <el-form-item label="头像">
                            <!-- 上传与预览 -->
                            <el-upload v-model:file-list="fileList" :action="uploadUrl" list-type="picture-card"
                                :on-preview="handlePicturePreview" :limit="1" :on-remove="handleRemove"
                                :on-success="successUpload">
                                <el-icon>
                                    <Plus />
                                </el-icon>
                            </el-upload>
                            <!-- 图片预览 -->
                            <el-dialog class="previewImg" v-model="imageVisible">
                                <img w-full :src="dialogImageUrl" alt="预览图片" />
                            </el-dialog>
                        </el-form-item>
                        <el-form-item label="用户名">
                            <el-input v-model="editInfo.username" />
                        </el-form-item>
                        <el-form-item label="手机号">
                            <el-input v-model="editInfo.phone" />
                        </el-form-item>
                        <el-form-item label="邮箱">
                            <el-input v-model="editInfo.email" />
                        </el-form-item>
                        <el-form-item label="身份证号">
                            <el-input v-model="editInfo.idCard" />
                        </el-form-item>
                        <el-form-item label="所处城市">
                            <elui-china-area-dht :leave="2" @change="areaChange"
                                v-model="showVal"></elui-china-area-dht>
                        </el-form-item>
                        <el-form-item label="年龄">
                            <el-input v-model="editInfo.age" type="number" />
                        </el-form-item>
                        <el-form-item label="性别">
                            <el-select v-model="editInfo.gender" placeholder="选择性别" style="width: 240px">
                                <el-option label="男" :value="1" />
                                <el-option label="女" :value="0" />
                            </el-select>
                        </el-form-item>
                    </el-form>
                </span>
            </el-scrollbar>

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
import { Delete, Edit, Search, Plus, Pointer } from '@element-plus/icons-vue';
import request from '@/utils/request';
import { uploadUrl } from '@/utils/request';
// 级联选择城市
import { EluiChinaAreaDht } from 'elui-china-area-dht'
const chinaData = new EluiChinaAreaDht.ChinaArea().chinaAreaflat
const showVal = ref([])
const areaChange = (e) => {
    const one = chinaData[e[0]]
    const two = chinaData[e[1]]
    // const three = chinaData[e[2]]
    editInfo.value.cityCodeOne = one.value
    editInfo.value.cityCodeTwo = two.value
    // editInfo.value.cityCodeThree = three.value
    editInfo.value.city = one.label + two.label
}

onMounted(() => {
    getData()
    getRoleTreeData()
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
    request.get('/sys/user/list', { params: params.value }).then((res) => {
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
    if (row.avatar != null) {
        fileList.value = [{
            url: row.avatar,
            name: row.avatar,
        }];
    }
    showVal.value.push(editInfo.value.cityCodeOne)
    showVal.value.push(editInfo.value.cityCodeTwo)
}
const handleAdd = () => {
    dialogMode.value = '新增';
    dialogVisible.value = true;
    editInfo.value = {};
    fileList.value = [];
}
const handleCancel = () => {
    dialogVisible.value = false;
    roleVisible.value = false;
    editInfo.value = {};
    fileList.value = [];
    // 地址级联选择需要清空
    showVal.value = [];
}
const handleSubmit = () => {
    if (dialogMode.value == '新增') {
        request.post("/sys/user/save", editInfo.value).then((res) => {
            if (res.code == 200) {
                ElMessage.success('新增成功!');
                getData();
                handleCancel();
            } else {
                ElMessage.warning(res.msg);
            }
        })
    } else {
        request.post("/sys/user/update", editInfo.value).then((res) => {
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
// 分配角色
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
    request.get("/sys/user/info/" + row.id).then((res) => {
        // console.log(res);
        if (res.code == 200) {
            let roleIds = []
            res.data.sysRoles.forEach(row => {
                roleIds.push(row.id)
            })
            roleForm.value = res.data
            vm.$nextTick(() => {
                vm.$refs.roleTree.setCheckedKeys(roleIds)
            })
        } else {
            ElMessage.warning(res.msg);
        }
    })
}
const submitRole = function () {
    var roleIds = roleTree.value.getCheckedKeys();
    // console.log(roleIds);
    request.post("/sys/user/role/" + roleForm.value.id, roleIds).then((res) => {
        console.log(res);
        if (res.code == 200) {
            ElMessage.success('分配角色成功!');
            getData();
            handleCancel();
        } else {
            ElMessage.warning(res.msg);
        }
    })
}
const getRoleTreeData = () => {
    request.get('/sys/role/list').then(res => {
        // 将 name 属性重命名为 label
        const modifiedRecords = res.data.records.map(record => {
            return { ...record, label: record.name };
        });
        // 更新 roleTreeData
        roleTreeData.value = modifiedRecords;
        // console.log(roleTreeData.value);
    })
}
// 头像部分（上传与预览）
// const uploadUrl = ref("http://localhost:8000/api/files/upload/oss/img")
const imageVisible = ref(false)
const dialogImageUrl = ref('')
const fileList = ref([])
const handleRemove = (file) => {
    const index = fileList.value.indexOf(file);
    if (index !== -1) {
        fileList.splice(index, 1);
    }
}
const handlePicturePreview = (file) => {
    dialogImageUrl.value = file.url
    imageVisible.value = true
}
// 上传头像成功
const successUpload = (res) => {
    // console.log(res);
    editInfo.value.avatar = res.data
}
// 删除操作
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
            request.post("/sys/user/delete", ids).then((res) => {
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
// 状态
const switchStatus = ref(false); // 开关的状态
const switchLoading = ref(false); // 开关的加载状态
const statusChange = (row) => {
    beforeStatusChange()
        .then(() => {
            // 发送请求
            request.post(`/sys/user/status/${row.id}`).then((res) => {
                if (res.code == 200) {
                    ElMessage.success('修改成功');
                    switchStatus.value = !switchStatus.value; // 切换开关状态
                    getData();
                } else {
                    ElMessage.warning(res.msg);
                }
            });
        })
        .catch((error) => {
            console.error(error);
            switchLoading.value = false;
        });
};
const beforeStatusChange = () => {
    switchLoading.value = true;
    return new Promise((resolve) => {
        setTimeout(() => {
            switchLoading.value = false;
            // ElMessage.success('成功！');
            resolve(true);
        }, 500);
    });
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