<template>
  <v-header />
  <router-view class="router-view"></router-view>
  <v-footer />
</template>

<script setup>
import { ref, reactive, toRefs, onBeforeMount, onMounted, watchEffect, computed } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import vHeader from '@/components/Header.vue';
import vFooter from '@/components/Footer.vue';


const route = useRoute();
const router = useRouter();

onMounted(() => {
})

</script>

<style scoped lang='less'>
.router-view {
  flex: 1;
  /* 让 router-view 占据父容器的剩余空间 */
}
</style>