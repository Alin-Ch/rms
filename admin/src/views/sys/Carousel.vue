<template>
    <div>
        <div class="container">
            <!-- 表格顶部搜索 -->
            <div class="handle-box">
                <el-button type="primary" :icon="Plus" @click="handleAdd">新增</el-button>
            </div>
            <!-- 表格部分 -->
            <el-table :data="tableData" style="width: 100%" border>
                <el-table-column fixed prop="id" label="id" width="100" />
                <el-table-column prop="url" label="图片" width="120">
                    <template v-slot="scope">
                        <el-image style="width: 90px; height: 90px; " :preview-teleported="true" :src="scope.row.url"
                            :preview-src-list="[scope.row.url]" fit="cover">
                        </el-image>
                    </template>
                </el-table-column>
                <el-table-column prop="description" label="描述" />
                <el-table-column prop="create_time" label="创建时间" width="180" />
                <el-table-column prop="update_time" label="更新时间" width="180" />
                <el-table-column fixed="right" label="操作" width="180" align="center">
                    <template v-slot="scope" #default>
                        <el-button type="primary" @click="handleEdit(scope.row)">编辑</el-button>
                        <el-button type="danger" @click="handleDelete(scope.row)">删除</el-button>
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
            <el-form label-width="100px" :model="editInfo">
                <!-- 头像部分，有些长 -->
                <el-form-item label="轮播图">
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
                <el-form-item label="描述">
                    <el-input v-model="editInfo.description" />
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
import { ElMessage, ElMessageBox } from 'element-plus';
import { Delete, Edit, Search, Plus, Pointer } from '@element-plus/icons-vue';
import request from '@/utils/request';
import { uploadUrl } from '@/utils/request';

onMounted(() => {
    getData()
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
    request.get('/sys/carousel/list', { params: params.value }).then((res) => {
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

// 编辑或者新增
const dialogMode = ref('新增');
const editInfo = ref({})
const handleEdit = (row) => {
    dialogMode.value = '编辑';
    const originInfo = { ...row }; // 创建 row 的副本
    dialogVisible.value = true;
    editInfo.value = originInfo;
    if (row.url != null) {
        fileList.value = [{
            url: row.url,
            name: row.url,
        }];
    }
}
const handleAdd = () => {
    dialogMode.value = '新增';
    dialogVisible.value = true;
    editInfo.value = {};
    fileList.value = [];
}
const handleCancel = () => {
    dialogVisible.value = false;
    editInfo.value = {};
    fileList.value = [];
}
const handleSubmit = () => {
    if (dialogMode.value == '新增') {
        request.post("/sys/carousel/save", editInfo.value).then((res) => {
            if (res.code == 200) {
                ElMessage.success('新增成功!');
                getData();
                handleCancel();
            } else {
                ElMessage.warning(res.msg);
            }
        })
    } else {
        request.post("/sys/carousel/update", editInfo.value).then((res) => {
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
// 上传图片成功
const successUpload = (res) => {
    // console.log(res);
    editInfo.value.url = res.data
}
// 删除操作
const handleDelete = (row) => {
    // 二次确认删除
    ElMessageBox.confirm('确定要删除吗？', '提示', {
        type: 'warning'
    }).then(() => {
        request.post("/sys/carousel/delete/" + row.id).then((res) => {
            if (res.code == 200) {
                ElMessage.success('删除成功!');
                getData();
            } else {
                ElMessage.warning(res.msg);
            }
        })
    }).catch(() => { });
};
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