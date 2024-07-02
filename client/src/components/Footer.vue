<template>
    <div class="container">
        <div>
            <span>Copyright © 2003-2022 China Southern Power Grid (csg).All rights reserved</span>
            <span>粤ICP备06044847号</span>
            <span>联系我们：0771-7888888</span>
        </div>

    </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useStore } from 'vuex';
import { useRoute, useRouter } from 'vue-router';

const store = useStore();
const route = useRoute();
const router = useRouter();


onMounted(() => {

})


</script>
<style scoped lang='less'>
.container {
    width: 100%;
    height: 65px;
    // position: absolute;
    bottom: 0;
    border-top: 1px solid #e6e6e6;
    background-color: #fff;

    div {
        display: flex;
        flex-direction: column;
        align-items: center;
        font-size: 15px;
        color: #7f7f7f;
        font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
    }
}
</style>