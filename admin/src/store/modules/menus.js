// menus.js  

export default {
  namespaced: true, // 声明这是一个命名空间模块  
  state: () => ({
    menuList: [],
    permList: [],
    hasRoutes: false,
    editableTabsValue: 'Dashboard',
    editableTabs: [{
      title: '首页',
      name: 'Dashboard',
    },],
  }),
  mutations: {
    setMenuList(state, menus) {
      state.menuList = menus;
    },
    setPerList(state, perms) {
      state.permList = perms;
    },
    changeRouteState(state, hasRoute) {
      state.hasRoutes = hasRoute;
    },
    addTab(state, tab) {
      const index = state.editableTabs.findIndex(e => e.name === tab.name);
      if (index === -1) {
        state.editableTabs.push({
          title: tab.title,
          name: tab.name,
        });
      }
      state.editableTabsValue = tab.name;
    },
    resetState(state) {
      state.menuList = [];
      state.permList = [];
      state.hasRoutes = false;
      state.editableTabsValue = 'Index';
      state.editableTabs = [{
        title: '首页',
        name: 'Index',
      },];
    },
    clearMenuList(state) {
      state.menuList = [];
    },
  },
  getters: {
    hasRole: (state) => (role) => {
      // 检查 permList 中是否包含指定角色
      return state.permList.includes(role);
    },
    hasThisRoute: (state) => (route) => {
      console.log(route);
      console.log(state.menuList);
      // 递归函数，用于检查数组和子数组  
      function checkRoutes(menuList) {  
        for (let i = 0; i < menuList.length; i++) {
          const currentRoute = menuList[i]
          if (!currentRoute.path) {
            continue
          }
          // 如果当前路由匹配  
          if (currentRoute.path == route.path || currentRoute.name == route.name) {  
            console.log("当前路由匹配 ");
            return true; // 找到了，返回true  
          }  
          // 如果当前路由有子路由，递归检查子路由  
          if (currentRoute.children && Array.isArray(currentRoute.children)) {  
            if (checkRoutes(currentRoute.children)) {  
              console.log("子路由匹配");
              return true; // 在子路由中找到了，返回true  
            }  
          }  
        } 
        // 遍历完所有路由都没有找到  
        return false;  
      }  
      // 调用递归函数，检查menuList  
      return checkRoutes(state.menuList);  
    },
  },
  actions: {
    // 在这里定义你的 actions  
  },
};