<template>
    <div class="login-container">
        <video autoplay loop muted class="video-background">
            <source src="../assets/video.mp4" type="video/mp4">
            Your browser does not support the video tag.
        </video>
        <div class="login-content">
            <!-- 登录表单等内容 -->
        </div>
    </div>
</template>

<script>
export default {
    name: 'Login',
    // 其他组件配置
}
</script>

<style>
.video-background {
    position: fixed;
    right: 0;
    bottom: 0;
    min-width: 100%;
    min-height: 100%;
    width: auto;
    height: auto;
    z-index: -1;
}

.login-container {
    position: relative;
    width: 100vw;
    height: 100vh;
    overflow: hidden;
}

.login-content {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
}
</style>