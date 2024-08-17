# AAA技术突破

**#####后端#####**

**#底层**

反射    注解    泛型  异常throws   设计模式   动态代理    @SuppressWarnings注解  格式化  可变参数  

多线程线程池(Springboot下)    容器对象(在线替换参数？)     ApplicationContext ThreadLocal  

泛型([https://blog.csdn.net/s10461/article/details/53941091](https://blog.csdn.net/s10461/article/details/53941091))

反射([https://blog.csdn.net/sinat_38259539/article/details/71799078](https://blog.csdn.net/sinat_38259539/article/details/71799078)).                                                                                                          

Java自定义注解（[https://blog.csdn.net/bao19901210/article/details/17201173/](https://blog.csdn.net/bao19901210/article/details/17201173/)），

Java8新特性：Lamda表达式,Stream API等数。类加载器

jdk8  stream流的并发处理，自动帮你多线程处理任务

RestfulAPI

webservice（太古老了）

Future

Io和nio     Netty(NIO的后端框架)  和 jetty(Servlet容器类似tomcat)  

easyrules

Apache Camel

**#应用**

缓存技术：Redis+ jedis  Memcache  Ehcache   

# **缓存穿透、缓存击穿、缓存雪崩区别和解决方案**[**https://blog.csdn.net/kongtiao5/article/details/82771694**](https://blog.csdn.net/kongtiao5/article/details/82771694)

Redis深入探究 redisson

    (spring 操作redis[http://www.cnblogs.com/duyinqiang/p/5696309.html](http://www.cnblogs.com/duyinqiang/p/5696309.html))
![.png](image/.png)

模版引擎：freemarker  velocity   thymeleaf

CAS单点登录·

 SpringBoot.   Spingcache缓存  Spring事件 Spring定时任务   （对比quartz任务调度）  spring batch批处理  spring Beanutil

# springOauth2 （授权框架）   SpringSession    Spring ApplicationListener  Dataway 数据接口配置服务

# WebClient

sonar

Springcloud微服务([https://blog.csdn.net/forezp/article/details/70148833](https://blog.csdn.net/forezp/article/details/70148833))   Quarkus框架

Springboot配置消息转换器

数据库：oracle PostgreSQL MongoDB  Nosql  neo4j

   数据库存储过程

   数据库同步工具 canalKettle

 Spring Data JPA      Spring Data REST   jooq   hibernate

MQ消息队列框架，

  -ActiveMQ 

- RabbitMQ：采用Erlang开发，支持完善的AMQP协议 

-(重点) Kaffka：  [https://juejin.im/entry/5bfc9c9c6fb9a049c30aec63?utm_source=gold_browser_extension](https://juejin.im/entry/5bfc9c9c6fb9a049c30aec63?utm_source=gold_browser_extension)

- RocketMQ 

- AvatarMQ：基于Netty的开源分布式消息队列系统。 

  -WebLogic

jetty  

activiti工作流（部署，启动，查询任务，显示流程图，审批。）驳回、会签、转办、中止、挂起等，

Apache Shiro，spring securityMD5加密

Jwt   基于token的身份验证（[https://ninghao.net/blog/2834](https://ninghao.net/blog/2834)）

Druid连接池    

Dozer   ModelMapper（JavaBean映射工具库）

Dubbo分布式服务

lombok（[https://blog.csdn.net/Victor_Cindy1/article/details/72772841](https://blog.csdn.net/Victor_Cindy1/article/details/72772841)，记得使用idea中使用javac编译，还得开启注解设置）

网页分析：jsoup htmlparser

JfreeChart(创建图片的java 工具[https://blog.csdn.net/sinat_38259539/article/details/73330803](https://blog.csdn.net/sinat_38259539/article/details/73330803)) 

marshaller （对象和xml转化）

LDAP！！！！！！！！！

RPC远程调用

minio

testlink

# **Arthas (阿里巴巴java诊断工具)**

监控:zabbix

JSqlParse(sql分析)

Apache tika文档 

**#架构**

分部署部署 负载均衡 高可用

阿里EDAS： [https://www.aliyun.com/product/edas/](https://www.aliyun.com/product/edas/)

flink cdc 数据异构

rpc？grpc？

数据结构和：算法(lintcode)

Java的23种设计模式（单例模式，工厂模式等）

java快速开发框架：jeesite.jeecg jeeplus  bootdo

javaEE高并发处理

tbschedule

quartz任务调度

Elasticsearch和Solr、lucene（全文检索）  

MongoDB、ES、分库分表、读写分离、、Webflux、、WebSocket

shardingsphere  ,  Mycat数据库中间件

Jta分布式锁      TCC分布式事务方案       atomikos     

javafx

乐观锁，悲观锁   自旋锁、阻塞锁、重入锁、偏向锁、轻量锁和重量锁

线程，线程池，

（线程，事务，锁，设计模式。。分布式，集群。。高并发。。。。）

●分布式是从物理资源的角度去将不同的机器组成一个整体对外服务，技术范围非常管且难度非常大，有了这个基础，高并发、高吞吐等系统很容易构建；

● 高并发是从业务角度去描述系统的能力，实现高并发的手段可以采用分布式，也可以采用诸如缓存、CDN等，当然也包括多线程；

● 多线程则聚焦于如何使用编程语言将CPU调度能力最大化。

爬虫技术webmagic

代码检查工具：checkstyle    jacoco

                                   **#######前端#######**

websocket indexedDB

webpack 等模块化构建工具

js高阶函数：map/reduce  Object.keys  filter  forEach  sort

node+es6+webpack+vue+angular+condova

前端框架：easyUI   bootstrap  EasyUI  ExtJS

ThingJS Threejs， htforweb  

跨平台开发：Cordova Flutter Uniapp  Electron

                      **########运维############**

Docker容器技术 （Swarm  k8s(Kubernetes) Mesos      knife4j      Kitematic  Portainer(docker的可视化技术)

五大DevOps工具了解：（Terraform   AnsiblePacker Docker  Kubernetes）

ZooKeepr  分布式中一致性处理的框架

linux’系统监控

nginx反向代理  负载均衡与高可用nginx  nginx解决跨域

GraphicsMagick

Nginx的 http_image_filter_module 模块（图像处理）

JMeter (类比postman)

linux shell编程 权限等

Jekins  teamcity持续集成工具

supervisor

数据库迁移：   kettle DataX

git-hook

**         ####薄弱点巩固#######**

[https://juejin.im/post/5bf4a5de6fb9a04a0f64caca](https://juejin.im/post/5bf4a5de6fb9a04a0f64caca)

[https://juejin.im/post/5b3b870a5188251ac85826b8](https://juejin.im/post/5b3b870a5188251ac85826b8)

[https://blog.csdn.net/cs_hnu_scw/article/details/80181762](https://blog.csdn.net/cs_hnu_scw/article/details/80181762)

[https://juejin.im/post/5bf279b751882532f40fcdda](https://juejin.im/post/5bf279b751882532f40fcdda)

[https://juejin.im/post/5c25ea5d5188254eaa5c5099?utm_source=gold_br](https://juejin.im/post/5c25ea5d5188254eaa5c5099?utm_source=gold_browser_extension)[owser_extension](https://juejin.im/post/5c25ea5d5188254eaa5c5099?utm_source=gold_browser_extension)
