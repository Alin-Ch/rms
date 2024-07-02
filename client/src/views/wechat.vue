<template>
  <div style="padding: 10px; margin-bottom: 50px">
    <el-row>
      <el-col :span="8">
        <el-card style="width: 100%; min-height: 300px; color: #333">
          <div style="padding-bottom: 10px; border-bottom: 1px solid #ccc">在线用户
            <span style="font-size: 12px">（点击聊天气泡开始聊天）</span>
          </div>
          <div class="chatList" :class="{ 'activeChat': user.username === chatUser }" v-for="user in users"
            :key="user.username" @click="selectUser(user.username)">
            <span>{{ user.username }}</span>
            <el-icon color="blue">
              <ChatLineRound />
            </el-icon>
            <span style="font-size: 12px;color: red; margin-left: 5px" v-if="user.username != chatUser">online</span>
            <span style="font-size: 12px;color: limegreen; margin-left: 5px"
              v-if="user.username == chatUser">chatting...</span>
          </div>
        </el-card>
      </el-col>
      <el-col :span="16">
        <div
          style="width: 800px; margin: 0 auto; background-color: white; border-radius: 5px; box-shadow: 0 0 10px #ccc">
          <div style="text-align: center; line-height: 50px;">
            Web聊天室（{{ chatUser }}）
          </div>
          <div style="height: 350px; overflow:auto; border-top: 1px solid #ccc" v-html="content"></div>
          <div style="height: 215px;">
            <textarea v-model="text"
              style="height: 160px; width: 100%; padding: 10px 0 0 0; border: none; border-top: 1px solid #ccc; border-bottom: 1px solid #ccc; outline: none"></textarea>
            <div style="text-align: right; padding-right: 10px">
              <el-button type="primary" size="mini" style="width: 200px;" @click="send">发送</el-button>
            </div>
          </div>
        </div>
      </el-col>
    </el-row>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { ElMessage, ElNotification } from 'element-plus';
import { ChatLineRound } from '@element-plus/icons-vue';

let socket = null;

const circleUrl = 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png';

const user = JSON.parse(localStorage.getItem("user")) || {};
const users = ref([]);
const chatUser = ref('');
const text = ref('');
const messages = ref([]);
const content = ref('');

onMounted(() => {
  init();
  setInterval(sendHeartbeat, 5000 * 60); // 每5秒发送一次心跳
});

// 发送心跳数据
const sendHeartbeat = () => {
  if (socket && socket.readyState === WebSocket.OPEN) {
    socket.send("heartbeat");
  }
};

// 发送消息
const send = () => {
  if (!chatUser.value) {
    ElMessage.warning("请选择聊天对象");
    return;
  }
  if (!text.value) {
    ElMessage.warning("请输入内容");
  } else {
    if (typeof WebSocket === "undefined") {
      console.log("您的浏览器不支持WebSocket");
    } else {
      console.log("您的浏览器支持WebSocket");
      const message = { from: user.username, to: chatUser.value, text: text.value };
      socket.send(JSON.stringify(message));
      messages.value.push({ user: user.username, text: text.value });
      createContent(null, user.username, text.value);
      text.value = '';
    }
  }
};

// 创建连接
const createContent = (remoteUser, nowUser, text) => {
  let html;
  if (nowUser) {
    // 当前用户
    html = `<div class="el-row" style="padding: 5px 0">
          <div class="el-col el-col-22" style="text-align: right; padding-right: 10px">
            <div class="tip-chat left-chat">${text}</div>
          </div>
          <div class="el-col el-col-2">
            <span class="el-avatar el-avatar--circle" style="height: 40px; width: 40px; line-height: 40px;">
              <img src="${nowUser === user.username ? user.avatar : circleUrl}" style="object-fit: cover;">
            </span>
          </div>
        </div>`;
  } else if (remoteUser) {
    // 其他用户
    html = `<div class="el-row" style="padding: 5px 0">
          <div class="el-col el-col-2" style="text-align: right">
            <span class="el-avatar el-avatar--circle" style="height: 40px; width: 40px; line-height: 40px;">
              <img src="${remoteUser === user.username ? user.avatar : circleUrl}" style="object-fit: cover;">
            </span>
          </div>
          <div class="el-col el-col-22" style="text-align: left; padding-left: 10px">
            <div class="tip-chat right-chat">${text}</div>
          </div>
        </div>`;
  }
  content.value += html;
};

const selectUser = (username) => {
  // console.log(username);
  ElNotification({
    title: '聊天切换',
    message: `正在与${username}聊天`,
    duration: 1500,
  })
  chatUser.value = username;
};

const init = () => {
  const userStr = localStorage.getItem("user") || '{"username": "guest"}';
  const user = JSON.parse(userStr);
  const username = user.username;

  if (typeof WebSocket === "undefined") {
    console.log("您的浏览器不支持WebSocket");
  } else {
    console.log("您的浏览器支持WebSocket");
    const socketUrl = "ws://localhost:8000/im/" + username;
    if (socket !== null) {
      socket.close();
      socket = null;
    }
    socket = new WebSocket(socketUrl);
    socket.onopen = () => {
      console.log("WebSocket已打开");
    };
    socket.onmessage = (msg) => {
      console.log("收到数据：" + msg.data);
      const data = msg.data;
      if (data === "heartbeat") {
        console.log("心跳消息");
      } else {
        const jsonData = JSON.parse(data);
        if (jsonData.users) {
          users.value = jsonData.users.filter(user => user.username !== username);
        } else {
          if (jsonData.from === chatUser.value) {
            messages.value.push(jsonData);
            createContent(jsonData.from, null, jsonData.text);
          }
        }
      }
    };
    socket.onclose = () => {
      console.log("WebSocket已关闭");
    };
    socket.onerror = () => {
      console.log("WebSocket发生了错误");
    };
  }
};
</script>

<style>
/* 这里不用scoped，用了聊天样式就不生效了 */
.tip-chat {
  color: white;
  text-align: center;
  border-radius: 10px;
  font-family: sans-serif;
  padding: 10px;
  display: inline-block !important;
  display: inline;
}

.chatList {
  margin: 10px 0;
  padding: 10px;
  box-shadow: rgba(100, 100, 111, 0.2) 0px 0px 5px 2px;
  cursor: pointer;
}

.activeChat {
  background-color: rgb(242, 242, 242);
}

.right-chat {
  background-color: deepskyblue;
}

.left-chat {
  background-color: forestgreen;
}
</style>
