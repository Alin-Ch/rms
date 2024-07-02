import { createRouter, createWebHistory } from 'vue-router';
import { ElMessage } from 'element-plus';
import axios from 'axios';
import store from '@/store/index.js';
import { baseURL } from '@/utils/request';

// 解决路由动态导入
const modules = import.meta.glob("../views/**/**.vue")

const routes = [
    {
        path: '/:catchAll(.*)',
        component: () => import('@/components/404.vue'),
    }, {
        path: '/test/map',
        name: 'Map',
        component: () => import('@/components/BaiduMap.vue'),
    }, {
        path: '/login',
        name: 'Login',
        component: () => import('@/views/Login.vue'),
    }, {
        path: '/register',
        name: 'Register',
        component: () => import('@/views/Register.vue'),
    }, {
        path: '/forget',
        name: 'ForgetPassword',
        component: () => import('@/views/ForgetPassword.vue'),
    }, {
        path: '/message',
        name: 'Message',
        component: () => import('@/views/Chat/index.vue'),
        children: [
            {
                path: '/message/chat',
                name: 'Chat',
                component: () => import("@/views/Chat/Chat.vue"),
                meta: { title: 'Chat' }
            },
        ]
    }, {
        path: '/',
        redirect: '/dashboard',
        name: 'Layout',
        component: () => import('@/views/Layout.vue'),
        meta: { title: '首页' },
        children: [
            {
                path: '/dashboard',
                name: 'Dashboard',
                component: () => import('@/views/Layout/Dashboard.vue'),
                meta: { title: '首页' },
            },
            {
                path: '/sys/personal',
                name: 'Personal',
                component: () => import('@/views/sys/Personal.vue'),
                meta: { title: '个人中心' },
            },
        ],
    },
];

const router = createRouter({
    history: createWebHistory(),
    routes,
});

router.beforeEach(async (to, from, next) => {
    const loggedIn = localStorage.getItem('token');
    let hasRoutes = store.state.menus.hasRoutes;

    if (to.path === '/forget' || to.path === '/login' || to.path === '/register') {
        next();
    } else if (!loggedIn || loggedIn.trim() === '') {
        ElMessage.warning('请先登录');
        next('/login');
    } else {
        if (loggedIn && !hasRoutes) {
            try {
                const res = await axios.get(`${baseURL}/sys/menu/nav`, {
                    headers: {
                        Authorization: localStorage.getItem('token'),
                    },
                });

                store.commit('menus/setMenuList', res.data.data.nav);
                store.commit('menus/setPerList', res.data.data.authorities);

                let newRoutes = [];

                res.data.data.nav.forEach((menu) => {
                    if (menu.children) {
                        menu.children.forEach((e) => {
                            let route = menuToRoute(e);
                            if (route) {
                                newRoutes.push(route);
                            }
                        });
                    }
                });

                newRoutes.forEach((route) => {
                    router.addRoute('Layout', route); // 添加到 'Layout' 路由下
                });

                store.commit('menus/changeRouteState', true);
                next({ ...to, replace: true });
            } catch (error) {
                console.error('Failed to fetch navigation:', error);
            }
        } else {
            next();
        }
    }
});

const menuToRoute = (menu) => {
    if (!menu.component) {
        return null;
    }

    return {
        name: menu.name,
        path: menu.path,
        meta: {
            icon: menu.icon,
            title: menu.title,
        },
        component: modules[`../views/${menu.component}.vue`],
    };
};

export default router;
