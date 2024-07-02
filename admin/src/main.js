import { createApp } from 'vue'
// import './style.css'
import App from './App.vue'
import router from './router/index.js'
import store from './store'
import { createPinia } from 'pinia';

// 配置全局中文
import { createI18n } from 'vue-i18n'
const i18n = createI18n({
    locale: 'zh-cn', // 设置默认语言为中文
    messages: {
        'zh-cn': {
            el: {
                pagination: {
                    total: '共 {total} 条',
                    sizes: '每页显示',
                    items: '条',
                    first: '首页',
                    last: '尾页',
                    prev: '上一页',
                    next: '下一页',
                    jumper: '前往',
                },
            },
        },
    },
})

// 引入 echarts
import * as echarts from 'echarts'
// 全局水印
import vue3WaterMarker from "vue3-water-marker"
// 全局引入百度地图组件
import BaiduMap from 'vue-baidu-map-3x'
// 腾讯地图相关



// 引入样式
import 'element-plus/theme-chalk/index.css'

import zhCn from 'element-plus/es/locale/lang/zh-cn';
import ElementPlus from 'element-plus';
import * as ElementPlusIconsVue from '@element-plus/icons-vue';
// 修改分页器默认文字
zhCn.el.pagination.total = '共 {total} 条';
zhCn.el.pagination.goto = '跳至';
zhCn.el.pagination.pagesize = '条/页';
zhCn.el.pagination.pageClassifier = '页';

const app = createApp(App)
// 百度地图
app.use(BaiduMap, {
    // ak 是在百度地图开发者平台申请的密钥 详见 http://lbsyun.baidu.com/apiconsole/key */
    ak: 'hGar2RPyxSrN09NEauVb2Km9qB7HGPow',
    // v:'2.0',  // 默认使用3.0
    // type: 'WebGL' // ||API 默认API  (使用此模式 BMap=BMapGL)
});
// 注册elementplus图标
for (const [key, component] of Object.entries(ElementPlusIconsVue)) {
    app.component(key, component);
}
// 全局挂载 echarts
app.config.globalProperties.$echarts = echarts
app.use(createPinia());
app.use(router).use(store).use(ElementPlus, { locale: zhCn }).use(i18n).use(vue3WaterMarker)
app.mount('#app')
