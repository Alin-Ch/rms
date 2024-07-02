<template>
    <el-tabs v-model="editableTabsValue" type="card" closable @tab-remove="removeTab" @tab-click="clickTab">
        <el-tab-pane v-for="(item) in editableTabs" :key="item.name" :label="item.title" :name="item.name">

        </el-tab-pane>
    </el-tabs>
</template>

<script>
export default {
    name: 'Tabs',
    data() {
        return {
            // 默认Index
            // editableTabsValue: this.$store.state.menus.editableTabsValue,
            // editableTabs: this.$store.state.menus.editableTabs,
        }
    },
    // 动态监控Tab的变化
    computed: {
        // 获取Tab数据
        editableTabs: {
            get() {
                return this.$store.state.menus.editableTabs
            },
            set(val) {
                this.$store.state.menus.editableTabs = val
            }
        },
        // 当前被激活的标签
        editableTabsValue: {
            get() {
                return this.$store.state.menus.editableTabsValue
            },
            set(val) {
                this.$store.state.menus.editableTabsValue = val
            }
        }
    },
    methods: {
        // 删除标签
        // 删除标签时，需要判断是否是当前激活的标签，如果是，则需要将激活的标签切换到前一个标签
        // 如果不是当前激活的标签，则不需要做任何操作
        removeTab(targetName) {
            let tabs = this.editableTabs;
            let activeName = this.editableTabsValue;

            // 首页不能删除
            if (targetName === 'Index') {
                return;
            }

            if (activeName === targetName) {
                tabs.forEach((tab, index) => {
                    if (tab.name === targetName) {
                        let nextTab = tabs[index + 1] || tabs[index - 1];
                        if (nextTab) {
                            activeName = nextTab.name;
                        }
                    }
                });
            }

            // 检查当前路由名是否与要跳转的路由名相同，如果相同则不执行跳转
            if (this.$route.name !== activeName) {
                this.editableTabsValue = activeName;
                this.$router.push({ name: activeName })
            }

            this.editableTabs = tabs.filter(tab => tab.name !== targetName);
        },
        // 点击标签时push到对应的路由
        clickTab(target) {
            this.$router.push({ name: target.name })
        }
    }
}
</script>

<style></style>