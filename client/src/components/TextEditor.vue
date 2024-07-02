<template>
  <div style="border: 1px solid #ccc">
    <Toolbar style="border-bottom: 1px solid #ccc" :editor="editorRef" :defaultConfig="toolbarConfig" :mode="mode" />
    <Editor style="height: 350px; overflow-y: hidden;" v-model="valueHtml" :defaultConfig="editorConfig" :mode="mode"
      @onCreated="handleCreated" />
  </div>
</template>

<script setup>
import { onBeforeUnmount, ref, shallowRef, onMounted, watchEffect, watch } from 'vue'
import { uploadOssImage, uploadOssVideo, uploadUrl } from '@/utils/request';
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
const editorConfig = {
  MENU_CONF: {
    uploadImage: {
      server: uploadUrl,
      fieldName: 'file',
      maxFileSize: 20 * 1024 * 1024, // 20M
      maxNumberOfFiles: 10,
      allowedFileTypes: ['image/*'],
      customInsert(res, insertFn) {
        if (res.code === 200) {
          console.log('res', res.data);
          insertFn(res.data)
        } else {
          ElMessage.error(res.msg)
          throw new Error(res.msg)
        }
      }
    },
    uploadVideo: {
      server: uploadUrl,
      fieldName: 'file',
      maxFileSize: 200 * 1024 * 1024, // 20M
      maxNumberOfFiles: 10,
      allowedFileTypes: ['video/*'],
      customInsert(res, insertFn) {
        if (res.code === 200) {
          console.log('res', res.data);
          insertFn(res.data)
        } else {
          ElMessage.error(res.msg)
          throw new Error(res.msg)
        }
      }
    },
  }
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