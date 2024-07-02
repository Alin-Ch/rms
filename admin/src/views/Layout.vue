<template>
    <v-header />
    <v-sidebar />
    <div class="content-box" :class="{ 'content-collapse': sidebar.collapse }">
        <v-tags></v-tags>
        <!-- <elui-china-area-dht isall :leave="3" @change="onChange"></elui-china-area-dht> -->
        <div class="content">
            <router-view v-slot="{ Component }">
                <keep-alive>
                    <component :is="Component" :key="$route.fullPath" />
                </keep-alive>
            </router-view>
            <!-- <router-view v-slot="{ Component }">
                <transition name="move" mode="out-in">
                    <keep-alive :include="tags.nameList">
                        <component :is="Component"></component>
                    </keep-alive>
                </transition>
            </router-view> -->
        </div>
    </div>
</template>
<script setup>
import { useSidebarStore } from '../store/Sidebar';
import { useTagsStore } from '../store/Tags';
import vHeader from '../components/Header.vue';
import vSidebar from '../components/Sidebar.vue';
import vTags from '../components/Tags.vue';

// 参数取值
// import { EluiChinaAreaDht } from 'elui-china-area-dht'
// const chinaData = new EluiChinaAreaDht.ChinaArea().chinaAreaflat
// const onChange = (e) => {
//     const one = chinaData[e[0]]
//     const two = chinaData[e[1]]
//     const three = chinaData[e[2]]
//     console.log(one, two, three)
// }

const sidebar = useSidebarStore();
const tags = useTagsStore();
</script>