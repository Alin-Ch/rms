<template>
    <div class="sidebar">
        <el-menu class="sidebar-el-menu" :default-active="onRoutes" :collapse="sidebar.collapse"
            background-color="#324157" text-color="#bfcbd9" active-text-color="#20a0ff" unique-opened router>
            <!-- 先展示首页 -->
            <el-menu-item index="/dashboard">
                <el-icon>
                    <component is="Odometer"></component>
                </el-icon>
                <template #title>系统首页</template>
            </el-menu-item>
            <!-- 再展示动态路由 -->
            <template v-for="(item, index) in menuList" :key="index">
                <template v-if="item.children">
                    <el-sub-menu :index="item.name" :key="item.name">
                        <template #title>
                            <el-icon>
                                <component :is="item.icon"></component>
                            </el-icon>
                            <span>{{ item.title }}</span>
                        </template>
                        <template v-for="subItem in item.children">
                            <el-menu-item :index="subItem.path">
                                <el-icon>
                                    <component :is="subItem.icon"></component>
                                </el-icon>
                                <template #title>{{ subItem.title }}</template>
                            </el-menu-item>
                            <!-- 这里如果有3级菜单，就写v-if="subItem.children"，这里后端返回的第三级是路径.. -->
                            <!-- <el-sub-menu v-if="subItem.children" :index="subItem.path" :key="subItem.path">
                                <template #title>{{ subItem.title }}</template>
<el-menu-item v-for="(threeItem, path) in subItem.children" :key="path" :index="threeItem.path">
    {{ threeItem.title }}
</el-menu-item>
</el-sub-menu>
<el-menu-item v-else :index="subItem.path">
    {{ subItem.title }}
</el-menu-item> -->
                        </template>
                    </el-sub-menu>
                </template>
                <template v-else>
                    <el-menu-item :index="item.path" :key="item.path">
                        <el-icon>
                            <component :is="item.icon"></component>
                        </el-icon>
                        <template #title>{{ item.title }}</template>
                    </el-menu-item>
                </template>
            </template>
        </el-menu>
    </div>
</template>

<script setup>
import { computed, onMounted } from 'vue';
import { useSidebarStore } from '../store/Sidebar.js';
import { useRoute, useRouter } from 'vue-router';
import store from '../store/index.js'

const items = [{
    icon: 'Odometer',
    index: '/dashboard',
    title: '系统首页',
}, {
    icon: 'user',
    index: '1',
    title: '用户相关',
    subs: [{
        index: '/user',
        title: '用户管理',
    }, {
        index: '/import',
        title: '导入Excel',
    }, {
        index: '/export',
        title: '导出Excel',
    },
    ],
}, {
    icon: 'DocumentCopy',
    index: '/tabs',
    title: 'tab选项卡',
}, {
    icon: 'Edit',
    index: '3',
    title: '表单相关',
    subs: [{
        index: '/form',
        title: '基本表单',
    }, {
        index: '/upload',
        title: '文件上传',
    }, {
        index: '4',
        title: '三级菜单',
        subs: [{
            index: '/editor',
            title: '富文本编辑器',
        }, {
            index: '/markdown',
            title: 'markdown编辑器',
        },
        ],
    },
    ],
}, {
    icon: 'Setting',
    index: '/icon',
    title: '自定义图标',
}, {
    icon: 'PieChart',
    index: '/charts',
    title: 'schart图表',
}, {
    icon: 'Warning',
    index: '/permission',
    title: '权限管理',
}, {
    icon: 'CoffeeCup',
    index: '/donate',
    title: '支持作者',
},
];

onMounted(() => {
    // router.options.routes = menuList.value;
    // console.log("导航信息---", router.options.routes);
    // console.log(menuList.value)
    // console.log(hasRole.value);
});

const route = useRoute();
const router = useRouter();
const onRoutes = computed(() => {
    return route.path;
})
const menuList = computed(() => {
    return store.state.menus.menuList
})

const hasRole = computed(() => {
    return store.getters["menus/hasRole"]("ROLE_admin")
})

const sidebar = useSidebarStore();
</script>

<style scoped>
.sidebar {
    display: block;
    position: absolute;
    left: 0;
    top: 70px;
    bottom: 0;
    overflow-y: scroll;
}

.sidebar::-webkit-scrollbar {
    width: 0;
}

.sidebar-el-menu:not(.el-menu--collapse) {
    width: 250px;
}

.sidebar>ul {
    height: 100%;
}
</style>
