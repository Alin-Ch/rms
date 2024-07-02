import { defineStore } from 'pinia'

export const todos = defineStore('todos', {
    state: () => ({
        /** @type {{ text: string, id: number, isFinished: boolean }[]} */
        todos: [],
        /** @type {'all' | 'finished' | 'unfinished'} */
        filter: 'all',
        // type 会自动推断为 number
        nextId: 0,
    }),
    getters: {
        finishedTodos(state) {
            // 自动完成! ✨
            return state.todos.filter((todo) => todo.isFinished)
        },
        unfinishedTodos(state) {
            return state.todos.filter((todo) => !todo.isFinished)
        },
        /**
         * @returns {{ text: string, id: number, isFinished: boolean }[]}
         */
        filteredTodos(state) {
            if (this.filter === 'finished') {
                // 自动调用其他 getter ✨
                return this.finishedTodos
            } else if (this.filter === 'unfinished') {
                return this.unfinishedTodos
            }
            return this.todos
        },
    },
    actions: {
        // 任何数量的参数，返回一个 Promise 或者不返回
        addTodo(text) {
            // 你可以直接改变状态
            this.todos.push({ text, id: this.nextId++, isFinished: false })
        },
    },
})