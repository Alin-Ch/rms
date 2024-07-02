import { createStore } from 'vuex'

const store = createStore({
    state() {
        return {
            // 状态数据
        }
    },
    mutations: {
        // 修改状态数据的方法
    },
    actions: {
        // 异步操作和业务逻辑
    },
    getters: {
        // 获取状态数据的方法
    },
    modules: {
        // 模块化管理状态
    }
})

export default store
