<template>
  <div class="container">
    <el-empty description="空空如也" v-if="total == 0" />
    <!-- 卡片视图 -->
    <div class="card">
      <el-card class="elcard" shadow="hover" v-for="item in dataList" :key="item.id" @click="goDetail(item)">
        <el-image style="width: 100px; height: 100px" :src="item.house.list.length > 0 ? item.house.list[0].url : ''"
          fit="cover" />
        <el-tooltip :content="item.houseName" placement="bottom" effect="light">
          <span style="font-size:12px;color:#7f7f7f">{{ item.houseName }}</span>
        </el-tooltip>
      </el-card>
      <i></i><i></i><i></i><i></i><i></i><i></i><i></i>
    </div>
    <!-- 分页器 -->
    <div class="pagination" v-if="total > 0">
      <el-pagination @size-change="pageSizeChange" @current-change="pageChange" :current-page="params.current"
        :page-sizes="[5, 10, 15, 20]" :page-size="params.size" layout="total, sizes, prev, pager, next, jumper"
        :total="total">
      </el-pagination>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, toRefs, onBeforeMount, onMounted, watchEffect, computed } from 'vue';
import { useStore } from 'vuex';
import { useRoute, useRouter } from 'vue-router';
import request from '@/utils/request.js'
import { ElMessage } from 'element-plus';

const store = useStore();
const route = useRoute();
const router = useRouter();

// 分页查询、模糊查询所需要的参数
const params = ref({
  houseName: "",
  current: 1,
  size: 10
})
onMounted(() => {
  getData()
})
const dataList = ref([])
const getData = () => {
  request.get("/sys/history/list", { params: params.value }).then(res => {
    // console.log(res);
    if (res.code == 200) {
      dataList.value = res.data.records
      total.value = res.data.total
    } else {
      ElMessage.warning(res.msg)
    }
  })
}
// 点击查看详情
const goDetail = (item) => {
  router.push({ path: '/house/detail', query: { id: item.houseId } })
}
// 分页器功能
const total = ref(0);
const pageSizeChange = (pageSize) => {
  params.value.size = pageSize;
  getData();
}
const pageChange = (pageNum) => {
  console.log(pageNum);
  params.value.current = pageNum;
  getData();
}
</script>
<style scoped lang='less'>
.container {
  width: 100%;
  height: 100%;
  padding: 10px;
  box-sizing: border-box;

  .card {
    display: flex;
    justify-content: space-between;
    flex-wrap: wrap;

    .elcard {
      width: 150px;
      height: 173px;
      text-align: center;
      margin-bottom: 10px;
      cursor: pointer;
    }

    i {
      width: 150px;
      margin-right: 10px;
    }
  }

  .pagination {
    margin-top: 10px;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 50px;
  }
}
</style>