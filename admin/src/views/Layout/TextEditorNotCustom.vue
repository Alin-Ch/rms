<template>
  <div style="border: 1px solid #ccc">
    <Toolbar style="border-bottom: 1px solid #ccc" :editor="editorRef" :defaultConfig="toolbarConfig" :mode="mode" />
    <Editor style="height: 350px; overflow-y: hidden;" v-model="valueHtml" :defaultConfig="editorConfig" :mode="mode"
      @onCreated="handleCreated" />
  </div>
</template>

<script setup>
import { onBeforeUnmount, ref, shallowRef, onMounted, watchEffect, watch } from 'vue'
import { uploadOssImage, uploadOssVideo } from '@/utils/request';
import request from '@/utils/request';
// 引入wangEditor相关
import '@wangeditor/editor/dist/css/style.css' // 引入 css
import { Editor, Toolbar } from '@wangeditor/editor-for-vue'
import { ElMessage } from 'element-plus';

// 组件通信的数据
// 声明事件消息
const emit = defineEmits(['update:modelValue'])
const props = defineProps({
  modelValue: {
    type: String,
    default: ''
  }
})
const valueHtml = ref("")
watchEffect(() => {
  valueHtml.value = props.modelValue
})
watch(valueHtml, (newHtml) => {
  emit('update:modelValue', newHtml)
})


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
// 创建
const handleCreated = (editor) => {
  editorRef.value = editor // 记录 editor 实例，重要！
}
// 组件销毁时，也及时销毁编辑器
onBeforeUnmount(() => {
  console.log("wangEditor组件销毁");
  const editor = editorRef.value
  if (editor == null) return
  editor.destroy()
})


</script>