import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

import AutoImport from 'unplugin-auto-import/vite'
import Components from 'unplugin-vue-components/vite'
import { ElementPlusResolver } from 'unplugin-vue-components/resolvers'





// 配置别名
import path from "path";

// https://vitejs.dev/config/
export default defineConfig({
  base: './',
  // base: '/dist/',
  plugins: [
    vue(),
    AutoImport({
      resolvers: [ElementPlusResolver()]
    }),
    Components({
      resolvers: [ElementPlusResolver()],
    }),
  ],
  server: {
    host: '0.0.0.0',
    port: 8080,
    client: {
      // webSocketURL: 'ws://0.0.0.0:8000/ws',
    },
    headers: {
      'Access-Control-Allow-Origin': '*',
    },
    proxy: {
      '/api': {
        target: 'http://localhost:3000',
        changeOrigin: true,
        rewrite: (path) => path.replace(/^\/api/, '')
      },
      '/ws': {
        target: process.env.BASE_URL,
        changeOrigin: true, //开启代理
        ws: true, // 是否启用websockets
        pathRewrite: {
          '^/ws': ''
        }
      }
    }
  },
  resolve: {
    alias: {
      '@': path.resolve(__dirname, './src/'),
    }
  },

  build: {
    outDir: 'dist',
    emptyOutDir: true,
    rollupOptions: {
      output: {
        manualChunks: {
          'element-plus': ['element-plus'],
        },
      },
    },
  },

})



