<template>
    <div>
        <el-calendar style="width: 500px;height: 500px;" v-model="state.value">
            <template #date-cell="{ data }">
                <div class="el-calendar-day_date-cell date-class">
                    <div><span>{{ data.day.split('-').slice(1).join(' - ') }}</span></div>
                    <el-divider></el-divider>
                    <div :class="comAction.isFestival(data) ? 'festival-holiday' : ''"><span
                            v-html="comAction.solarToLunar(data)"></span></div>
                </div>
            </template>
        </el-calendar>
    </div>
</template>
<script setup>
import { onMounted, onUnmounted, reactive } from "vue";
import calendar from "@/utils/lunarDay";


defineOptions({
    name: 'CusCalendar'
})
const state = reactive({
    value: new Date()
})
const comAction = {
    // 是否节假日
    isFestival(slotData) {
        // console.log(slotData);
        let solarDayArr = slotData.day.split('-');
        let lunarDay = calendar.solar2lunar(solarDayArr[0], solarDayArr[1], solarDayArr[2])

        // 公历节日\农历节日\农历节气
        let festAndTerm = [];
        festAndTerm.push(lunarDay.festival == null ? '' : ' ' + lunarDay.festival)
        festAndTerm.push(lunarDay.lunarFestival == null ? '' : '' + lunarDay.lunarFestival)
        festAndTerm.push(lunarDay.Term == null ? '' : '' + lunarDay.Term)
        festAndTerm = festAndTerm.join('')

        return festAndTerm != ''
    },
    // 公历转农历
    solarToLunar(slotData) {
        // console.log(slotData);
        let solarDayArr = slotData.day.split('-');
        let lunarDay = calendar.solar2lunar(solarDayArr[0], solarDayArr[1], solarDayArr[2])

        // 农历日期
        let lunarMD = lunarDay.IMonthCn + lunarDay.IDayCn

        // 公历节日\农历节日\农历节气
        let festAndTerm = '';
        festAndTerm += (lunarDay.festival == null ? '' : lunarDay.festival + '<br />')
        festAndTerm += (lunarDay.lunarFestival == null ? '' : lunarDay.lunarFestival + '<br />')
        festAndTerm += (lunarDay.Term == null ? '' : lunarDay.Term + '<br />')
        return festAndTerm == '' ? lunarMD : festAndTerm;
    }

}
onMounted(() => { })
onUnmounted(() => { })
</script>
<style scoped lang='less'>
::v-deep(.el-calendar) {
    .el-calendar__header {
        padding: 2px !important;
    }

    .el-calendar__body {
        padding: auto !important;
    }
}

.date-class {
    font-size: 12px;
    text-align: center;
    margin-top: 1px;
    font-family: DS-DIGI-1;
}

::v-deep(.el-calendar-table .el-calendar-day) {
    padding: 2px;
}

.festival-holiday {
    color: #b51313;
}

::v-deep(.el-calendar-table) {
    text-align: center;

    .el-divider {
        margin: 3px 0;
        border-top: 1px#3763c9 var(--el-border-style);
    }
}

</style>
