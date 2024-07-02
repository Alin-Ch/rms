<template>
    <div class="chatContainer">
        <el-container class="center">
            <el-aside width="300px">
                <el-scrollbar v-if="group && group.length > 0" height="55vh">
                    <div class="chatItem" :class="{ 'activeChat': chatItem.id === item.id }"
                        @click="getChatDetailById(item)" v-for="item in group" :key="item.id">
                        <el-image style="width: 60px; height: 60px;padding: 0 0;border-radius:50%;margin-left:20px;"
                            :src="item.avatar" fit="fill" />
                        <div style="text-align: start;">
                            <p class="scrollbar-demo-item">{{ item.username }}</p>
                            <p
                                style="width: 110px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;font-size: 12px;color: #7f7f7f;">
                                {{ item.latest_message_content }}</p>
                        </div>
                        <span v-if="item.latest_create_time" style="position: relative;color: #7f7f7f">
                            {{ item.latest_create_time ? formatTime(item.latest_create_time) : null }}
                        </span>
                        <el-badge v-if="item.unreadCount > 0" :value="item.unreadCount" :max="10"></el-badge>
                    </div>
                </el-scrollbar>
                <div v-else style="text-align: center;color: #7f7f7f;">
                    <span>暂无数据</span>
                </div>
            </el-aside>
            <el-main class="main">
                <div class="messageShow">
                    <!-- 消息显示区域 -->
                    <div v-if="recordContent.length > 0" class="chat-content" ref="chatContent">
                        <!-- recordContent 聊天记录数组-->
                        <div v-for="( itemc, indexc ) in recordContent " :key="indexc">
                            <!-- 对方 -->
                            <div class="word" v-if="!itemc.mineMsg">
                                <img :src="itemc.headUrl">
                                <div class="info">
                                    <p class="time">{{ itemc.nickName }} {{ chatTime(itemc.timestamp) }}</p>
                                    <div class="info-content">{{ itemc.contactText }}</div>
                                </div>
                            </div>
                            <!-- 我的 -->
                            <div class="word-my" v-else>
                                <div class="info">
                                    <p class="time">{{ itemc.nickName }} {{ chatTime(itemc.timestamp) }}</p>
                                    <div class="info-content">{{ itemc.contactText }}</div>
                                </div>
                                <img :src="itemc.headUrl">
                            </div>
                        </div>
                    </div>
                    <div v-else>
                        <el-empty description="请选择联系人" />
                    </div>
                </div>
                <div class="messageInput">
                    <el-button type="primary" @click="sendMessage"
                        style="align-self: flex-end;width: 150px;">发送</el-button>
                    <el-input v-model="editInfo.content" type="textarea" :autosize="{ minRows: 1, maxRows: 4 }"
                        style="width: 100%;max-height: 100%;" />
                </div>
            </el-main>
        </el-container>
    </div>
</template>

<script setup>

import { ref, reactive, toRefs, onBeforeMount, onMounted, watchEffect, computed, watch } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import { ElNotification } from 'element-plus';
import request from '@/utils/request';
import { socketURL } from '@/utils/request';

const route = useRoute();
const router = useRouter();

const editInfo = ref({})
const group = ref([])
const onlineUsers = ref([])

onMounted(() => {
    getChatGroup()
    init();
    setInterval(sendHeartbeat, 5000 * 60); // 每5秒发送一次心跳
})
onBeforeMount(() => {
    // 页面关闭时关闭WebSocket连接
    if (socket !== null) {
        socket.close();
        socket = null;
    }
})
// WebSocket相关
let socket = null;
const init = () => {
    const username = localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")).username : "guest"

    if (typeof WebSocket === "undefined") {
        console.log("您的浏览器不支持WebSocket");
    } else {
        // console.log("您的浏览器支持WebSocket");
        const socketUrl = socketURL + "/im/" + username;
        if (socket !== null) {
            socket.close();
            socket = null;
        }
        socket = new WebSocket(socketUrl);
        socket.onopen = () => {
            console.log("WebSocket已打开");
        };
        socket.onmessage = (msg) => {
            // console.log("收到数据：" + msg.data);
            const data = msg.data;
            if (data === "heartbeat") {
                // console.log("心跳消息");
            } else {
                const jsonData = JSON.parse(data);
                if (!jsonData.users) {
                    // 判断路由是否在本页面
                    // 获取当前路由路径
                    const currentRoute = route.path;
                    // 判断当前路由是否符合条件
                    if (currentRoute === '/message/chat') {
                        // 如果符合条件，则执行相应的操作
                        console.log('路由在当前页面中');
                    } else {
                        console.log('路由不在当前页面中');
                        ElNotification({
                            title: '新消息通知',
                            message: `${data.from}给您发送了一条消息`,
                            type: 'info',
                        })
                    }
                    let chat = {}
                    if (chatItem.value.username == jsonData.from) {
                        chat.id = chatItem.value.id
                        chat.username = chatItem.value.username
                        chat.headUrl = chatItem.value.avatar
                        chat.nickName = chatItem.value.username
                        chat.contactText = jsonData.text
                        chat.timestamp = new Date()
                        chat.mineMsg = false
                    }
                    recordContent.value.unshift(chat)
                    setTimeout(() => {
                        // 获取最新消息  其实就是获取旁边那个新消息
                        getChatGroup()
                    }, 500)
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
const sendHeartbeat = () => {
    if (socket && socket.readyState === WebSocket.OPEN) {
        socket.send("heartbeat");
    }
};

// 获取左侧聊天群组
const getChatGroup = () => {
    // 获取聊天群组
    const userId = JSON.parse(localStorage.getItem("user")).id
    request.get("/sys/message/group/" + userId).then(res => {
        // console.log(res.data)
        if (res.code == 200) {
            // 遍历 res.data
            let users = []
            res.data.forEach(item => {
                let user;
                if (item.receiver.id === userId) {
                    user = item.sender;
                }
                else if (item.sender.id === userId) {
                    user = item.receiver;
                }
                user.unreadCount = item.unreadCount
                user.latest_create_time = item.latest_create_time
                user.latest_message_content = item.latest_message_content
                // 将 user 赋值给需要的变量或进行其他操作
                // 示例：将 user 存入一个数组中
                users.push(user);
            })
            // 如果路由有query参数，说明是用户携带参数进入的 如果请求出来的列表没有，就要新建一个
            if (route.query.userid) {
                // 检查 users 数组中是否已经存在指定的用户信息
                const existingUser = users.some(user => user.id === JSON.parse(sessionStorage.getItem("chat_user")).id);
                // 如果不存在，则新增用户信息
                if (!existingUser) {
                    users.unshift(JSON.parse(sessionStorage.getItem("chat_user")));
                    chatItem.value = JSON.parse(sessionStorage.getItem("chat_user"));
                    opposite.value = JSON.parse(sessionStorage.getItem("chat_user"));
                    getChatDetailById(chatItem.value)
                }
                chatItem.value = JSON.parse(sessionStorage.getItem("chat_user"));
                getChatDetailById(chatItem.value)
            }
            group.value = users
        }
    })
}
// 获取聊天记录
const opposite = ref({})  // 对方
const mine = ref(JSON.parse(localStorage.getItem("user")))  // 自己
const chatItem = ref({})  // 聊天对象  就是点击了这个，就是当前聊天对象
// 根据id获取跟这个人的聊天详情
const getChatDetailById = (item) => {
    if (item) {
        chatItem.value = item
    }
    editInfo.value.content = ""
    const chatGroup = {
        chatId1: mine.value.id,
        chatId2: item ? item.id : opposite.value.id
    }
    // console.log(item);
    opposite.value = item ? item : opposite.value
    request.post("/sys/message/detail", chatGroup).then(res => {
        if (res.code == 200) {
            // console.log(res)
            res.data.forEach(item => {
                if (mine.value.id == item.receiverId && opposite.value.id == item.senderId && item.status == 0) {
                    readMessage(item)
                }
            })
            const formattedData = res.data.map(item => {
                // console.log("item--", item);
                return {
                    mineMsg: item.senderId == mine.value.id,
                    headUrl: item.senderId == mine.value.id ? mine.value.avatar : opposite.value.avatar,
                    nickName: item.senderId == mine.value.id ? mine.value.username : opposite.value.username,
                    timestamp: new Date(item.createTime),
                    contactText: item.content
                }
            })
            recordContent.value = formattedData
        }
    })
    // 将未读的消息改为已读
}
const readMessage = (item) => {
    request.post("sys/message/read/" + item.id).then(res => {
        if (res.code == 200) {
            getChatGroup()
        }
    })
}
const sendMessage = () => {
    if (editInfo.value.content == "") {
        ElMessage.warning("请输入内容")
        return
    }
    if (!mine.value.id || !opposite.value.id) {
        ElMessage.warning("请选择聊天对象")
        return
    }

    if (typeof WebSocket === "undefined") {
        console.log("您的浏览器不支持WebSocket");
    } else {
        console.log("您的浏览器支持WebSocket");
        const message = { from: mine.value.username, to: opposite.value.username, text: editInfo.value.content };
        socket.send(JSON.stringify(message));
    }
    // 发起请求，发送消息
    editInfo.value.senderId = mine.value.id
    editInfo.value.receiverId = opposite.value.id
    // console.log(editInfo.value);
    request.post("/sys/message/send", editInfo.value).then(res => {
        if (res.code == 200) {
            getChatDetailById()
        } else {
            ElMessage.warning(res.msg)
        }
    })

}

// 聊天记录
const chatContent = ref(null)
const recordContent = ref([
    // {
    //     mineMsg: false,
    //     headUrl: 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png',
    //     nickName: '张三',
    //     timestamp: new Date('2024-05-05T08:10:00Z'),
    //     contactText: '我也不错。'
    // }
])


const chatTime = (date) => {
    return date.toLocaleString('zh-CN', { year: 'numeric', month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit' });
}

function formatTime(timeString) {
    const now = new Date();
    const time = new Date(timeString);
    const diff = now - time;

    const oneDay = 24 * 60 * 60 * 1000;
    const today = new Date(now.getFullYear(), now.getMonth(), now.getDate());
    const yesterday = new Date(today);
    yesterday.setDate(yesterday.getDate() - 1);

    if (diff < oneDay && time.getDate() === now.getDate()) {
        // 今天内，显示时分
        return time.toLocaleTimeString('en-US', { hour: 'numeric', minute: 'numeric', hour12: false });
    } else if (time >= yesterday) {
        // 昨天，显示昨天
        return '昨天';
    } else if (diff < 7 * oneDay) {
        // 七天内，显示多少天前
        const daysAgo = Math.floor(diff / oneDay);
        return `${daysAgo}天前`;
    } else {
        // 七天之前，显示月日
        const month = time.getMonth() + 1;
        const day = time.getDate();
        return `${month}月${day}日`;
    }
}



</script>

<style scoped lang='less'>
@import url("@/assets/css/chat.less");

.chatContainer {
    width: 100%;
    height: 100%;

    .center {
        height: 83vh;
        margin: 0 auto;
        padding: 20px 30px;
        box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px;
        border-radius: 20px;
        // background-color: pink;

        :deep(.el-scrollbar__wrap) {
            overflow-x: hidden;
        }

        .chatItem {
            display: flex;
            justify-content: start;
            align-items: center;
            width: 100%;
            text-align: center;
            padding: 20px 0;
            border-bottom: #d7d7d7 1px solid;
            cursor: pointer;
            border-radius: 5px;


            &:hover {
                background-color: rgba(252, 244, 235);
            }

            p {
                margin-left: 20px;
            }
        }

        .activeChat {
            background-color: rgb(230, 233, 237);
        }

        .main {
            padding: 0;
            display: flex;
            flex-direction: column;
            border-left: #f5f5f5 1px solid;

            .messageShow {
                flex: 7;
                // background-color: #e74141;
                overflow-y: auto;
                padding: 10px;
            }

            .messageInput {
                // flex: 3;
                // background-color: skyblue;
                margin-top: 10px;
                display: flex;
                flex-direction: column-reverse;
            }
        }
    }
}
</style>