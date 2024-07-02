<template>
    <u-comment :config="config" page relative-time @submit="submit">
        <!-- <template>导航栏卡槽</template> -->
        <!-- <template #info>用户信息卡槽</template> -->
        <!-- <template #card>用户信息卡片卡槽</template> -->
        <!-- <template #opearte>操作栏卡槽</template> -->
    </u-comment>
</template>

<script setup>
import emoji from '@/assets/emoji'
import { ref, reactive, onMounted } from 'vue'
import { UToast, createObjectURL } from 'undraw-ui'
import request from '@/utils/request'
import { useRoute, useRouter } from 'vue-router';
import { ElMessage } from 'element-plus';
const router = useRouter();
// 父组件传递过来的值
const props = defineProps({
    houseId: {
        type: Number,
        required: true
    }
});
// 配置项
const config = reactive({
    user: localStorage.getItem('user') ? JSON.parse(localStorage.getItem('user')) : "",
    emoji: emoji,
    comments: [],
    showLevel: false,
    showHomeLink: false,
    showAddress: false,
    showLikes: false
})

// 评论数据
const params = ref({
    houseId: props.houseId,
    // userId: localStorage.getItem('user') ? JSON.parse(localStorage.getItem('user')).id : null,
    current: 1,
    size: 10,
})
const getData = () => {
    request.get("/sys/comment/list", { params: params.value }).then((res) => {
        console.log(res.data.records);
        if (res.code == 200) {
            const formattedComments = res.data.records.map(comment => {
                return {
                    id: comment.id,
                    parentId: comment.parentId,
                    uid: comment.user ? comment.user.id : null,
                    address: comment.address || "未知地址",
                    content: comment.content,
                    likes: comment.likes,
                    contentImg: comment.contentImg || "",
                    createTime: comment.createTime,
                    user: {
                        username: comment.user.username,
                        avatar: comment.user.avatar,
                        level: comment.user.level,
                        homeLink: comment.user.homeLink
                    },
                    reply: {
                        total: comment.reply ? comment.reply.length : 0,
                        list: comment.reply ? comment.reply : []
                    }
                };
            });
            config.comments = formattedComments;
        }
    });

}
onMounted(() => {
    getData()
})


// 提交评论事件
const submit = ({ content, parentId, files, finish, reply }) => {
    if (!config.user.id) {
        ElMessage.warning("请先登录!")
        // router.push("/login")
        return
    }
    // let str = '提交评论:' + content + ';\t父id: ' + parentId + ';\t图片:' + files + ';\t被回复评论:'
    // console.log(str, reply)
    // console.log("houseId", props.houseId);
    // console.log("config.user.id", config.user.id);
    /**
     * 上传文件后端返回图片访问地址，格式以'||'为分割; 如:  '/static/img/program.gif||/static/img/normal.webp'
     */
    let contentImg = files.map(e => createObjectURL(e)).join('||')

    const comment = {
        parentId: parentId,
        houseId: props.houseId,
        userId: config.user.id,
        address: '来自桂林理工',
        content: content,
        likes: 0,
        contentImg: contentImg,
        user: {
            username: config.user.username,
            avatar: config.user.avatar,
            level: 6,
        },
        reply: null
    }
    // 发请求发送评论
    request.post("/sys/comment/save", comment).then(res => {
        // console.log(res);
        if (res.code == 200) {
            // 如果没有parentId，说明不是回复评论的     否则添加评论到列表
            if (!parentId) {
                // config.comments.unshift(comment)
            }
        }
    })
    setTimeout(() => {
        finish(comment)
        UToast({ message: '评论成功!', type: 'info' })
    }, 200)
}

config.comments = []
</script>