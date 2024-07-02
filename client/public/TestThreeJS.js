var isTouch = false;
var currentScene = "first";
var isVr = false;
function load() {
    console.log(123);
}
function clickTestBtn(e) {
    if (!isTouch) {
        console.log(e);
        document.querySelector(".mask").style.display = "block";
    }
}
function toXiaochengxu() {
    wx.miniProgram.navigateTo({
        url: "/pages/index/index",
    });
}
const viewer = pannellum.viewer("panorama", {
    default: {
        firstScene: "first",
        cubeMap: [
            //立方体全景图六张图
            "https://img.alicdn.com/imgextra/i4/O1CN014TNffn1nlaTfA98Fg_!!6000000005130-0-tps-1500-1500.jpg",
            "https://img.alicdn.com/imgextra/i3/O1CN01LsO1Bk20QbKpFTUQr_!!6000000006844-0-tps-1500-1500.jpg",
            "https://img.alicdn.com/imgextra/i1/O1CN01sS5m781ya6JgLSaVk_!!6000000006594-0-tps-1500-1500.jpg",
            "https://img.alicdn.com/imgextra/i3/O1CN01uTWCLc1XOCOuA92H0_!!6000000002913-0-tps-1500-1500.jpg",
            "https://img.alicdn.com/imgextra/i4/O1CN016lU3YJ1JdrJuFTcWt_!!6000000001052-0-tps-1500-1500.jpg",
            "https://img.alicdn.com/imgextra/i2/O1CN01nYe2Mn1ohkmBVyKpp_!!6000000005257-0-tps-1500-1500.jpg",
        ],
        orientationOnByDefault: false, // 是否开启vr效果
        autoLoad: true, // 自动加载
        autoRotate: -2, // 自动旋转
        autoRotateInactivityDelay: 1000, // 用户操作页面后，自动旋转延迟
        friction: 0.15, // 控制摩擦器 0.1 到 1 值越大停的越快 默认值0.15
        showZoomCtrl: false, // 是否显示缩放控件
        showFullscreenCtrl: true, // 是否显示全屏控件
        touchPanSpeedCoeffFactor: 1, // 触摸时平移速度 默认1
        yaw: 0, // 垂直方向左右旋转角度 正值向右 负值向左
        pitch: -60, // 水平方向左右旋转角度 正值向上 负值向下 仰视太大 导致图片拉伸
        minPitch: -60, // 最小pitch 默认-180
        maxPitch: 60, // 最大pitch 默认180
        roll: 0, // z轴 横着的
        hfov: 60, // 摄像机视角
        minHfov: 10, // 摄像机最小视角
        maxHfov: 60, // 摄像机最大视角
        escapeHTML: true, // HTML 将从配置字符串中转义，以帮助缓解可能的 DOM XSS 攻击。
        crossOrigin: "anonymous", // 使用的 CORS 请求类型，可以设置为 anonymous或use-credentials。默认为anonymous.
        sceneFadeDuration: 1000, // 切换场景时动画持续时间
        // compass: true, // 指南针
        // northOffset: 90, // 指南针角度
        // horizonRoll: 10, // 指定图像水平的俯仰/滚动
        // hotSpotDebug: true, // 打印移动时的yaw pitch roll
        preview:
            "https://img.alicdn.com/imgextra/i4/O1CN014TNffn1nlaTfA98Fg_!!6000000005130-0-tps-1500-1500.jpg",
    },
    scenes: {
        first: {
            type: "cubemap", // 全景图类型
            hotSpots: [
                {
                    yaw: -30,
                    pitch: -16,
                    type: "scene",
                    sceneId: "second",
                    // id: "one",
                    // text: "另一个画面",
                    cssClass: "point",
                    // image: "./images/hot.png",
                    scale: true,
                },
                {
                    yaw: -6,
                    pitch: -26,
                    cssClass: "test",
                    clickHandlerFunc: clickTestBtn,
                    scale: true,
                    // image: "./images/hot.png",
                },
                {
                    yaw: 10,
                    pitch: 15,
                    roll: -10,
                    cssClass: "xiaochengxu",
                    clickHandlerFunc: toXiaochengxu,
                    scale: true,
                    // image: "./images/hot.png",
                },
            ],
        },
        second: {
            type: "cubemap",
            cubeMap: [
                "https://krpano-pro.oss-accelerate.aliyuncs.com/static/resource/publish/krpano/1481085216446902274/quanjing/2205/40419783638860705/pano_f.jpg?x-oss-process=style/nocut_compress",
                "https://krpano-pro.oss-accelerate.aliyuncs.com/static/resource/publish/krpano/1481085216446902274/quanjing/2205/40419783638860705/pano_r.jpg?x-oss-process=style/nocut_compress",
                "https://krpano-pro.oss-accelerate.aliyuncs.com/static/resource/publish/krpano/1481085216446902274/quanjing/2205/40419783638860705/pano_b.jpg?x-oss-process=style/nocut_compress",
                "https://krpano-pro.oss-accelerate.aliyuncs.com/static/resource/publish/krpano/1481085216446902274/quanjing/2205/40419783638860705/pano_l.jpg?x-oss-process=style/nocut_compress",
                "https://krpano-pro.oss-accelerate.aliyuncs.com/static/resource/publish/krpano/1481085216446902274/quanjing/2205/40419783638860705/pano_u.jpg?x-oss-process=style/nocut_compress",
                "https://krpano-pro.oss-accelerate.aliyuncs.com/static/resource/publish/krpano/1481085216446902274/quanjing/2205/40419783638860705/pano_d.jpg?x-oss-process=style/nocut_compress",
            ],
            hotSpots: [
                {
                    pitch: 0,
                    yaw: 20,
                    type: "info",
                    id: "one",
                    text: "123",
                    // image: "./images/hot.png",
                },
                {
                    pitch: 20,
                    yaw: 20,
                    type: "scene",
                    sceneId: "first",
                    id: "two",
                    text: "第一个画面",
                    // image: "./images/hot.png",
                },
            ],
        },
    },
});
// document.addEventListener("DOMContentLoaded", (e) => {
//   setTimeout(() => {
//     test();
//   }, 0);
// });
// viewer.loadScene();
// alert(viewer.isOrientationSupported());
function test() {
    var test = document.querySelector(".test");
    console.log(test);
    test.innerHTML =
        "打开弹出框<div class='test-child'>点击这里打开弹出框</div>";
    // test.onclick = (e) => {
    //   document.querySelector(".mask").style.display = "block";
    // };
    document.querySelector(".maskBtn").addEventListener("click", () => {
        document.querySelector(".mask").style.display = "none";
    });
}
viewer.on("load", (e) => {
    // console.log(e);
    // if (e === "first") {
    setTimeout(() => {
        test();
    }, 0);
    // }
});
viewer.on("touchstart", () => {
    isTouch = true;
});
viewer.on("touchend", () => {
    isTouch = false;
    if (isVr) {
        viewer.startOrientation();
    }
});
viewer.on("scenechange", (e) => {
    if (e === "first") {
        document.querySelector(".map-one-fov").style.opacity = 1;
        document.querySelector(".map-one-fov").style.transform =
            "rotate(0deg)";
        document.querySelector(".map-two-fov").style.opacity = 0;
        document.querySelector(".map-two-fov").style.transform =
            "rotate(0deg)";
    } else {
        document.querySelector(".map-one-fov").style.opacity = 0;
        document.querySelector(".map-one-fov").style.transform =
            "rotate(0deg)";
        document.querySelector(".map-two-fov").style.opacity = 1;
        document.querySelector(".map-two-fov").style.transform =
            "rotate(0deg)";
    }
    currentScene = e;
});
document.addEventListener("mousemove", () => {
    // console.log(viewer.getYaw());
    let deg = viewer.getYaw();
    document.querySelector(
        ".map-one-fov"
    ).style.transform = `rotate(${deg}deg)`;
    document.querySelector(
        ".map-two-fov"
    ).style.transform = `rotate(${deg}deg)`;
});
document.addEventListener("touchmove", () => {
    // console.log(viewer.getYaw());
    let deg = viewer.getYaw();
    document.querySelector(
        ".map-one-fov"
    ).style.transform = `rotate(${deg}deg)`;
    document.querySelector(
        ".map-two-fov"
    ).style.transform = `rotate(${deg}deg)`;
});
document.querySelector(".map").addEventListener("click", () => {
    document.querySelector(".map").style.width = "70%";
    document.querySelector(".map").style.height = "70vh";
    document.querySelector(".map-close").style.display = "block";
});
document.querySelector(".map-one").addEventListener("click", (e) => {
    e.stopPropagation();
    if (currentScene !== "first") {
        viewer.loadScene("first");
    }
    handleMapStyle();
});
document.querySelector(".map-two").addEventListener("click", (e) => {
    e.stopPropagation();
    if (currentScene !== "second") {
        viewer.loadScene("second");
    }
    handleMapStyle();
});
document.querySelector(".map-close").addEventListener("click", (e) => {
    e.stopPropagation();
    handleMapStyle();
});
document.querySelector(".mask-vr").addEventListener("click", (e) => {
    e.stopPropagation();
    // 是否支持

    if (viewer.isOrientationSupported()) {
        if (document.querySelector(".mask-vr").innerText === "开启vr") {
            viewer.startOrientation();
            document.querySelector(".mask-vr").innerText = "关闭vr";
            isVr = true;
            // document.querySelector(".mask-bk").style.display = "block";
        } else {
            viewer.stopOrientation();
            document.querySelector(".mask-vr").innerText = "开启vr";
            document.querySelector(".mask-bk").style.display = "none";
            isVr = false;
        }
    } else {
        alert("当前设备不支持vr");
    }
});
function handleMapStyle() {
    document.querySelector(".map").style.width = "100px";
    document.querySelector(".map").style.height = "100px";
    document.querySelector(".map-close").style.display = "none";
}
viewer.on("animatefinished", (e) => {
    console.log("animation", e);
});
window.addEventListener("devicemotion", function (event) {
    // devicemotion 和服务有关系 需要https服务才支持
    let deg = viewer.getYaw();
    document.querySelector(
        ".map-one-fov"
    ).style.transform = `rotate(${deg}deg)`;
    document.querySelector(
        ".map-two-fov"
    ).style.transform = `rotate(${deg}deg)`;
});