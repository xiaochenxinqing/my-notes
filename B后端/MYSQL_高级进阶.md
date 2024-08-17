# MYSQL 高级进阶

**更多详细笔记见：**[https://blog.csdn.net/weixin_47872288/article/details/122111013?spm=1001.2014.3001.5502](https://blog.csdn.net/weixin_47872288/article/details/122111013?spm=1001.2014.3001.5502)

**1my.cnf 配置日志路径**

 log-bin 二进制日志

 log-error 错误日志

 log 查询日志

2.默认数据文件位置： /var/lib/mysql 文件夹 ，其中

.frm文件 存放表结构

.myd文件 存放表数据

.myi文件 存放表索引

 **全值匹配我最爱， 最左前缀要遵守；**

**带头大哥不能死， 中间兄弟不能断；**

**索引列上少计算， 范围之后全失效；**

**LIKE 百分写最右， 覆盖索引不写** *******；**

**不等空值还有 OR， 索引影响要注意；**

**VAR 引号不可丢， SQL 优化有诀窍。**
