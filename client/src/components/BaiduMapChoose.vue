<template>
    <div>
        <div ref="map" style="width: 100%; height: 400px;"></div>
        <div ref="infoWindow" style="display: none;"></div>
        <!-- <button @click="locateUser">定位</button> -->
    </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';

const map = ref(null);
const infoWindow = ref(null);
let mapInstance = null;
let marker = null;

onMounted(() => {
    locateUser()
    initMap();
});

// 地图初始化
const initMap = () => {
    // 创建地图实例
    mapInstance = new BMap.Map(map.value);
    // 启用鼠标滚轮缩放功能
    mapInstance.enableScrollWheelZoom();
    // 添加定位控件
    const geolocationControl = new BMap.GeolocationControl();
    geolocationControl.addEventListener('locationSuccess', function (e) {
        // 定位成功事件
        const lng = e.point.lng;
        const lat = e.point.lat;

        // 移除之前的标记
        mapInstance.removeOverlay(marker);

        // 创建新的标记并添加到地图上
        const userPoint = new BMap.Point(lng, lat);
        marker = new BMap.Marker(userPoint);
        mapInstance.addOverlay(marker);

        // 将地图中心移动到用户当前位置
        mapInstance.panTo(userPoint);

        // 获取点击位置的地址信息
        const gc = new BMap.Geocoder();
        gc.getLocation(userPoint, (rs) => {
            const address = rs.address;
            showInfoWindow(userPoint, address); // 调用显示信息窗口函数
        });
    });
    mapInstance.addControl(geolocationControl);


    // 初始化地图，设置中心点坐标和地图级别
    const point = new BMap.Point(116.404, 39.915);
    mapInstance.centerAndZoom(point, 15);

    // 添加地图控件
    mapInstance.addControl(new BMap.NavigationControl());
    mapInstance.addControl(new BMap.ScaleControl());
    mapInstance.addControl(new BMap.OverviewMapControl());
    mapInstance.addControl(new BMap.MapTypeControl());

    // 添加标记
    marker = new BMap.Marker(point);
    mapInstance.addOverlay(marker);

    // 添加点击事件
    mapInstance.addEventListener('click', (e) => {
        const { lng, lat } = e.point;
        // console.log('经度:', lng, '纬度:', lat);

        // 移除之前的标记
        mapInstance.removeOverlay(marker);

        // 创建新的标记并添加到地图上
        marker = new BMap.Marker(e.point);
        mapInstance.addOverlay(marker);

        // 获取点击位置的地址信息
        const gc = new BMap.Geocoder();
        gc.getLocation(e.point, (rs) => {
            const address = rs.address;
            showInfoWindow(e.point, address);
        });
    });
};
// 展示小红点
const showInfoWindow = (point, address) => {
    console.log(point);
    const infoWindowInstance = new BMap.InfoWindow(address, {
        width: 200,
        height: 100,
        title: `点击位置:${point.lng.toFixed(4)},${point.lat.toFixed(4)}`,
        offset: new BMap.Size(0, -20) // 设置信息窗口相对于标记的偏移量，向上偏移20像素
    });
    mapInstance.openInfoWindow(infoWindowInstance, point);
};





// 用户一进来先获取定位
const locateUser = () => {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(showUserPosition, handleLocationError);
    } else {
        console.log('浏览器不支持地理位置获取功能。');
        // 处理浏览器不支持地理位置获取的情况
    }
};

const showUserPosition = (position) => {
    const { latitude, longitude } = position.coords;

    // 移除之前的标记
    mapInstance.removeOverlay(marker);

    // 初始化地图，设置中心点坐标和地图级别为用户当前定位的经纬度
    const userPoint = new BMap.Point(longitude, latitude);
    mapInstance.centerAndZoom(userPoint, 15);

    // 创建新的标记并添加到地图上
    marker = new BMap.Marker(userPoint);
    mapInstance.addOverlay(marker);

    // 获取用户位置的地址信息
    const gc = new BMap.Geocoder();
    gc.getLocation(userPoint, (rs) => {
        const address = rs.address;
        showInfoWindow(userPoint, address);
    });
};

const handleLocationError = (error) => {
    console.log('获取用户位置失败:', error.message);
    // 处理获取失败的情况
};

const getUserLocation = () => {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(
            (position) => {
                console.log(position);
                const { latitude, longitude } = position.coords;
                console.log('用户当前经度:', longitude, '用户当前纬度:', latitude);

                // 使用第三方地理编码服务进行逆地址编码
                const url = `https://api.mapbox.com/geocoding/v5/mapbox.places/${longitude},${latitude}.json?access_token=YOUR_ACCESS_TOKEN`;
                fetch(url)
                    .then(response => response.json())
                    .then(data => {
                        const address = data.features[0].place_name;
                        console.log('用户当前地址:', address);
                        // 在这里处理用户的地址信息
                    })
                    .catch(error => {
                        console.log('逆地址编码失败:', error);
                        // 处理逆地址编码失败的情况
                    });

            },
            (error) => {
                console.log('获取用户位置失败:', error.message);
                // 处理获取失败的情况
            }
        );
    } else {
        console.log('浏览器不支持地理位置获取功能。');
        // 处理浏览器不支持地理位置获取的情况
    }
}






</script>

<style scoped></style>