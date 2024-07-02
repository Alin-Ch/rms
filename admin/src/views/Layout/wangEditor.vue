<template>
    <div>
        <div class="container">
            <!-- 表格顶部搜索 -->
            <div class="top">
                <el-input v-model="params.feedbackTitle" class="searchInput" placeholder="反馈/公告 标题"
                    :prefix-icon="Search" clearable />
                <el-input v-model="params.feedbackContent" class="searchInput" placeholder="反馈/公告 内容"
                    :prefix-icon="Search" clearable />
                <el-button type="primary" :icon="Search" @click="handleSearch">搜索</el-button>
                <el-button type="primary" :icon="Plus" @click="handleAdd">新增</el-button>
            </div>
            <!-- 表格部分 -->
            <el-table :data="tableData" style="width: 100%" border>
                <el-table-column fixed sortable prop="createTime" label="日期" width="180" />
                <el-table-column prop="title" label="公告标题" width="200" />
                <el-table-column prop="content" label="公告内容" width="1500" />
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
        <el-dialog v-model="dialogVisible" :title="dialogMode" width="70%" @close="handleDialogClose">
            <el-form label-width="100px" :model="editInfo">
                <el-form-item label="公告标题">
                    <el-input v-model="editInfo.title" />
                </el-form-item>
                <el-form-item label="公告内容">
                    <div style="border: 1px solid #ccc">
                        <Toolbar style="border-bottom: 1px solid #ccc" :editor="editorRef"
                            :defaultConfig="toolbarConfig" :mode="mode" />
                        <Editor style="height: 500px; overflow-y: hidden;" v-model="editInfo.content"
                            :defaultConfig="editorConfig" :mode="mode" @onCreated="handleCreated" />
                    </div>
                </el-form-item>
            </el-form>
            <template #footer>
                <span class="dialog-footer">
                    <el-button @click="handleCancel">取消</el-button>
                    <el-button type="primary" @click="handleSubmit">确认</el-button>
                </span>
            </template>
        </el-dialog>
    </div>
</template>

<script setup>
import { ref, onMounted, shallowRef, onBeforeUnmount } from 'vue';
import { ElMessage, ElMessageBox } from 'element-plus';
import { Delete, Edit, Search, Plus, Pointer } from '@element-plus/icons-vue';
import request from '@/utils/request';
import { uploadUrl, uploadOssImage, uploadOssVideo } from '@/utils/request';
// 引入wangEditor相关
import '@wangeditor/editor/dist/css/style.css' // 引入 css
import { Editor, Toolbar } from '@wangeditor/editor-for-vue'

onMounted(() => {
    getData()
})

// 分页查询、模糊查询所需要的参数
const params = ref({
    title: '',
    content: '',
    current: 1,
    size: 10,
})
const tableData = ref([]);
const total = ref(0);
const dialogVisible = ref(false);
// 获取表格数据
const getData = () => {
    request.get('/sys/notice/list', { params: params.value }).then((res) => {
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

// wangEditor
// 编辑器实例，必须用 shallowRef
const editorRef = shallowRef()
// mode
const mode = ref('default') // 或 'simple'
const toolbarConfig = {}
const editorConfig = { MENU_CONF: {} }
editorConfig.MENU_CONF['uploadImage'] = {
    server: uploadOssImage,
    fieldName: 'file',
    maxFileSize: 10 * 1024 * 1024, // 10M
    // 上传之前触发
    onBeforeUpload(file) {    // JS 语法
        // file 选中的文件，格式如 { key: file }
        return file
    },
    // 上传进度的回调函数
    onProgress(progress) {       // JS 语法
        // progress 是 0-100 的数字
        // console.log('progress', progress)
    },
    // 单个文件上传成功之后
    onSuccess(file, res) {          // JS 语法
        console.log(`${file.name} 上传成功`, res)
    },
    // 单个文件上传失败
    onFailed(file, res) {           // JS 语法
        console.log(`${file.name} 上传失败`, res)
    },
    // 上传错误，或者触发 timeout 超时
    onError(file, err, res) {               // JS 语法
        console.log(`${file.name} 上传出错`, err, res)
    },
}
editorConfig.MENU_CONF['uploadVideo'] = {
    server: uploadOssVideo,
    fieldName: 'file',
    maxFileSize: 50 * 1024 * 1024, // 50M
    // 上传之前触发
    onBeforeUpload(file) {    // JS 语法
        // file 选中的文件，格式如 { key: file }
        return file
    },
    // 最多可上传几个文件，默认为 5
    maxNumberOfFiles: 3,
    // 选择文件时的类型限制，默认为 ['video/*'] 。如不想限制，则设置为 []
    allowedFileTypes: ['video/*'],
    // 单个文件上传成功之后
    onSuccess(file, res) {          // JS 语法
        console.log(`${file.name} 上传成功`, res)
    },
    // 单个文件上传失败
    onFailed(file, res) {          // JS 语法
        console.log(`${file.name} 上传失败`, res)
    },
}
const handleCreated = (editor) => {
    editorRef.value = editor // 记录 editor 实例，重要！
}
// 组件销毁时，也及时销毁编辑器
onBeforeUnmount(() => {
    const editor = editorRef.value
    if (editor == null) return
    editor.destroy()
})



// dialog关闭时调用  
const handleDialogClose = () => {
    // 在这里销毁编辑器  
    if (editorRef.value && editorRef.value.destroy) {
        editorRef.value.destroy();
        editorRef.value = null; // 清空引用  
    }
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
const handleSearch = () => {
    params.value.current = 1;
    getData();
}
const handleSubmit = () => {
    if (dialogMode.value == '新增') {
        request.post("/sys/notice/save", editInfo.value).then((res) => {
            if (res.code == 200) {
                ElMessage.success('新增成功!');
                getData();
                handleCancel();
            } else {
                ElMessage.warning(res.msg);
            }
        })
    } else {
        request.post("/sys/notice/update", editInfo.value).then((res) => {
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
        request.post("/sys/carousel/delete", row.id).then((res) => {
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

<style scoped lang="less">
.container {
    width: 95%;
    height: 100%;
    margin: -5px;

    .top {
        width: 95%;
        display: flex;
        margin-bottom: 20px;
        align-items: center;

        span {
            font-weight: bold;
            color: #7f7f7f;
            margin-right: 10px;
        }

        .searchInput {
            width: 200px;
            margin: 0 10px;
        }

        .el-select {
            margin: 0 10px;
        }
    }

    .collapse-box {
        width: 95%;
        padding: 0 20px;
    }

    .pagination {
        width: 90%;
        margin: 10px auto;
    }
}
</style>