import { createRouter, createWebHistory } from 'vue-router'
import Login from '@/views/Login.vue'
import Register from '@/views/Register.vue'
import ForgetPassword from '@/views/ForgetPassword.vue'

import index from '@/views/index.vue'
import { ElMessage } from 'element-plus'

// 引入封装的nprogress.js
import { start, close } from '@/utils/nprogress';
import { KeepAlive } from 'vue'


const routes = [
    // 通配符路由，用于匹配所有未定义的路由
    {
        path: "/:catchAll(.*)",
        component: () => import("@/components/404.vue"),
    }, {
        path: '/test',
        name: 'Test',
        component: () => import('@/views/TestThreeJS.vue')
    }, {
        path: '/test/chat',
        name: 'TestChat',
        component: () => import('@/views/TestChat.vue')
    }, {
        path: '/test/iframe',
        name: 'Iframe',
        component: () => import('@/views/TestIFrame.vue')
    }, {
        path: '/test/baidumap',
        name: 'Baidumap',
        component: () => import('@/components/BaiduMapShow.vue')
    }, {
        path: '/login',
        name: 'Login',
        component: Login
    }, {
        path: '/register',
        name: 'Register',
        component: Register
    }, {
        path: '/forget',
        name: 'forget',
        component: ForgetPassword
    }, {
        path: '',
        redirect: '/index',
        name: 'index',
        component: index,
        meta: { title: '首页', KeepAlive: true },
        children: [{
            path: '/index',
            name: 'index',
            component: () => import('@/views/index.vue'),
            meta: { title: '首页', KeepAlive: true }
        },
        ]
    }, {
        path: '/notice/all',
        name: 'NoticeIndex',
        component: () => import('@/views/Notice/index.vue'),
        meta: { title: '通知公告', KeepAlive: true },
        children: [{
            path: '/notice/all',
            name: 'Notice',
            component: () => import('@/views/Notice/Notice.vue'),
            meta: { title: '通知公告', KeepAlive: true }
        }, {
            path: '/notice/detail',
            name: 'Detail',
            component: () => import('@/views/Notice/Detail.vue'),
            meta: { title: '公告详情', KeepAlive: true }
        },]
    }, {
        path: '/user',
        name: 'User',
        component: () => import('@/views/User/index.vue'),
        meta: { title: '个人中心', KeepAlive: true },
        children: [{
            path: '', // 空路径表示匹配默认子路由
            redirect: '/user/certification' // 重定向到 /user/certification
        }, {
            path: '/user/certification',
            name: 'Certification',
            component: () => import('@/views/User/Certification/Certification.vue'),
            meta: { title: '实名认证', KeepAlive: true }
        }, {
            path: '/user/profile',
            name: 'Profile',
            component: () => import('@/views/User/Profile/Profile.vue'),
            meta: { title: '个人信息', KeepAlive: true }
        }, {
            path: '/user/feedback',
            name: 'Feedback',
            component: () => import('@/views/User/Feedback/Feedback.vue'),
            meta: { title: '反馈意见', KeepAlive: true }
        }, {
            path: '/user/order',
            name: 'Order',
            component: () => import('@/views/User/Order/Order.vue'),
            meta: { title: '缴费订单', KeepAlive: true }
        }, {
            path: '/user/favorite',
            name: 'Favorite',
            component: () => import('@/views/User/Favorite/Favorite.vue'),
            meta: { title: '我的收藏', KeepAlive: true }
        }, {
            path: '/user/history',
            name: 'History',
            component: () => import('@/views/User/History/History.vue'),
            meta: { title: '浏览历史', KeepAlive: true }
        }, {
            path: '/user/tips',
            name: 'Tips',
            component: () => import('@/views/User/Tips/Tips.vue'),
            meta: { title: '消息通知', KeepAlive: true }
        }]
    }, {
        path: '/house',
        name: 'HouseIndex',
        component: () => import('@/views/House/index.vue'),
        meta: { title: '所有房屋', KeepAlive: true },
        children: [{
            path: '/house',
            name: 'House',
            component: () => import('@/views/House/House.vue'),
            meta: { title: '所有房屋', KeepAlive: true }
        }, {
            path: '/house/detail',
            name: 'HouseDetail',
            component: () => import('@/views/House/Detail.vue'),
            meta: { title: '房屋详情', KeepAlive: true }
        }, {
            path: '/house/shop/detail',
            name: 'ShopDetail',
            component: () => import('@/views/House/ShopDetail.vue'),
            meta: { title: '店铺详情', KeepAlive: true }
        }, {
            path: '/house/threejs',
            name: 'ThreeJS',
            component: () => import('@/views/House/ThreeJS.vue'),
            meta: { title: '全景图查看', KeepAlive: true }
        },]
    }, {
        path: '/message',
        name: 'Message',
        component: () => import('@/views/Chat/index.vue'),
        children: [
            {
                path: '/message/chat',
                name: 'Chat',
                component: () => import("@/views/Chat/Chat.vue"),
                meta: { title: 'Chat', KeepAlive: true }
            },
        ]
    },
]

const router = createRouter({
    history: createWebHistory(),
    routes
})
router.beforeEach((to, from, next) => {
    start()  //开始进度条
    const loggedIn = JSON.parse(localStorage.getItem('user'))

    if (to.path === '/forget' || to.path === '/login' || to.path === '/register' || to.path === '/index' || to.path === '/notice/all' || to.path === '/notice/detail' || to.path === '/house' || to.path === '/house/detail' || to.path === '/house/shop/detail') {
        next()
    } else if (!loggedIn) {
        // 如果当前路由需要验证登录状态，但用户未登录，则跳转到登录页面
        ElMessage.warning('请先登录')
        setTimeout(() => {
            next('/login')
        }, 500)
    } else {
        // 其他情况下，直接放行
        next()
    }
})
// 路由加载结束后执行
router.afterEach(() => {
    close()  //进度条结束
})

export default router
