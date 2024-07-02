import { defineStore } from 'pinia';

export const useSidebarStore = defineStore('sidebar', {
    state: () => {
        return {
            collapse: false,
            hasRoutes: false, // 是否有动态路由
            hasRole: false, // 是否有角色
            menuList: [],
            // 存放权限
            permList: [],
            // 全局状态管理，默认显示首页标签
            editableTabsValue: 'Dashboard',
            editableTabs: [{
                title: '首页',
                name: 'Dashboard',
            }]
        };
    },
    getters: {},
    mutations: {
        setMenuList(state, menus) {
            state.menuList = menus
        },
        setPerList(state, perms) {
            state.permList = perms
        },
        changeRouteState(state, hasRoute) {
            state.hasRoute = hasRoute
        },
        // 添加tab
        addTab(state, tab) {
            // 防止重复添加
            let index = state.editableTabs.findIndex(e => e.name === tab.name)

            if (index === -1) {
                state.editableTabs.push({
                    title: tab.title,
                    name: tab.name,
                });
            }
            state.editableTabsValue = tab.name;
        },
        resetState: (state) => {
            state.menuList = []
            state.permList = []
            state.hasRoutes = false
            state.editableTabsValue = 'Index'
            state.editableTabs = [{
                title: '首页',
                name: 'Index',

            }]
        },
       
    },
    actions: {
        handleCollapse() {
            this.collapse = !this.collapse;
        }
    }
});
