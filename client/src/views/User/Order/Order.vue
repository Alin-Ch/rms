<template>
    <div>
        <div v-if="route.query.orderId">
            <Detail />
        </div>
        <div v-else>
            <AllOrder />
        </div>
    </div>
</template>

<script setup>
import { ref, reactive, toRefs, onBeforeMount, onMounted, watchEffect, computed } from 'vue';
import { useStore } from 'vuex';
import { useRoute, useRouter } from 'vue-router';
import Detail from './Detail/Detail.vue'
import AllOrder from './AllOrder/AllOrder.vue'

const store = useStore();
const route = useRoute();
const router = useRouter();

onMounted(() => {

})


</script>
<style scoped lang='less'></style>