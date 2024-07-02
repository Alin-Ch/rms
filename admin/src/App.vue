<script setup>
import { ElConfigProvider } from 'element-plus';
import zhCn from 'element-plus/es/locale/lang/zh-cn';
</script>

<template>
  <!-- <div class="main">
    <router-view></router-view>
  </div> -->
  <el-config-provider :locale="zhCn">
    <vue3-water-marker text="房屋租赁后台管理系统" opacity="0.2"></vue3-water-marker>
    <router-view />
  </el-config-provider>
</template>

<style>
@import './assets/css/main.css';
@import './assets/css/color-dark.css';
/* .main {
  position: absolute;
  top: 0;
  right: 0;
  bottom: 0;
  left: 0;
  width: 100%;
}

.previewImg img {
  width: 100%;
  height: 100%;
} */
</style>
