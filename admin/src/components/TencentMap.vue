<template>
    <div>
        <div ref="mapContainer"></div>
    </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
// import jsonp from 'jsonp';

const mapContainer = ref(null);
const weidu = 25.063238;
const jingdu = 110.299288;
const key = 'FIZBZ-H3LWB-UQYUF-JJQ3M-6KD47-W3FAH';
let qqmapsdk = null;

onMounted(() => {
    qqmapsdk = new window.qq.maps.Map(mapContainer.value, {
        center: new window.qq.maps.LatLng(weidu, jingdu),
        zoom: 11,
    });

    // 其他地图相关操作...

    // 示例：监听地图点击事件
    window.qq.maps.event.addListener(qqmapsdk, 'click', (event) => {
        const lat = event.latLng.getLat();
        const lng = event.latLng.getLng();
        getAreaCode(lat, lng);
        sendMessage(lat, lng);
    });
});

const sendMessage = (lat, lng, info) => {
    const data = { lat, lng, info };
    // 发送数据
};

const getAreaCode = (lat, lng) => {
    jsonp(`https://apis.map.qq.com/ws/geocoder/v1/?`, {
        location: `${lat},${lng}`,
        key,
        output: 'jsonp',
    }).then((res) => {
        const info = res.result.formatted_addresses.standard_address;
        sendMessage(lat, lng, info);
    });
};

const searchLocation = (searchText) => {
    const url = `https://apis.map.qq.com/ws/place/v1/search?boundary=nearby(${weidu},${jingdu},5000)&keyword=${encodeURIComponent(searchText)}&page_size=5&page_index=1&key=${key}`;
    jsonp(url, { output: 'jsonp' }).then((res) => {
        // 处理搜索结果
    });
};


</script>

<style scoped lang="less">
#mapContainer {
    width: 350px;
    height: 350px;
}
</style>