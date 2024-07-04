# 基于Web的房屋租赁系统/平台

Spring Boot、Spring Security、MySQL、Redis、Maven、WebSocket、Vue 3 + JavaScript + Vite、ElementPlus、Echarts、BaiduMap、ThreeJS等

主要实现功能有：权限认证、动态菜单、使用基于用户的协同过滤算法实现 用户-房东 双边推荐、百度地图选点、附近房屋功能、websocket在线咨询功能、支付宝沙箱支付、邮箱验证码、阿里云存储、threeJS全景看房、富文本并预防XSS、Echarts图表等

亮点：租客-房东 双边推荐，试用协同过滤算法实现，可以修改为其它需求，例如 求职者-HR 之间的求职平台等。

## 后端启动

- 项目使用的是JDK8、Maven3.5、MySQL8
- 使用idea打开backend项目，等待maven加载完成
- 导入rms数据库，如果使用的是mysql5.7，导入sql失败的话，自行搜索，好像是这样

```
打开.sql文件 使用notpad++等软件去全局替换:
utf8mb4_0900_ai_ci 替换为 utf8_general_ci
utf8_croatian_ci替换为utf8_general_ci
utf8mb4_general_ci替换为utf8_general_ci
```

- 打开application-dev.yml，修改相应配置，如 邮箱相关配置、阿里云oss相关配置、支付宝沙箱相关配置



## 前端启动

- 前端需要node>=16，建议配置淘宝镜像，或者使用cnpm安装
- npm i
- npm run dev



## 页面截图

![1](images\1.png)

![2](images\2.png)

![3](images\3.png)

![4](images\4.png)

![5](images\5.png)

![6](images\6.png)

![7](images\7.png)

![8](images\8.png)

![9](images\9.png)

![11](images\11.png)

![12](images\12.png)

![13](images\13.png)

![14](images\14.png)

![15](images\15.png)



###### 如有问题，加群617545186咨询。