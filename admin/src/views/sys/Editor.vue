<template>
    <div class="container">
        <el-card style="border: none; margin: -30px;" shadow="never">
            <template #header>
                <div class="card-header">
                    <span>{{ editInfo.id ? '编辑公告' : '新增公告' }}</span>
                </div>
            </template>
            <el-form label-width="100px" :model="editInfo">
                <el-form-item label="公告标题">
                    <el-input v-model="editInfo.title" />
                </el-form-item>
                <el-form-item label="公告内容">
                    <div style="border: 1px solid #ccc">
                        <Toolbar style="border-bottom: 1px solid #ccc" :editor="editorRef"
                            :defaultConfig="toolbarConfig" :mode="mode" />
                        <Editor style="height: 350px; overflow-y: hidden;" v-model="editInfo.content"
                            :defaultConfig="editorConfig" :mode="mode" @onCreated="handleCreated" />
                    </div>
                </el-form-item>
            </el-form>
            <template #footer>
                <div class="footer-buttons">
                    <el-button class="cancel-button" @click="handleCancel">取消</el-button>
                    <el-button class="submit-button" type="primary" @click="handleSubmit">确认</el-button>
                </div>
            </template>
        </el-card>
    </div>
</template>

<script setup>
import { ref, shallowRef, onMounted, onBeforeUnmount, onBeforeMount } from 'vue';
import { useStore } from 'vuex';
import { useRoute, useRouter } from 'vue-router';
import { uploadOssImage, uploadOssVideo } from '@/utils/request';
import request from '@/utils/request';
// 引入wangEditor相关
import '@wangeditor/editor/dist/css/style.css' // 引入 css
import { Editor, Toolbar } from '@wangeditor/editor-for-vue'
import { ElMessage } from 'element-plus';

const route = useRoute();
const router = useRouter();

const editInfo = ref({})
onBeforeMount(() => {
    getData()
})
const getData = () => {
    const id = route.query.id;
    // console.log("id", id);
    editInfo.value = sessionStorage.getItem('editInfo') ? JSON.parse(sessionStorage.getItem('editInfo')) : {};
    // console.log(editInfo.value);
    sessionStorage.removeItem('editInfo')
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
// 取消
const handleCancel = () => {
    editInfo.value = {};
    // 返回上一级
    router.back();
}
// 确定
const handleSubmit = () => {
    if (editInfo.value.title == '' || !editInfo.value.title) {
        ElMessage.warning('请输入公告标题!');
        return;
    }
    if (editInfo.value.content == '' || editInfo.value.content == '<p><br></p>') {
        ElMessage.warning('请输入公告内容!');
        return;
    }
    if (!editInfo.value.id) {
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

</script>
<style scoped lang='less'>
.footer-buttons {
    display: flex;
    justify-content: flex-end;
}

.cancel-button,
.submit-button {
    width: 100px;
    height: 40px;
    font-size: 18px;
    margin-left: 10px;
}
</style>