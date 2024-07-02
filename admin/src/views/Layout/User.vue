<template>
  <div>
    <div class="container">
      <!-- 表格顶部搜索 -->
      <div class="handle-box">
        <el-select v-model="params.address" placeholder="地址" class="handle-select mr10">
          <el-option key="1" label="广东省" value="广东省"></el-option>
          <el-option key="2" label="湖南省" value="湖南省"></el-option>
        </el-select>
        <el-input v-model="params.username" placeholder="用户名" class="handle-input mr10"></el-input>
        <el-input v-model="params.phone" placeholder="手机号" class="handle-input mr10"></el-input>
        <el-button type="primary" :icon="Search" @click="handleSearch">搜索</el-button>
        <el-button type="primary" :icon="Plus">新增</el-button>
      </div>
      <!-- 表格部分 -->
      <el-table :data="tableData" border class="table" ref="multipleTable" header-cell-class-name="table-header">
        <el-table-column type="index" label="顺序" width="60" fixed />
        <el-table-column label="头像(查看大图)" align="center" width="120">
          <template #default="scope">
            <el-image class="table-td-thumb" :src="scope.row.avatar" :z-index="10"
              :preview-src-list="[scope.row.avatar]" preview-teleported>
            </el-image>
          </template>
        </el-table-column>
        <el-table-column prop="username" label="用户名" width="120"></el-table-column>
        <el-table-column label="手机号" width="120">
          <template #default="scope">{{ scope.row.phone }}</template>
        </el-table-column>
        <el-table-column prop="id_card" label="身份证号" width="180"></el-table-column>
        <el-table-column prop="email" label="邮箱" width="180"></el-table-column>
        <el-table-column label="状态" align="center">
          <template #default="scope">
            <el-tag :type="scope.row.status == '1' ? 'success' : scope.row.status == '0' ? 'danger' : ''">
              {{ scope.row.status == 1 ? '启用' : (scope.row.status == 0 ? '禁用' : '') }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="create_time" label="账户状态" width="180">
          <template v-slot="scope">
            <el-switch v-model="scope.row.status" size="large" active-text="启用" inactive-text="禁用"
              :loading="switchLoading" :before-change="beforeStatusChange" :active-value="1" :inactive-value="0"
              @change="statusChange(scope.row)" />
          </template>
        </el-table-column>

        <el-table-column prop="create_time" label="注册时间" min-width="160" sortable></el-table-column>
        <el-table-column fixed="right" label="操作" width="220" align="center">
          <template #default="scope">
            <el-button text :icon="Edit" @click="handleEdit(scope.row)">
              编辑
            </el-button>
            <el-button text :icon="Delete" class="red" @click="handleDelete(scope.row)">
              删除
            </el-button>
          </template>
        </el-table-column>
      </el-table>
      <!-- 分页器 -->
      <div class="pagination">
        <el-pagination @size-change="pageSizeChange" @current-change="pageChange" :current-page="params.pageNum"
          :page-sizes="[5, 10, 15, 20]" :page-size="params.pageSize" layout="total, sizes, prev, pager, next, jumper"
          :total="total">
        </el-pagination>
      </div>
    </div>

    <!-- dialog弹出框 -->
    <el-dialog v-model="dialogVisible" :title="dialogMode" width="40%" draggable>
      <el-scrollbar height="60vh">
        <span>
          <el-form label-width="100px" :model="editInfo" style="max-width: 460px">
            <!-- 头像部分，有些长 -->
            <el-form-item label="头像">
              <!-- 上传与预览 -->
              <el-upload v-model:file-list="fileList" :action="uploadUrl" list-type="picture-card"
                :on-preview="handlePicturePreview" :limit="1" :on-remove="handleRemove" :on-success="successUpload">
                <el-icon>
                  <Plus />
                </el-icon>
              </el-upload>
              <!-- 图片预览 -->
              <el-dialog class="previewImg" v-model="imageVisible">
                <img w-full :src="dialogImageUrl" alt="预览图片" />
              </el-dialog>
            </el-form-item>
            <el-form-item label="用户名">
              <el-input v-model="editInfo.username" />
            </el-form-item>
            <el-form-item label="手机号">
              <el-input v-model="editInfo.phone" />
            </el-form-item>
            <el-form-item label="邮箱">
              <el-input v-model="editInfo.email" />
            </el-form-item>
            <el-form-item label="性别">
              <el-select v-model="editInfo.gender" placeholder="请选择性别">
                <el-option label="男" value="男" />
                <el-option label="女" value="女" />
              </el-select>
            </el-form-item>
          </el-form>
        </span>
      </el-scrollbar>

      <template #footer>
        <span class="dialog-footer">
          <el-button @click="handleCancel">取消</el-button>
          <el-button type="primary" @click="handleSubmit">
            确认
          </el-button>
        </span>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue';
import { ElMessage, ElMessageBox } from 'element-plus';
import { Delete, Edit, Search, Plus } from '@element-plus/icons-vue';
import request from '@/utils/request';
import { uploadUrl } from '@/utils/request';

onMounted(() => {
  getData();
})

// 分页查询、模糊查询所需要的参数
const params = ref({
  username: '',
  phone: '',
  id_card: '',
  email: '',
  pageNum: 1,
  pageSize: 10,
})
const tableData = ref([]);
const total = ref(0);
const dialogVisible = ref(false);
// 获取表格数据
const getData = () => {
  request.get('/user/alluser/search', { params: params.value }).then((res) => {
    if (res.code == 200) {
      // console.log(res.data.list);
      total.value = res.data.total;
      tableData.value = res.data.list;
    } else {
      ElMessage.warning(res.msg);
    }
  }).catch((err) => {
    ElMessage.warning(err);
  })
};
// 查询操作
const handleSearch = () => {
  params.value.pageNum = 1;
  getData();
};

// 编辑或者新增
const dialogMode = ref('新增');
const editInfo = ref({})
const handleEdit = (row) => {
  dialogMode.value = '编辑';
  const originInfo = { ...row }; // 创建 row 的副本
  dialogVisible.value = true;
  editInfo.value = originInfo;
  if (row.avatar != null) {
    fileList.value = [{
      url: row.avatar,
      name: row.avatar,
    }];
  }
}
const handleCancel = () => {
  dialogVisible.value = false;
  editInfo.value = {};
  fileList.value = [];
}
const handleSubmit = () => {
  request.post("/user", editInfo.value).then((res) => {
    if (res.code == 200) {
      ElMessage.success(`${dialogMode}'成功!'`);
      getData();
      handleCancel();
    } else {
      ElMessage.warning(res.msg);
    }
  })
}
// 头像部分（上传与预览）
// const uploadUrl = ref("http://localhost:8000/api/files/upload/oss/img")
const imageVisible = ref(false)
const dialogImageUrl = ref('')
const fileList = ref([])
const handleRemove = (file) => {
  const index = fileList.value.indexOf(file);
  if (index !== -1) {
    fileList.splice(index, 1);
  }
}
const handlePicturePreview = (file) => {
  dialogImageUrl.value = file.url
  imageVisible.value = true
}
// 上传头像成功
const successUpload = (res) => {
  console.log(res);
  editInfo.value.avatar = res.data
}
// 删除操作
const handleDelete = (row) => {
  // 二次确认删除
  ElMessageBox.confirm('确定要删除吗？', '提示', {
    type: 'warning'
  }).then(() => {
    ElMessage.success('删除成功');
  }).catch(() => { });
};
// 分页器功能
const pageSizeChange = (pageSize) => {
  params.value.pageSize = pageSize;
  getData();
}
const pageChange = (pageNum) => {
  params.value.pageNum = pageNum;
  getData();
}
// 状态
const switchStatus = ref(false); // 开关的状态
const switchLoading = ref(false); // 开关的加载状态
const statusChange = (row) => {
  beforeStatusChange()
    .then(() => {
      // 发送请求
      request.post(`/user/status/${row.id}`).then((res) => {
        if (res.code == 200) {
          ElMessage.success('修改成功');
          switchStatus.value = !switchStatus.value; // 切换开关状态
          getData();
        } else {
          ElMessage.warning(res.msg);
        }
      });
    })
    .catch((error) => {
      console.error(error);
      switchLoading.value = false;
    });
};
const beforeStatusChange = () => {
  switchLoading.value = true;
  return new Promise((resolve) => {
    setTimeout(() => {
      switchLoading.value = false;
      // ElMessage.success('成功！');
      resolve(true);
    }, 500);
  });
};

</script>

<style scoped>
.container {
  width: 95%;
  height: 100%;
  margin: -5px;
}

.handle-box {
  margin-bottom: 20px;
}

.handle-select {
  width: 120px;
}

.handle-input {
  width: 300px;
}

.table {
  width: 100%;
  font-size: 14px;
}

.red {
  color: #F56C6C;
}

.mr10 {
  margin-right: 10px;
}

.table-td-thumb {
  display: block;
  margin: auto;
  width: 50px;
  height: 50px;
}


/* 头像预览 */
.previewImg img {
  width: 100%;
  height: 100%;
}
</style>
