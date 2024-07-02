<template>
	<div class="header">
		<!-- 折叠按钮 -->
		<div class="collapse-btn" @click="collapseChange">
			<el-icon v-if="sidebar.collapse">
				<Expand />
			</el-icon>
			<el-icon v-else>
				<Fold />
			</el-icon>
		</div>
		<div class="logo"><text @click="router.push('/dashboard')">后台管理系统</text></div>
		<div class="header-right">
			<div class="header-user-con">
				<!-- 消息 -->
				<el-badge :value="unreadCount" :max="99" type="primary" class="badgeMessage"
					@click="router.push('/message/chat')">
					<el-icon>
						<Bell />
					</el-icon>
				</el-badge>
				<!-- 用户头像 -->
				<el-avatar class="user-avator" :size="50" :src="imgurl" />
				<!-- 用户名下拉菜单 -->
				<el-dropdown class="user-name" trigger="click" @command="handleCommand">
					<span class="el-dropdown-link">
						{{ username }}
						<el-icon class="el-icon--right">
							<arrow-down />
						</el-icon>
					</span>
					<template #dropdown>
						<el-dropdown-menu>
							<a href="https://github.com/Alin-Ch?tab=repositories" target="_blank">
								<el-dropdown-item>项目仓库</el-dropdown-item>
							</a>
							<el-dropdown-item command="personal">个人中心</el-dropdown-item>
							<el-dropdown-item divided command="loginout">退出登录</el-dropdown-item>
						</el-dropdown-menu>
					</template>
				</el-dropdown>
			</div>
		</div>
	</div>
</template>
<script setup>
import { onBeforeMount, onMounted, ref } from 'vue';
import { useSidebarStore } from '../store/Sidebar';
import { useRouter, useRoute } from 'vue-router';
import { ElMessage } from 'element-plus';
import store from '@/store/index.js'
import request from '@/utils/request';
import { socketURL } from '@/utils/request';
// 标签
import { useTagsStore } from '../store/Tags';
// 关闭全部标签
const closeAll = () => {
	tags.clearTags();
	router.push('/');
};
const tags = useTagsStore();

const username = ref("");
const imgurl = ref("");
const unreadCount = ref(0);

const sidebar = useSidebarStore();
// 侧边栏折叠
const collapseChange = () => {
	sidebar.handleCollapse();
};


// 测试
// 分页查询、模糊查询所需要的参数
const params = ref({
	current: 1,
	size: 10,
})
const getData = () => {
	request.get('/sys/user/list', { params: params.value }).then((res) => {
		console.log(res);
	}).catch((err) => {
		console.log(err);
		// ElMessage.warning(err.msg);
	})
}


onBeforeMount(() => {
	getUserInfo()
})
onMounted(() => {
	// init()
	// setInterval(sendHeartbeat, 5000 * 60); // 每5秒发送一次心跳
	getUnreadMessageCount()
	if (document.body.clientWidth < 1500) {
		collapseChange();
	}
	// console.log(store.state.menus.menuList);
	// console.log(store.getters["menus/hasThisRoute"]("/sys/personal"));
})
// 获取未读信息数量
const getUnreadMessageCount = async (user_id) => {
	if (user_id) {
		await request.get("/sys/message/unread/count/" + user_id).then(res => {
			unreadCount.value = res.data;
		})
	}
}
// 获取用户信息
const getUserInfo = async () => {
	await request.get("/sys/userInfo").then(res => {
		// console.log(res.data);
		if (res.code == "200") {
			sessionStorage.setItem("user_id", res.data.id);
			username.value = res.data.username;
			imgurl.value = res.data.avatar;
			sessionStorage.setItem("user", JSON.stringify(res.data))
			// 获取未读消息
			getUnreadMessageCount(res.data.id)
			// 写到personal页面的时候，发现使用了localStorage，所以这里用localStorage吧
			localStorage.setItem("user", JSON.stringify(res.data))
			if (res.data.role == "admin") {
				sessionStorage.setItem("user_role", "admin");
			} else {
				sessionStorage.setItem("user_role", "user");
			}
		}

	})
}
// 退出登录
const loginOut = () => {
	request.post("/logout").then(res => {
		console.log(res);
		if (res.code == "200") {
			// 清除保存的信息
			// sessionStorage.clear();
			store.commit("menus/clearMenuList")
			store.commit("menus/changeRouteState", false)
			localStorage.removeItem("token")

			closeAll()

			ElMessage.success("退出成功");
			router.push("/login");
		}
	})
}

// 用户名下拉菜单选择事件
const router = useRouter();
const route = useRoute();
const handleCommand = (command) => {
	if (command == 'loginout') {
		loginOut()
	} else if (command == 'personal') {
		router.push('/sys/personal');
	}
}

// WebSocket相关
let socket = null;
const init = () => {
	const username = localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")).username : "guest"
	if (typeof WebSocket === "undefined") {
		// console.log("您的浏览器不支持WebSocket");
	} else {
		// console.log("您的浏览器支持WebSocket");
		const socketUrl = socketURL + "/im/" + username;
		if (socket !== null) {
			socket.close();
			socket = null;
		}
		socket = new WebSocket(socketUrl);
		socket.onopen = () => {
			// console.log("WebSocket已打开");
		};
		socket.onmessage = (msg) => {
			if (msg.data === "heartbeat") {
				// console.log("心跳消息");
			} else {
				const data = JSON.parse(msg.data);
				if (data.from) {
					ElNotification({
						title: '新消息通知',
						message: `${data.from}给您发送了一条消息`,
						type: 'info',
					})
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
}
const sendHeartbeat = () => {
	if (socket && socket.readyState === WebSocket.OPEN) {
		socket.send("heartbeat");
	}
}
</script>
<style scoped>
.header {
	position: relative;
	box-sizing: border-box;
	width: 100%;
	height: 70px;
	font-size: 22px;
	color: #fff;
}

.collapse-btn {
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100%;
	float: left;
	padding: 0 21px;
	cursor: pointer;
}

.header .logo {
	float: left;
	width: 200px;
	line-height: 70px;
}

.header .logo text {
	cursor: pointer;
	user-select: none;
}

.header-right {
	float: right;
	padding-right: 50px;
}

.header-user-con {
	display: flex;
	height: 70px;
	align-items: center;
}

.btn-fullscreen {
	transform: rotate(45deg);
	margin-right: 5px;
	font-size: 24px;
}


.user-name {
	margin-left: 10px;
}

.user-avator {
	margin-left: 20px;
}

.el-dropdown-link {
	color: #fff;
	cursor: pointer;
	display: flex;
	align-items: center;
}

.el-dropdown-menu__item {
	text-align: center;
}

:deep(.el-tooltip__trigger:focus-visible) {
	outline: unset;
}

.badgeMessage {
	margin: 10px 20px 0 0;
	cursor: pointer;
}

.badgeMessage :hover {
	color: #409eff;
}
</style>
