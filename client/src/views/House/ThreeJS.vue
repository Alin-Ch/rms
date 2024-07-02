<template>
    <div id="container" ref="container"></div>
</template>

<script setup>
import { ref, reactive, onMounted, onBeforeUnmount } from 'vue';
import { useStore } from 'vuex';
import { useRoute, useRouter } from 'vue-router';
import request from '@/utils/request'
// threeJS
import * as THREE from 'three';
import TWEEN from '@tweenjs/tween.js'
import { OrbitControls } from "three/examples/jsm/controls/OrbitControls"
import GUI from 'lil-gui';
// 数据
// import bigImg from "@/assets/2.webp"; // 全景图片路径
// import bigImg from "@/assets/3.jpg"; // 全景图片路径
// 要想加载网络图片，就要解决跨域问题，去threejs源码搜索textureloader，找到loader.setCrossOrigin( this.crossOrigin ); 代码换成loader.setCrossOrigin( ‘Anonymous’ );
// https://blog.csdn.net/qq_24950043/article/details/125074912 有用

let bigImg = "https://glut-1.oss-cn-shenzhen.aliyuncs.com/rms/2%60L0~HN1N61CQ2JXPT%7BD]UP.jpg"
onMounted(() => {
    const image = JSON.parse(sessionStorage.getItem("image"))
    console.log(image);
    bigImg = image.url
})
let container = null  // 页面容器
let camera = null // 相机
let renderer = null // 渲染器
let scene = null // 场景
let material = null // 添加材质
let texture = null // 创建纹理贴图
let skyBox = null // 网格
let controls = null // 轨道控制
let clock = null // 轨道更新时间
// 鼠标属性
let bMouseDown = false
let x = -1
let y = -1
let isClickCamera = false // 是否点运动相机
let raycaster = null
let mouse = null
// 面板操作
let myObject = {
    isRotation: false, // 是否自动旋转
    isEnablePan: false, // 是否开启右键拖拽
    isZoomEnabled: true, // 是否开启缩放功能
}



// 函数方法
// 初始化轨道控制
const initControls = () => {
    controls = new OrbitControls(camera, renderer.domElement);
    controls.target = new THREE.Vector3(0, 0, 0);
    controls.minDistance = 18; // 相机最近
    controls.maxDistance = 90; // 相机最远 太远就会显示出球体
    controls.autoRotate = myObject.isRotation; // 图片自动旋转
    controls.enableDamping = true; // 使动画循环使用时阻尼或自转 意思是否有惯性
    controls.enablePan = myObject.isEnablePan; // 是否开启右键拖拽
    controls.autoRotateSpeed = 0.5; // 阻尼系数
}
const init = () => {
    // 页面容器
    container = document.getElementById('container');

    // 创建渲染器
    renderer = new THREE.WebGLRenderer();
    renderer.setPixelRatio(window.devicePixelRatio);

    // 设置画布的宽高
    renderer.setSize(window.innerWidth, window.innerHeight);

    // 判断容器中子元素的长度
    let childs = container.childNodes;
    if (container.childNodes.length > 0) {
        container.removeChild(childs[0]);
        container.appendChild(renderer.domElement);
    } else {
        container.appendChild(renderer.domElement);
    }

    // 创建场景
    scene = new THREE.Scene();

    // 创建相机
    camera = new THREE.PerspectiveCamera(80, window.innerWidth / window.innerHeight, 1, 10000);
    camera.position.set(10, 0, 0);
    camera.lookAt(new THREE.Vector3(0, 0, 0)); //让相机指向原点

    // 创建轨道控制器
    initControls();

    // 添加材质
    material = new THREE.MeshBasicMaterial();
    // 创建纹理贴图
    texture = new THREE.TextureLoader().load(bigImg);
    material.map = texture;

    const sphereGeometry = new THREE.SphereGeometry(100, 100, 100);

    skyBox = new THREE.Mesh(sphereGeometry, material);

    skyBox.geometry.scale(1, 1, -1);
    // 添加到场景中去
    scene.add(skyBox);

    // 鼠标事件监听
    renderer.domElement.addEventListener('pointerdown', onMouseDown, false);
    renderer.domElement.addEventListener('pointerup', onMouseUp, false);
    renderer.domElement.addEventListener('pointermove', onMouseMove, false);

    // 监听布局变化
    window.addEventListener('resize', onWindowResize, false);

}
// 更新相机动画
const tweenCamera = (position, target) => {
    new TWEEN.Tween(camera.position).to({
        x: position.x,
        y: position.y,
        z: position.z
    }, 600).easing(TWEEN.Easing.Sinusoidal.InOut).start();

    new TWEEN.Tween(controls.target).to({
        x: target.x,
        y: target.y,
        z: target.z
    }, 600).easing(TWEEN.Easing.Sinusoidal.InOut).start();
}
// 鼠标按下
const onMouseDown = (event) => {
    event.preventDefault(); // 取消默认事件
    console.log("---onMouseDown---");
    isClickCamera = true;
}
// 鼠标放开
const onMouseUp = (event) => {
    event.preventDefault(); // 取消默认事件
    console.log("---onMouseUp---");
    if (isClickCamera) {
        console.log("---移动相机---", event);
        // 红色代表X轴，绿色代表Y轴，蓝色代表Z轴
        mouse = new THREE.Vector3(); // 三维坐标对象
        // 屏幕坐标到标准化设备坐标(Normalized Device Coordinates, NDC)转换
        mouse.set((event.clientX / window.innerWidth) * 2 - 1, -(event.clientY / window.innerHeight) * 2 +
            1, 0.5);
        mouse.unproject(camera);

        raycaster = new THREE.Raycaster(camera.position, mouse.sub(camera.position)
            .normalize()); // 投手
        var intersects = raycaster.intersectObjects(scene.children);

        if (intersects.length > 0) {
            var selected = intersects[0]; // 取第一个物体
            console.log("x坐标:" + selected.point.x);
            console.log("y坐标:" + selected.point.y);
            console.log("z坐标:" + selected.point.z);
            camera.position.set(selected.point.x, selected.point.y, selected.point.z);
        }
    }
}
// 鼠标移动
const onMouseMove = (event) => {
    event.preventDefault(); // 取消默认事件
    console.log("---onMouseMove---");
    isClickCamera = false;
}
const onWindowResize = () => {
    // 窗口缩放的时候,保证场景也跟着一起缩放
    camera.aspect = window.innerWidth / window.innerHeight;
    camera.updateProjectionMatrix();
    renderer.setSize(window.innerWidth, window.innerHeight);
}
const animate = () => {
    requestAnimationFrame(animate);
    controls.update(); // 更新轨道控制
    TWEEN.update();
    renderer.render(scene, camera);
}
const initGui = () => {
    // 初始化
    const gui = new GUI();
    // 点击控制是否自动旋转
    gui.add(myObject, 'isRotation').onChange(value => {
        console.log(value);
        myObject.isRotation = value
        console.log(myObject.isRotation, '当前状态');
        // 需重新调用控制器才能生效
        initControls();
    });
}






onMounted(() => {
    init();
    animate();
    initGui()
})

</script>
<style scoped lang='less'></style>