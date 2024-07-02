<template>
  <div class="box">
    <el-card class="card" v-for="item in tableData" :key="item.id">
      <div class="userInfo">
        <div class="info">
          <div class="left">
            <el-image style="width: 100px; height: 100px" :src="item.avatar" fit="cover" />
          </div>
          <div class="right">
            <span><strong>用户名称: </strong>{{ item.username }}</span>
            <span><strong>所处地区: </strong>{{ item.city }}</span>
            <span><strong>联系方式: </strong>{{ item.phone }}</span>
            <span><strong>邮箱号: </strong>{{ item.email }}</span>
          </div>
        </div>
        <el-button type="primary" :icon="Message" round size="large" @click="handleContact(item)">打个招呼</el-button>
      </div>
    </el-card>
  </div>
</template>

<script setup>
import { ref, reactive, toRefs, onBeforeMount, onMounted, watchEffect, computed } from 'vue';
import { useStore } from 'vuex';
import { useRoute, useRouter } from 'vue-router';
import { Message } from '@element-plus/icons-vue'
import request from '@/utils/request'

const store = useStore();
const route = useRoute();
const router = useRouter();

const tableData = ref([])

onMounted(() => {
  getRandom()
})
const getRandom = () => {
  request.get('/sys/house/recommend/user').then((res) => {
    console.log(res);
    if (res.code == 200) {
      tableData.value = res.data;
    } else {
      ElMessage.warning(res.msg);
    }
  })
}
// 联系
const handleContact = (item) => {
  sessionStorage.setItem("chat_user", JSON.stringify(item));
  router.push({ path: "/message/chat", query: { userid: item.id } });
}



</script>
<style scoped lang='less'>
.box {
  width: 100%;
  margin: -5px;
  // background-color: pink;

  .card {
    max-width: 100%;
    margin-bottom: 10px;

    .userInfo {
      display: flex;
      justify-content: space-between;
      align-items: center;

      .info {
        display: flex;
        align-items: center;

        .right {
          margin-left: 20px;
          display: flex;
          flex-direction: column;
          justify-content: space-around;
          color: #7f7f7f;
        }
      }
    }
  }
}
</style>