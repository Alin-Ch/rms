<template>
    <div class="container">
        <!-- 顶部搜索功能 -->
        <div class="top">
            <span>搜索</span>
            <!-- 反馈类型 -->
            <el-select class="el-select" v-model="params.feedbackType" placeholder="反馈类型" size="large" clearable>
                <el-option v-for="item in feedbackTypeList" :key="item.id" :label="item.name" :value="item.name"
                    @click="params.feedbackTypeId = item.id" />
            </el-select>
            <!-- 反馈处理进程 -->
            <el-select class="el-select" v-model="params.feedbackStatusName" placeholder="反馈处理进程" size="large" clearable>
                <el-option v-for="item in feedbackStatusList" :key="item.id" :label="item.name" :value="item.name"
                    @click="params.feedbackStatus = item.id" />
            </el-select>
            <!-- 内容搜索 -->
            <el-input v-model="params.feedbackTitle" class="searchInput" size="large" placeholder="反馈/公共 标题"
                :prefix-icon="Search" clearable />
            <el-button style="margin-left: 20px;" type="primary" size="default" @click="clear">清空</el-button>
            <el-button style="margin-left: 20px;" type="primary" size="default" @click="getFeedbackList">搜索</el-button>
            <el-button style="margin-left: 20px;" type="primary" size="default" @click="add">发起投诉</el-button>
        </div>
        <!-- 中间部分 -->
        <el-table :data="feedbackList" max-height="600" border style="width: 1000px">
            <el-table-column type="expand">
                <template #default="props">
                    <div style="padding-left: 20px;" m="4">
                        <p m="t-0 b-2"><strong>投诉人：</strong> {{ props.row.user_name }}</p>
                        <p m="t-0 b-2"><strong>联系方式：</strong> {{ props.row.user_phone }}</p>
                        <p m="t-0 b-2"><strong>地址：</strong> {{ props.row.groupName }} - {{ props.row.cell }} - {{
                            props.row.room_number
                        }}</p>
                        <p m="t-0 b-2"><strong>投诉类型：</strong> {{ props.row.typeName }}</p>
                    </div>
                </template>
            </el-table-column>
            <el-table-column prop="create_time" label="投诉时间" width="200" sortable>
                <template #default="scope">
                    <div style="display: flex; align-items: center">
                        <el-icon>
                            <timer />
                        </el-icon>
                        <span style="margin-left: 10px">{{ scope.row.create_time }}</span>
                    </div>
                </template>
            </el-table-column>
            <el-table-column prop="typeName" label="投诉类型" width="120" sortable />
            <el-table-column prop="title" label="投诉标题" width="180" />
            <el-table-column prop="content" label="投诉内容" width="300" />
            <el-table-column prop="status" label="是否处理" width="120" sortable>
                <template #default="scope">
                    <el-tag :type="scope.row.status == 2 ? '' : 'success'" disable-transitions>
                        {{ scope.row.status == 1 ? '待处理' : '已处理' }}
                    </el-tag>
                </template>
            </el-table-column>
            <el-table-column prop="update_time" label="处理时间" width="180" sortable />
            <el-table-column prop="admin_name" label="处理人" width="150" sortable />
            <el-table-column prop="suggestion" label="处理建议" width="300" />

            <el-table-column fixed="right" label="操作" width="135">
                <template #default="scope">
                    <el-button type="primary" size="small" @click="edit(scope.row)">查看详情</el-button>
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

        <!-- dialog弹出框 -->
        <el-dialog v-model="dialogVisible" :title="dialogMode" width="40%" draggable>
            <el-scrollbar height="60vh">
                <span>
                    <el-form label-width="100px" :model="editInfo" style="max-width: 460px">
                        <el-form-item label="标题">
                            <el-input v-model="editInfo.title" placeholder="标题" type="textarea"
                                :autosize="{ minRows: 1, maxRows: 4 }" clearable />
                        </el-form-item>
                        <el-form-item label="内容">
                            <el-input v-model="editInfo.content" placeholder="内容" type="textarea"
                                :autosize="{ minRows: 1, maxRows: 4 }" clearable />
                        </el-form-item>
                        <el-form-item label="投诉类型">
                            <el-select class="el-select" v-model="params.feedbackType" placeholder="反馈类型" clearable>
                                <el-option v-for="item in feedbackTypeList" :key="item.id" :label="item.name"
                                    :value="item.name" @click="editInfo.type_id = item.id" />
                            </el-select>
                        </el-form-item>
                        <el-form-item label="备注">
                            <el-input v-model="editInfo.remark" placeholder="备注" type="textarea"
                                :autosize="{ minRows: 1, maxRows: 4 }" clearable />
                        </el-form-item>
                    </el-form>
                </span>
            </el-scrollbar>

            <template #footer>
                <span class="dialog-footer">
                    <el-button @click="dialogVisible = false">取消</el-button>
                    <el-button type="primary" @click="submitUpdate">
                        确认
                    </el-button>
                </span>
            </template>
        </el-dialog>

    </div>
</template>
  
  

<script setup>
import { onMounted, ref } from 'vue';
import { Search, Delete, Download, Plus, Timer, ZoomIn } from '@element-plus/icons-vue'
import { useRoute, useRouter } from 'vue-router';
import request from '@/utils/request'
import { ElMessage } from 'element-plus';

const route = useRoute();
const router = useRouter();

// 分页查询、模糊查询所需要的参数
const params = ref({
    feedbackType: '',
    feedbackTypeId: null,
    feedbackContent: '',
    feedbackStatusName: '',
    feedbackTitle: '',
    feedbackStatus: null,
    userId: null,
    pageNum: 1,
    pageSize: 10
});

onMounted(() => {
    setParams()
    getTypeList()
    getFeedbackList()

})
const setParams = () => {
    const user = JSON.parse(localStorage.getItem("user"))
    params.value.userId = user.id
}

// 获取默认数据
const feedbackTypeList = ref([])
const feedbackStatusList = ref([{ id: 1, name: '待处理' }, { id: 2, name: '已处理' }])
const getTypeList = () => {
    request.get("/feedback/type").then((res) => {
        // console.log(res);
        if (res.code == 200) {
            feedbackTypeList.value = res.data;
        } else {

        }
    })
}
// 获取 公告/反馈
const feedbackList = ref([])
const getFeedbackList = () => {
    if (params.value.feedbackType == '') {
        params.value.feedbackTypeId = null
    }
    if (params.value.feedbackStatusName == '') {
        params.value.feedbackStatus = null
    }


    request.get("/feedback/search", { params: params.value }).then((res) => {
        // console.log('------', res);
        if (res.code == 200) {
            feedbackList.value = res.data.list;
            total.value = res.data.total;
        } else {

        }
    })
}
// 查询
const search = () => {
    console.log(params.value);
}
// 清空
const clear = () => {
    params.value = {
        feedbackType: '',
        feedbackTypeId: null,
        feedbackContent: '',
        feedbackStatusName: '',
        feedbackTitle: '',
        feedbackStatus: null,
        pageNum: 1,
        pageSize: 10
    }
    // 再获取一次数据
}


// dialog相关
const dialogVisible = ref(false);
const dialogMode = ref('');
const editInfo = ref({ status: 0 })
// 编辑
const edit = (item) => {
    dialogVisible.value = true;
    dialogMode.value = '查看';
    // 复制原始对象
    editInfo.value = Object.assign({}, item);

};
// 新增
const add = () => {
    dialogVisible.value = true;
    dialogMode.value = '新增';
    editInfo.value = {};
}
// 删除
const deleteFeedback = (row) => {
    request.delete(`/feedback/${row.id}`).then((res) => {
        if (res.code == 200) {
            ElMessage.success("删除成功！")
            getFeedbackList()
        } else {
            ElMessage.warning(res.msg)
        }
    })
}
// 确认
const submitUpdate = () => {
    if (dialogMode.value == '查看') {
        dialogVisible.value = false;
        return
    } else {
        const userid = JSON.parse(localStorage.getItem('user')).id
        editInfo.value.user_id = userid
        request.post("/feedback", editInfo.value).then((res) => {
            if (res.code == 200) {
                dialogVisible.value = false
                ElMessage.success("添加成功")
                getFeedbackList()
            } else {
                ElMessage.warning("修改失败")
            }
        })
    }
}



// 分页器功能
const total = ref(0);
const pageSizeChange = (pageSize) => {
    params.value.pageSize = pageSize;

}
const pageChange = (pageNum) => {
    params.value.pageNum = pageNum;

}


</script>
<style scoped lang='less'>
.container {
    height: 100%;
    margin: 0 auto;

    .top {
        width: 100%;
        display: flex;
        padding: 5px 20px;
        align-items: center;

        span {
            font-weight: bold;
            color: #7f7f7f;
            margin-right: 10px;
        }

        .searchInput {
            width: 200px;
            margin: 0 10px;
        }

        .el-select {
            margin: 0 10px;
        }
    }

    .pagination {
        width: 90%;
        margin: 10px auto;
    }
}
</style>