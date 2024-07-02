<template>
    <div class="play-audio">
        <el-button @click="startCall" ref="start">开始对讲</el-button>
        <el-button @click="stopCall" ref="stop">结束对讲</el-button>
    </div>
</template>

<script setup>
import { ref } from 'vue';
// 语音聊天的变量
const audioSocket = ref(null);
const isInChannel = ref(false)
let mediaStack;
let audioCtx;
let scriptNode;
let source;
let play;
// 语音socket
const connectAudioWebSocket = () => {
    let url = "ws://localhost:8000/audio/1/123"; //roomId:1 ,userId123
    audioSocket.value = new WebSocket(url); // 替换为实际的 WebSocket 地址

    audioSocket.value.onopen = () => {
        console.log("audioSocket connected");
    };

    audioSocket.value.onmessage = (event) => {
        // 将接收的数据转换成与传输过来的数据相同的Float32Array
        const jsonAudio = JSON.parse(event.data);

        // let buffer = new Float32Array(event.data);
        let buffer = new Float32Array(4096);
        for (let i = 0; i < 4096; i++) {
            // buffer.push(parseFloat(jsonAudio[i]));
            buffer[i] = parseFloat(jsonAudio[i]);
        }

        // 创建一个空白的AudioBuffer对象，这里的4096跟发送方保持一致，48000是采样率
        const myArrayBuffer = audioCtx.createBuffer(1, 4096, 16000);
        // 也是由于只创建了一个音轨，可以直接取到0
        const nowBuffering = myArrayBuffer.getChannelData(0);
        // 通过循环，将接收过来的数据赋值给简单音频对象
        for (let i = 0; i < 4096; i++) {
            nowBuffering[i] = buffer[i];
        }
        // 使用AudioBufferSourceNode播放音频
        const source = audioCtx.createBufferSource();
        source.buffer = myArrayBuffer;
        const gainNode = audioCtx.createGain();
        source.connect(gainNode);
        gainNode.connect(audioCtx.destination);
        var muteValue = 1;
        if (!play) {
            // 是否静音
            muteValue = 0;
        }
        gainNode.gain.setValueAtTime(muteValue, audioCtx.currentTime);
        source.start();
    };

    audioSocket.value.onclose = () => {
        console.log("audioSocket closed");
    };

    audioSocket.value.onerror = (error) => {
        console.error("audioSocket error:", error);
    };
};
// 开始对讲
function startCall() {
    isInChannel.value = true;
    play = true;
    audioCtx = new AudioContext();
    connectAudioWebSocket();

    // 该变量存储当前MediaStreamAudioSourceNode的引用
    // 可以通过它关闭麦克风停止音频传输

    // 创建一个ScriptProcessorNode 用于接收当前麦克风的音频
    scriptNode = audioCtx.createScriptProcessor(4096, 1, 1);
    navigator.mediaDevices
        .getUserMedia({ audio: true, video: false })
        .then((stream) => {
            mediaStack = stream;
            source = audioCtx.createMediaStreamSource(stream);

            source.connect(scriptNode);
            scriptNode.connect(audioCtx.destination);
        })
        .catch(function (err) {
            /* 处理error */
            isInChannel.value = false;
            console.log("err", err);
        });
    // 当麦克风有声音输入时，会调用此事件
    // 实际上麦克风始终处于打开状态时，即使不说话，此事件也在一直调用
    scriptNode.onaudioprocess = (audioProcessingEvent) => {
        const inputBuffer = audioProcessingEvent.inputBuffer;
        // console.log("inputBuffer",inputBuffer);
        // 由于只创建了一个音轨，这里只取第一个频道的数据
        const inputData = inputBuffer.getChannelData(0);
        // 通过socket传输数据，实际上传输的是Float32Array
        if (audioSocket.value.readyState === 1) {
            // console.log("发送的数据",inputData);
            // audioSocket.value.send(inputData);
            let jsonData = JSON.stringify(inputData);
            audioSocket.value.send(jsonData);

            // stopCall();
        }
    };
}
// 关闭麦克风
function stopCall() {
    isInChannel.value = false;
    play = false;
    mediaStack.getTracks()[0].stop();
    scriptNode.disconnect();
    if (audioSocket.value) {
        audioSocket.value.close();
        audioSocket.value = null;
    }
}

</script>
<style scoped lang='less'></style>