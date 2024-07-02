<template>
    <baidu-map class="bm-view" :center="center" :zoom="zoom" @ready="handler" :scroll-wheel-zoom="true"
        @click="clickBaiduMap">
        <bm-marker :position="marker.position" animation="BMAP_ANIMATION_BOUNCE">
            <bm-info-window :show="true">
                <bm-label :content="marker.content" :labelStyle="{ color: 'red', fontSize: '24px' }"
                    :offset="{ width: -35, height: 30 }" />
            </bm-info-window>
        </bm-marker>
    </baidu-map>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useRoute, useRouter } from 'vue-router';

const route = useRoute();
const router = useRouter();

const center = ref({ lng: 0, lat: 0 });
const zoom = ref(3);
// 地图上的红点
const marker = ref({position:{ lng: 110.30378, lat: 25.06254 }});
// 地图容器初始化
const handler = ({ BMap, map }) => {
    // console.log(BMap, map);
    center.value.lng = 110.30378;
    center.value.lat = 25.06254;
    zoom.value = 15;
}
// 点击地图
const clickBaiduMap = ({ type, target, point, pixel, overlay }) => {
    // console.log(point);
    marker.value.position = { lng: point.lng, lat: point.lat }
    marker.value.content = '我是点击的点'
    console.log(marker.value);
}

onMounted(() => {
})

</script>
<style scoped lang='less'>
.bm-view {
    width: 100%;
    height: 90%;
}
</style>