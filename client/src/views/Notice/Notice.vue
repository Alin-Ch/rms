<template>
  <div class="container">
    <div class="top">
      <div class="carousel">
        <el-carousel trigger="click" height="300px">
          <el-carousel-item v-for="item in carouselList" :key="item">
            <img :src="item" alt="">
          </el-carousel-item>
        </el-carousel>
      </div>
      <div class="calendar">
        <el-calendar class="elcalendar" v-model="dateValue" />
      </div>
    </div>

    <div class="content">
      <!-- 左边的公告列表 -->
      <div class="l-content">
        <el-card class="content-card" shadow="hover" v-for="item in noticeList" :key="item.id"
          @click="redirectToDetail(item.id)">
          <div style="font-weight:bold;font-size:20px;">{{ item.title }}</div>
          <div style="font-size:12px;margin-top:10px;color:#7f7f7f;">社区中心 {{ item.create_time }}</div>
        </el-card>
        <!-- 分页器 -->
        <div class="pagination">
          <el-pagination @size-change="pageSizeChange" @current-change="pageChange" :current-page="params.pageNum"
            :page-sizes="[5, 10, 15, 20]" :page-size="params.pageSize" layout="total, sizes, prev, pager, next, jumper"
            :total="total">
          </el-pagination>
        </div>
      </div>
    </div>


  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useStore } from 'vuex';
import { useRoute, useRouter } from 'vue-router';
import request from '@/utils/request'
import Header from '@/components/Header.vue';
import Detail from './Detail.vue';
import { Edit } from '@element-plus/icons-vue'

const store = useStore();
const route = useRoute();
const router = useRouter();

const carouselList = ref([
  "http://www.luoohu.com/pic/2023-11/30/30620016_a7006053-8b39-428f-aebb-191b086a6567.jpg",
  "http://www.luoohu.com/pic/2023-11/20/30599568_9dbc814b-8551-480f-ac54-7c18bd13dd0b_batchwmcopy.JPG",
  "http://www.luoohu.com/pic/2023-09/07/30459008_2c371f2b-9fbc-4b21-b3f9-dad5a1d99f17.jpg",
  "http://www.luoohu.com/pic/2023-09/05/30453722_dd2ef585-26e8-4b80-a4f4-1414a4c5ac8dcopy.jpg",
  "http://www.luoohu.com/pic/2023-08/21/30416501_825ca1d2-1900-4c0f-a440-ab5feb0115c0.jpg"
])
const dateValue = ref(new Date())
// 分页查询需要的参数
const params = ref({
  pageNum: 1,
  pageSize: 5
})

const redirectToDetail = (id) => {
  router.push({ path: '/notice/detail', query: { id } });
}


onMounted(() => {
  getNoticeList()
})

// 获取公告
const noticeList = ref([])
const getNoticeList = () => {
  request.get("/sys/notice/list", { params: params.value }).then((res) => {
    // console.log(res);
    if (res.code == 200) {
      total.value = res.data.total
      noticeList.value = res.data.records
    } else {
      ElMessage.warning(res.msg)
    }
  })
}
// 获取反馈
const feedbackList = ref([])
const getFeedbackList = () => {
  request.get("/feedback/search", { params: params.value }).then((res) => {
    // console.log(res);
    if (res.code == 200) {
      feedbackList.value = res.data.list
      feedbackList.value.forEach(item => {
        const createDate = item.create_time.split(' ')[0];
        item.create_time = createDate;
      });
    } else {
      ElMessage.warning(res.msg)
    }
  })
}
// 分页器功能
const total = ref(0);
const pageSizeChange = (pageSize) => {
  params.value.pageSize = pageSize;
  getNoticeList();
}
const pageChange = (pageNum) => {
  params.value.pageNum = pageNum;
  getNoticeList();
}


</script>
<style scoped lang='less'>
.container {
  width: 80%;
  margin: 20px auto;
  // background-color: pink;

  .top {
    display: flex;
    justify-content: space-around;
    align-items: center;

    .carousel {
      width: 500px;
      height: 300px;

      // background-color: skyblue;
      .el-carousel__item img {
        width: 100%;
        height: 100%;
        object-fit: cover;
      }

    }

    .calendar {
      width: 400px;
      height: 390px;
      // background-color: skyblue;

      // .elcalendar /deep/ .el-calendar-table .el-calendar-day {
      .elcalendar :deep(.el-calendar-table .el-calendar-day) {
        width: 60px;
        height: 40px;
      }
    }
  }

  .content {
    display: flex;
    justify-content: space-between;

    .l-content {
      .content-card {
        width: 550px;
        height: 100px;
        display: flex;
        flex-direction: column;
        justify-content: space-around;
        font-family: 'KaiTi';
      }

      .pagination {
        margin-top: 10px;
      }
    }


  }
}
</style>