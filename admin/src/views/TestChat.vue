<template>
    <div class="chat-content">
        <!-- recordContent 聊天记录数组-->
        <div v-for="(itemc, indexc) in recordContent" :key="indexc">
            <!-- 对方 -->
            <div class="word" v-if="!itemc.mineMsg">
                <img :src="itemc.headUrl">
                <div class="info">
                    <p class="time">{{ itemc.nickName }} {{ chatTime(itemc.timestamp) }}</p>
                    <div class="info-content">{{ itemc.contactText }}</div>
                </div>
            </div>
            <!-- 我的 -->
            <div class="word-my" v-else>
                <div class="info">
                    <p class="time">{{ itemc.nickName }} {{ chatTime(itemc.timestamp) }}</p>
                    <div class="info-content">{{ itemc.contactText }}</div>
                </div>
                <img :src="itemc.headUrl">
            </div>
        </div>
    </div>

</template>

<script setup>
import { ref, reactive, toRefs, onBeforeMount, onMounted, watchEffect, computed } from 'vue';
import { useRoute, useRouter } from 'vue-router';

const route = useRoute();
const router = useRouter();

const recordContent = ref([{
    mineMsg: false,
    headUrl: 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png',
    nickName: '张三',
    timestamp: new Date('2024-05-05T08:00:00Z'),
    contactText: '你好啊！最近怎么样？'
}, {
    mineMsg: true,
    headUrl: 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png',
    nickName: '我',
    timestamp: new Date('2024-05-05T08:05:00Z'),
    contactText: '我很好，你呢？'
}, {
    mineMsg: false,
    headUrl: 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png',
    nickName: '张三',
    timestamp: new Date('2024-05-05T08:10:00Z'),
    contactText: '我也不错。'
}
])

const chatTime = (date) => {
    return date.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
}


</script>
<style scoped lang='less'>
.chat-content {
    width: 100%;
    // padding: 20px;
    background-color: pink;

    .word {
        display: flex;
        margin-bottom: 20px;

        img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
        }

        .info {
            margin-left: 10px;

            .time {
                font-size: 12px;
                color: rgba(51, 51, 51, 0.8);
                margin: 0;
                height: 20px;
                line-height: 20px;
                margin-top: -5px;
            }

            .info-content {
                padding: 10px;
                font-size: 14px;
                background: #fff;
                position: relative;
                margin-top: 8px;
            }

            //小三角形
            .info-content::before {
                position: absolute;
                left: -8px;
                top: 8px;
                content: '';
                border-right: 10px solid #FFF;
                border-top: 8px solid transparent;
                border-bottom: 8px solid transparent;
            }
        }
    }

    .word-my {
        display: flex;
        justify-content: flex-end;
        margin-bottom: 20px;

        img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
        }

        .info {
            width: 90%;
            margin-left: 10px;
            text-align: right;

            .time {
                font-size: 12px;
                color: rgba(51, 51, 51, 0.8);
                margin: 0;
                height: 20px;
                line-height: 20px;
                margin-top: -5px;
                margin-right: 10px;
            }

            .info-content {
                max-width: 70%;
                padding: 10px;
                font-size: 14px;
                float: right;
                margin-right: 10px;
                position: relative;
                margin-top: 8px;
                background: #A3C3F6;
                text-align: left;
            }

            //小三角形
            .info-content::after {
                position: absolute;
                right: -8px;
                top: 8px;
                content: '';
                border-left: 10px solid #A3C3F6;
                border-top: 8px solid transparent;
                border-bottom: 8px solid transparent;
            }
        }
    }
}
</style>