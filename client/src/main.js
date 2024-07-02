import { createApp } from 'vue'
// import './style.css'
import App from './App.vue'
import router from './router/index.js'
import store from './store'
// 解决notification没有样式问题      有的组件引入之后没有样式，需要在这里引入
import "element-plus/theme-chalk/el-notification.css";
import "element-plus/theme-chalk/el-loading.css";
import "element-plus/theme-chalk/el-message.css";
import "element-plus/theme-chalk/el-message-box.css";


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

// undraw-ui
import UndrawUi from 'undraw-ui'
import 'undraw-ui/dist/style.css'
// DOMPurify使v-html绕过xss攻击
import VueDOMPurifyHTML from 'vue-dompurify-html'
// 全局引入百度地图组件
import BaiduMap from 'vue-baidu-map-3x'


import zhCn from 'element-plus/es/locale/lang/zh-cn';
import ElementPlus from 'element-plus';
import "element-plus/dist/index.css";
// 修改分页器默认文字
zhCn.el.pagination.total = '共 {total} 条';
zhCn.el.pagination.goto = '跳至';
zhCn.el.pagination.pagesize = '条/页';
zhCn.el.pagination.pageClassifier = '页';

// 聊天组件  基于elementui的服了
// import Chat from "jwchat";
// import "jwchat/style.css";

const app = createApp(App)
// 百度地图
app.use(BaiduMap, {
    // ak 是在百度地图开发者平台申请的密钥 详见 http://lbsyun.baidu.com/apiconsole/key */
    ak: 'hGar2RPyxSrN09NEauVb2Km9qB7HGPow',
    // v:'2.0',  // 默认使用3.0
    // type: 'WebGL' // ||API 默认API  (使用此模式 BMap=BMapGL)
});
// 全局挂载 echarts
app.config.globalProperties.$echarts = echarts
app.use(router).use(store).use(ElementPlus, { locale: zhCn }).use(i18n).use(UndrawUi).use(VueDOMPurifyHTML)
app.mount('#app')
