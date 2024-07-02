<template>
    <div>
        <el-tabs v-model="activeName">
            <el-tab-pane label="房屋管理" name="first">
                <div class="container">
                    <!-- 表格顶部搜索 -->
                    <div class="handle-box">
                        <el-input v-model="params.name" placeholder="房屋名称" class="handle-input mr10"></el-input>
                        <el-button type="primary" :icon="Search" @click="handleSearch">搜索</el-button>
                        <el-button type="primary" :icon="Plus" @click="handleAdd">新增</el-button>
                        <el-button type="danger" :icon="Delete" @click="handleDelete">批量删除</el-button>
                        <el-button type="primary" :icon="Download" @click="exportExcelTemplate">下载模板</el-button>
                        <el-upload action="#" :limit="1" accept=".xlsx, .xls" :show-file-list="false"
                            :before-upload="beforeUpload" :http-request="handleMany" style="margin: 0 12px;">
                            <el-button type="primary" :icon="Download" @click="importExcel">导入Excel</el-button>
                        </el-upload>
                        <el-button v-if="isImport" type="info" :icon="RefreshLeft"
                            @click="cancelImport">取消导入</el-button>
                        <el-button v-if="isImport" type="success" :icon="Check" @click="confirmImport">确定导入</el-button>
                    </div>
                    <!-- 表格部分 -->
                    <el-table :data="tableData" border class="table" ref="multipleTable"
                        header-cell-class-name="table-header" @selection-change="handleSelectionChange">
                        <el-table-column type="selection" width="55" align="center" />
                        <el-table-column label="展示(查看大图)" align="center" width="120">
                            <template #default="scope">
                                <el-image class="table-td-thumb" fit="cover"
                                    :src="scope.row.list && scope.row.list.length > 0 && scope.row.list[0].url ? scope.row.list[0].url : ''"
                                    :preview-src-list="scope.row.list && scope.row.list.length > 0 ? scope.row.list.map(item => item.url || '').filter(url => url) : []"
                                    preview-teleported>
                                </el-image>
                            </template>
                        </el-table-column>
                        <el-table-column prop="name" label="名称" width="150"></el-table-column>
                        <el-table-column prop="area" label="房屋面积" width="100">
                            <template #default="scope">
                                {{ scope.row.area ? scope.row.area + '㎡' : "空" }}
                            </template>
                        </el-table-column>
                        <el-table-column prop="description" label="描述" show-overflow-tooltip
                            width="300"></el-table-column>
                        <el-table-column prop="location" label="房屋地址" show-overflow-tooltip width="300">
                            <template #default="scope">
                                {{ scope.row.location ? scope.row.location : "" }}
                                {{ scope.row.address ? scope.row.address : "" }}
                            </template>
                        </el-table-column>
                        <el-table-column prop="price" label="月租金" width="120">
                            <template #default="scope">￥{{ scope.row.price }} / 月</template>
                        </el-table-column>
                        <el-table-column prop="owner.username" label="房东" width="120"></el-table-column>
                        <el-table-column prop="user.username" label="租户" width="120"></el-table-column>
                        <el-table-column prop="status" label="状态" width="100">
                            <template #default="scope">
                                <el-tag v-if="scope.row.status == 0" type="warning">未出租</el-tag>
                                <el-tag v-if="scope.row.status == 1" type="success">已出租</el-tag>
                                <el-tag v-if="scope.row.status == 2" type="danger">已下架</el-tag>
                            </template>
                        </el-table-column>
                        <el-table-column prop="createTime" label="创建时间" min-width="160" sortable></el-table-column>
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
                    <div v-if="!isImport" class="pagination">
                        <el-pagination @size-change="pageSizeChange" @current-change="pageChange"
                            :current-page="params.current" :page-sizes="[5, 10, 15, 20]" :page-size="params.size"
                            layout="total, sizes, prev, pager, next, jumper" :total="total">
                        </el-pagination>
                    </div>
                </div>
                <!-- dialog弹出框 -->
                <el-dialog v-model="dialogVisible" :title="dialogMode" width="60%" :before-close="handleCancel">
                    <el-form label-width="100px" :model="editInfo" style="max-width: 100%">
                        <!-- 图片部分，有些长 -->
                        <el-form-item label="展示">
                            <!-- 上传与预览 -->
                            <el-upload v-model:file-list="fileList" :action="uploadUrl" list-type="picture-card"
                                :on-preview="handlePicturePreview" :limit="5" :on-remove="handleRemove"
                                :on-success="successUpload">
                                <el-icon>
                                    <Plus />
                                </el-icon>
                            </el-upload>
                            <!-- 图片预览 -->
                            <el-dialog class="previewImg" v-model="imageVisible">
                                <img w-full :src="dialogImageUrl" alt="预览图片" />
                            </el-dialog>
                        </el-form-item>
                        <el-form-item label="视频">
                            <!-- 上传视频功能 -->
                            <el-upload ref="uploadVideo" :action="uploadUrl" :limit="2" :on-remove="vhandleRemove"
                                :on-success="successUpload">
                                <template #trigger>
                                    <el-button type="primary">上传视频</el-button>
                                </template>
                                <template #tip>
                                    <div class="el-upload__tip text-red">
                                        仅限上传一个视频，后上传的将会覆盖前一个
                                    </div>
                                </template>
                            </el-upload>
                            <!-- 视频预览功能 -->
                            <div v-if="videoList.length > 0">
                                <div v-for="(item, index) in videoList" :key="index">
                                    <video :src="item.url" controls width="300" height="200"></video>
                                </div>
                            </div>
                        </el-form-item>
                        <el-form-item label="房屋名称">
                            <el-input v-model="editInfo.name" />
                        </el-form-item>
                        <el-form-item label="房屋类型">
                            <el-select v-model="editInfo.typeId" placeholder="房屋类型">
                                <el-option v-for="item in typeList" :label="item.name" :value="item.id" />
                                <!-- <el-option label="住宅小区" value="1790306095649193985" />
                                <el-option label="长租公寓" value="1790306950553161730" />
                                <el-option label="独栋" value="1790307052848041985" />
                                <el-option label="公寓式酒店" value="1790307154408919042" />
                                <el-option label="复式公寓" value="1790307229117861889" />
                                <el-option label="Loft" value="1790307291013206018" />
                                <el-option label="共享房屋" value="1790307346566762498" />
                                <el-option label="学生公寓" value="1790307387427672065" /> -->
                            </el-select>
                        </el-form-item>
                        <el-form-item label="面积大小">
                            <el-input v-model="editInfo.area" />
                        </el-form-item>
                        <el-form-item label="房屋描述">
                            <el-input v-model="editInfo.description" />
                        </el-form-item>
                        <el-form-item label="所处城市">
                            <elui-china-area-dht @change="areaChange" v-model="showVal"
                                style="width: 300px;"></elui-china-area-dht>
                        </el-form-item>
                        <el-form-item label="详细地址">
                            <el-input v-model="editInfo.address" />
                        </el-form-item>
                        <el-form-item label="地图选点">
                            <div style="height: 350px;width:100%;" v-if="dialogVisible">
                                <BaiduMap :longitude="longitude" :latitude="latitude"
                                    @update:location="updateLocation" />
                            </div>
                        </el-form-item>
                        <el-form-item label="月租金">
                            <el-input style="width: 215px;" v-model="editInfo.price"
                                :formatter="(value) => `￥ ${value}`.replace(/\B(?=(\d{3})+(?!\d))/g, ',')"
                                :parser="(value) => value.replace(/\￥\s?|(,*)/g, '')" />
                        </el-form-item>
                        <el-form-item label="房东">
                            <el-select v-model="editInfo.ownername" placeholder="房东" filterable remote reserve-keyword
                                :remote-method="remoteMethod" :loading="loading" remote-show-suffix class="elselect">
                                <el-option v-for="item in showUserList" :key="item.value" :label="item.label"
                                    :value="item.value" @click="getOwnerId(item)" />
                            </el-select>
                        </el-form-item>
                        <el-form-item label="租户">
                            <el-select v-model="editInfo.username" placeholder="租户" filterable remote reserve-keyword
                                :remote-method="remoteMethod" :loading="loading" remote-show-suffix clearable
                                class="elselect" @clear="clearUserId">
                                <el-option v-for="item in showUserList" :key="item.value" :label="item.label"
                                    :value="item.value" @click="getUserId(item)" />
                            </el-select>
                        </el-form-item>
                        <el-form-item label="房屋状态">
                            <el-select v-model="editInfo.status" placeholder="房屋状态">
                                <el-option label="未出租" :value="0" />
                                <el-option label="已出租" :value="1" />
                                <el-option label="已下架" :value="2" />
                            </el-select>
                        </el-form-item>
                        <el-form-item label="宝贝详情">
                            <!-- 将 editInfo.content 通过 prop 传递给子组件 -->
                            <TextEditor v-if="dialogVisible" v-model="editInfo.detail" />
                        </el-form-item>
                    </el-form>
                    <template #footer>
                        <span class="dialog-footer">
                            <el-button @click="handleCancel">取消</el-button>
                            <el-button type="primary" @click="handleSubmit">
                                确认
                            </el-button>
                        </span>
                    </template>
                </el-dialog>
            </el-tab-pane>
            <el-tab-pane label="房屋类型管理" name="second">
                <div class="top">
                    <el-button style="margin-left: 0;" type="primary" size="default" @click="addType">新增</el-button>
                </div>
                <!-- 表格 -->
                <el-table :data="typeList" border style="width: 100%">
                    <el-table-column prop="id" label="id" width="200" />
                    <el-table-column prop="name" label="类型" width="180" />
                    <el-table-column prop="description" label="描述" />
                    <el-table-column fixed="right" label="操作" width="135">
                        <template v-slot="scope" #default>
                            <el-button type="primary" size="small" @click="editType(scope.row)">编辑</el-button>
                            <el-popconfirm title="确认删除?" @confirm="deleteType(scope.row)" confirm-button-text="确认"
                                cancel-button-text="取消">
                                <template #reference>
                                    <el-button type="danger" size="small">删除</el-button>
                                </template>
                            </el-popconfirm>
                        </template>
                    </el-table-column>
                </el-table>
                <!-- 抽屉 -->
                <el-drawer size="800" v-model="drawer" direction="rtl">
                    <template #header>
                        <h4>{{ drawerTitle }}</h4>
                    </template>
                    <template #default>
                        <div>
                            <el-form label-position="top" label-width="100px" :model="editTypeInfo"
                                style="max-width: 800px">
                                <el-form-item label="类型名称">
                                    <el-input v-model="editTypeInfo.name" />
                                </el-form-item>
                                <el-form-item label="类型描述">
                                    <el-input v-model="editTypeInfo.description" />
                                </el-form-item>
                            </el-form>
                        </div>
                    </template>
                    <template #footer>
                        <div style="flex: auto">
                            <el-button @click="cancelClick">取消</el-button>
                            <el-button type="primary" @click="confirmClick">确定</el-button>
                        </div>
                    </template>
                </el-drawer>
            </el-tab-pane>
        </el-tabs>
    </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue';
import { ElMessage, ElMessageBox, genFileId, ElLoading } from 'element-plus';
import { Delete, Edit, Search, Plus, Download, Upload, Check, RefreshLeft } from '@element-plus/icons-vue';
import request from '@/utils/request';
import { uploadUrl } from '@/utils/request';
import TextEditor from '@/views/Layout/TextEditor.vue'
// Excel导入导出
import * as XLSX from 'xlsx';
const exportExcelTemplate = () => {
    // 模板文件路径（相对于当前页面）
    const templatePath = '/template.xlsx';
    // 创建一个链接元素
    const link = document.createElement('a');
    link.href = templatePath;
    link.download = 'template.xlsx'; // 设置下载文件的文件名
    // 触发点击事件下载文件
    document.body.appendChild(link);
    link.click();
    // 下载完成后移除链接元素
    document.body.removeChild(link);
}
const importExcel = () => { }
const importList = ref([]);
const isImport = ref(false)
const beforeUpload = async (rawFile) => {
    importList.value = await analysisExcel(rawFile);
    return true;
};
const analysisExcel = (file) => {
    return new Promise(function (resolve, reject) {
        const reader = new FileReader();
        reader.onload = function (e) {
            const data = e.target.result;
            let datajson = XLSX.read(data, {
                type: 'binary',
            });

            const sheetName = datajson.SheetNames[0];
            const result = XLSX.utils.sheet_to_json(datajson.Sheets[sheetName]);
            resolve(result);
        };
        // reader.readAsBinaryString(file);
        reader.readAsArrayBuffer(file);
    });
};
const handleMany = async () => {
    const list = importList.value.map((item, index) => {
        return {
            name: item['名称'],
            area: item['房屋面积'],
            description: item['描述'],
            location: item['房屋地址'],
            price: item['月租金'],
        };
    });
    // tableData.value.push(...list);
    isImport.value = true
    total.value = list.length
    tableData.value = list
};
const cancelImport = () => {
    isImport.value = false
    getData()
}
const confirmImport = async () => {
    isImport.value = false;
    for (let item of tableData.value) {
        try {
            await request.post("/sys/house/save", item);
            ElMessage.success('添加成功');
        } catch (error) {
            ElMessage.error('添加失败');
            console.error(error);
        }
    }
    getData()
}

// 百度地图组件
import BaiduMap from '@/components/BaiduMap.vue'
const longitude = ref(116.404);
const latitude = ref(39.915); // 初始化地图中心点
const updateLocation = (newLocation) => {
    editInfo.value.jingdu = newLocation.longitude;
    editInfo.value.weidu = newLocation.latitude;
};
// 腾讯地图组件
import TencentMap from '@/components/TencentMap.vue';

// 级联选择城市
import { EluiChinaAreaDht } from 'elui-china-area-dht'
const chinaData = new EluiChinaAreaDht.ChinaArea().chinaAreaflat
const showVal = ref([])
const areaChange = (e) => {
    const one = chinaData[e[0]]
    const two = chinaData[e[1]]
    const three = chinaData[e[2]]
    editInfo.value.cityCodeOne = one.value
    editInfo.value.cityCodeTwo = two.value
    editInfo.value.cityCodeThree = three.value
    editInfo.value.location = one.label + two.label + three.label
}

onMounted(() => {
    getData()
    getAllUser()
    getTypeList()
})

const activeName = ref('first') // Tabs标签
// 分页查询、模糊查询所需要的参数
const params = ref({
    name: '',
    current: 1,
    size: 10,
})
const tableData = ref([]);
const total = ref(0);
const dialogVisible = ref(false);
// 获取表格数据
const getData = () => {
    request.get('/sys/house/list', { params: params.value }).then((res) => {
        console.log(res.data.records);
        if (res.code == 200) {
            total.value = res.data.total;
            tableData.value = res.data.records;
        } else {
            ElMessage.warning(res.msg);
        }
    }).catch((err) => {
        ElMessage.warning(err);
    })
}

const loading = ref(false)
const showUserList = ref([])
const userList = ref([])
const remoteMethod = (query) => {
    // console.log("query", query, "  -----------  ", userList.value);
    loading.value = true
    setTimeout(() => {
        loading.value = false
        showUserList.value = userList.value.filter((item) => {
            return item.label.includes(query)
        })
    }, 200)
}
const getAllUser = () => {
    request.get('/sys/user/info/list').then((res) => {
        if (res.code == 200) {
            userList.value = res.data.map((item) => {
                return { value: `${item.username}`, label: `${item.username}-${item.phone}`, id: item.id }
            })
        } else {
            ElMessage.warning(res.msg);
        }
    }).catch((err) => {
        ElMessage.error(err);
    })
}
const getOwnerId = (item) => {
    editInfo.value.ownerId = item.id
}
const getUserId = (item) => {
    editInfo.value.userId = item.id
}
const clearUserId = () => {
    editInfo.value.userId = null
}

// 查询操作
const handleSearch = () => {
    params.value.pageNum = 1;
    getData();
}

// 编辑或者新增
const dialogMode = ref('新增');
const editInfo = ref({})
const handleEdit = (row) => {
    dialogMode.value = '编辑';
    const originInfo = { ...row }; // 创建 row 的副本
    dialogVisible.value = true;
    editInfo.value = originInfo;
    // 使用或语法赋值，如果属性存在则赋值，否则为空字符串
    editInfo.value.ownername = (row.owner && row.owner.username) ? row.owner.username : "";
    editInfo.value.username = (row.user && row.user.username) ? row.user.username : "";
    showVal.value.push(editInfo.value.cityCodeOne)
    showVal.value.push(editInfo.value.cityCodeTwo)
    showVal.value.push(editInfo.value.cityCodeThree)
    // console.log(showVal.value);
    if (row.list.length > 0) {
        fileList.value = row.list
        // console.log("fileList：", fileList.value);
    }
    if (row.videoList.length > 0) {
        videoList.value = row.videoList
        // console.log("videoList：", videoList.value);
    }
    // 将地图坐标转换成number
    longitude.value = Number(row.jingdu);
    latitude.value = Number(row.weidu);
}
const handleAdd = () => {
    dialogMode.value = '新增';
    dialogVisible.value = true;
    editInfo.value = {};
    fileList.value = [];
    editInfo.value.videoList = []
}
const handleCancel = () => {
    dialogVisible.value = false;
    editInfo.value = {};
    fileList.value = [];
    videoList.value = [];
    delList.value = [];
    addList.value = [];
    vdelList.value = [];
    vaddList.value = [];
    // 视频的上传需要清空
    if (uploadVideo.value) {
        uploadVideo.value.clearFiles()
    }
    // 地址级联选择需要清空
    showVal.value = [];
}
const handleSubmit = () => {
    // editInfo.value.list = [...fileList.value, ...videoList.value];
    editInfo.value.addList = addList.value;
    editInfo.value.delList = delList.value;
    editInfo.value.vaddList = vaddList.value;
    editInfo.value.vdelList = vdelList.value;
    const city = editInfo.value.location
    // editInfo.value.location = city + editInfo.value.address
    // console.log("editInfo：", editInfo.value);
    if (dialogMode.value == '新增') {
        request.post("/sys/house/save", editInfo.value).then((res) => {
            if (res.code == 200) {
                ElMessage.success('新增成功!');
                getData();
                handleCancel();
            } else {
                ElMessage.warning(res.msg);
            }
        })
    } else {
        request.post("/sys/house/update", editInfo.value).then((res) => {
            if (res.code == 200) {
                ElMessage.success(`修改成功!`);
                getData();
                handleCancel();
            } else {
                ElMessage.warning(res.msg);
            }
        })
    }

}
// Upload部分（上传与预览）
const imageVisible = ref(false)
const dialogImageUrl = ref('')
const fileList = ref([])
const videoList = ref([])
const addList = ref([])
const delList = ref([])
const vaddList = ref([])
const vdelList = ref([])
const handleRemove = (file) => {
    const index = fileList.value.indexOf(file);
    if (index !== -1) {
        fileList.value.splice(index, 1);
    }
    // 删除图片
    delList.value.push(file)
}
const handlePicturePreview = (file) => {
    dialogImageUrl.value = file.url
    imageVisible.value = true
}
// 上传成功
const successUpload = (res) => {
    console.log(res);
    const fileExtension = res.data.substring(res.data.lastIndexOf('.') + 1).toLowerCase(); // 获取文件后缀并转换为小写

    if (fileExtension === 'jpg' || fileExtension === 'jpeg' || fileExtension === 'png' || fileExtension === 'gif' || fileExtension === 'webp') {
        // 如果是图片后缀，将其添加到fileList中
        const newFile = {
            houseId: editInfo.value.id,
            url: res.data,
            name: res.data
        };
        // fileList.value.push(newFile)
        addList.value.push(newFile)
    } else if (fileExtension === 'mp4' || fileExtension === 'avi' || fileExtension === 'mov' || fileExtension === 'wmv') {
        // 如果是视频后缀，将其添加到videoList中
        const newVideo = {
            houseId: editInfo.value.id,
            url: res.data,
            name: res.data
        };
        vaddList.value.push(newVideo)
        editInfo.value.videoList.length > 0 && vdelList.value.push(editInfo.value.videoList[0]);
        videoList.value = [newVideo]
        // videoList.value.push(newVideo);
    } else {
        // 其他类型的文件处理方式，这里可以根据需要进行调整
        console.log('Unsupported file type.');
    }
}
// 视频的Upload
const uploadVideo = ref()
const vhandleRemove = (file) => {
    // console.log(file);
    const index = videoList.value.indexOf(file);
    if (index !== -1) {
        videoList.value.splice(index, 1);
    }
    // 删除视频
    vdelList.value.push(file)
    videoList.value.pop(file)
}


// 批量删除
const multipleSelection = ref([])
const handleSelectionChange = (val) => {
    multipleSelection.value = val
}
const handleDelete = (row) => {
    console.log(row);
    var ids = [];
    if (multipleSelection.value.length == 1) {
        ids.push(multipleSelection.value[0].id);
    } else {
        multipleSelection.value.forEach((item) => {
            ids.push(item.id);
        });
    }
    if (row.id) {
        ids.push(row.id);
    }
    if (ids.length == 0) {
        ElMessage.warning("请选择要删除的数据!");
        return;
    }
    ElMessageBox.confirm("确定要删除吗？", "提示", { type: "warning", })
        .then(() => {
            // console.log(ids);
            request.post("/sys/house/delete", ids).then((res) => {
                if (res.code == 200) {
                    ElMessage.success("删除成功!");
                    getData();
                    handleCancel();
                }
            });
        }).catch(() => {
            ElMessage.error("删除失败!");
        });
}
// const handleDelete = (row) => {
//     // 二次确认删除
//     ElMessageBox.confirm('确定要删除吗？', '提示', {
//         type: 'warning'
//     }).then(() => {
//         request.post("/sys/house/delete", [row.id]).then((res) => {
//             if (res.code == 200) {
//                 ElMessage.success('删除成功!');
//                 getData();
//             } else {
//                 ElMessage.warning(res.msg);
//             }
//         })
//     }).catch(() => { });
// }
// 分页器功能
const pageSizeChange = (pageSize) => {
    params.value.size = pageSize;
    getData();
}
const pageChange = (pageNum) => {
    params.value.current = pageNum;
    getData();
}




// 类型相关
const typeList = ref([])
const getTypeList = () => {
    request.get("/sys/house/type/list").then((res) => {
        // console.log(res);
        if (res.code == 200) {
            typeList.value = res.data
        } else {
            ElMessage.warning(res.msg)
        }
    })
}
const drawer = ref(false)
const editTypeInfo = ref({})
const drawerTitle = ref('')
const cancelClick = () => {
    drawer.value = false
}
const addType = () => {
    drawer.value = true
    drawerTitle.value = '新增'
    editTypeInfo.value = {}
}
const editType = (row) => {
    const originObject = JSON.parse(JSON.stringify(row)); // 创建 row 的深拷贝副本
    editTypeInfo.value = originObject;
    drawer.value = true
    drawerTitle.value = '编辑'
}
const confirmClick = () => {
    if (drawerTitle.value == '新增') {
        request.post("/sys/house/type/save", editTypeInfo.value).then((res) => {
            // console.log(res);
            if (res.code == 200) {
                getTypeList()
                ElMessage.success('添加成功')
                drawer.value = false
            } else {
                ElMessage.warning('添加失败')
            }
        })
    } else if (drawerTitle.value == '编辑') {
        request.post("/sys/house/type/update", editTypeInfo.value).then((res) => {
            // console.log(res);
            if (res.code == 200) {
                getTypeList()
                ElMessage.success('添加成功')
                drawer.value = false
            } else {
                ElMessage.warning('添加失败')
            }
        })
    }

}
const deleteType = (row) => {
    request.post("/sys/house/type/delete", [row.id]).then((res) => {
        if (res.code == 200) {
            ElMessage.success('删除成功!');
            getTypeList();
        } else {
            ElMessage.warning(res.msg);
        }
    })
}

</script>

<style scoped>
.container {
    width: 95%;
    height: 100%;
    margin: -5px;
}

.handle-box {
    margin-bottom: 20px;
    display: flex;
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

.elselect .el-select-dropdown {
    max-width: 100px;
    /* 设置下拉框的最大宽度为 300 像素 */
    /* width: auto !important; */
    /* 让下拉框能够自适应宽度 */
}
</style>