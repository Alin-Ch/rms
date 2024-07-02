<template>
    <div>
        <div ref="map" style="width: 100%; height: 300px;"></div>
        <div ref="infoWindow" style="display: none;"></div>
    </div>
</template>

<script setup>
import { ref, onMounted, watch } from 'vue';

const map = ref(null);
const infoWindow = ref(null);
let mapInstance = null;
let marker = null;
let markers = []; // 用于存储所有的标记

// 定义props，接收传入的houses数组
const props = defineProps({
    houses: {
        type: Array,
        default: () => []
    }
});

onMounted(() => {
    initMap();
    // const house = sessionStorage.getItem("house")
    // getUserLocation();
    watch(() => props.houses, () => {
        markHouses(props.houses);
    });
});

const initMap = () => {
    // 创建地图实例
    mapInstance = new BMap.Map(map.value);

    // 启用鼠标滚轮缩放功能
    mapInstance.enableScrollWheelZoom();

    // 初始化地图，设置中心点坐标和地图级别
    const point = new BMap.Point(110.0, 25.0);
    mapInstance.centerAndZoom(point, 15);

    // 添加地图控件
    mapInstance.addControl(new BMap.NavigationControl());
    mapInstance.addControl(new BMap.ScaleControl());
    mapInstance.addControl(new BMap.OverviewMapControl());
    mapInstance.addControl(new BMap.MapTypeControl());

    // 添加标记
    // marker = new BMap.Marker(point);
    // mapInstance.addOverlay(marker);

    // 添加点击事件
    // mapInstance.addEventListener('click', (e) => {
    //     const { lng, lat } = e.point;
    //     // console.log('经度:', lng, '纬度:', lat);

    //     // 移除之前的标记
    //     mapInstance.removeOverlay(marker);

    //     // 创建新的标记并添加到地图上
    //     marker = new BMap.Marker(e.point);
    //     mapInstance.addOverlay(marker);

    //     // 获取点击位置的地址信息
    //     const gc = new BMap.Geocoder();
    //     gc.getLocation(e.point, (rs) => {
    //         const address = rs.address;
    //         showInfoWindow(e.point, address);
    //     });
    // });
};

const getUserLocation = () => {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition((position) => {
            const { latitude, longitude } = position.coords;

            // 在地图上标注用户位置
            const point = new BMap.Point(longitude, latitude);
            mapInstance.centerAndZoom(point, 15);
            marker = new BMap.Marker(point);
            mapInstance.addOverlay(marker);

            // 获取用户位置的地址信息并展示
            const gc = new BMap.Geocoder();
            gc.getLocation(point, (rs) => {
                const address = rs.address;
                showInfoWindow(point, address);
            });
        }, (error) => {
            console.error('无法获取用户位置：', error);
        });
    } else {
        console.error('您的浏览器不支持Geolocation API');
    }
};

const showInfoWindow = (point, address) => {
    // console.log(point);
    const infoWindowInstance = new BMap.InfoWindow(address, {
        width: 200,
        height: 100,
        title: `位置:${point.lng.toFixed(4)},${point.lat.toFixed(4)}`,
        offset: new BMap.Size(0, -20) // 设置信息窗口相对于标记的偏移量，向上偏移20像素
    });
    mapInstance.openInfoWindow(infoWindowInstance, point);
};

// 标记点
const markHouses = (houses) => {
    // clearMarkers(); // 清除之前的标记
    houses.forEach((house) => {
        if (house && house.jingdu && house.weidu) {
            const point = new BMap.Point(Number(house.jingdu), Number(house.weidu));
            // console.log(point);
            const marker = new BMap.Marker(point);
            mapInstance.addOverlay(marker);
            markers.push(marker);

            marker.houseInfo = house; // 将房屋信息绑定到标记上
            marker.addEventListener('click', showHouseInfoWindow); // 添加点击事件
            // 展示
            showInfoWindow(point, house.address ? house.address : '房屋地址');
        }
    });

    if (markers.length > 0) {
        // const center = markers[0].getPosition(); // 将地图中心设置为第一个房屋的位置
        // mapInstance.panTo(center);
        mapInstance.centerAndZoom(markers[0].getPosition(), 15);
    }
};

const clearMarkers = () => {
    markers.forEach((marker) => {
        mapInstance.removeOverlay(marker);
    });
    markers = [];
};
// 展示房屋信息
const showHouseInfoWindow = (e) => {
    const marker = e.target;
    const info = marker.houseInfo.address ? marker.houseInfo.address : '房屋地址未知';
    const infoWindow = new BMap.InfoWindow(info,{
        width: 200,
        height: 100,
        title: `房屋信息:${marker.houseInfo.name}`,
        offset: new BMap.Size(0, -20) // 设置信息窗口相对于标记的偏移量，向上偏移20像素
    });
    mapInstance.openInfoWindow(infoWindow, marker.getPosition());
};


</script>

<style scoped></style>