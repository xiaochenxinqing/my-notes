# cmd中mvn命令，出现No compiler is provided in this environment. Perhaps you are running

# **cmd中mvn命令，出现No compiler is provided in this environment. Perhaps you are running on a JRE rather than a JDK?**

# 在cmd里执行mvn命令，出错

![.png](image/.png)

# 查看mvn -v

![-1.png](image/-1.png)

# 发现mvn运行在jre上，更改高级设置。我的电脑--》属性--》高级系统设置--》环境变量

![-2.png](image/-2.png)

![-3.png](image/-3.png)

# 更改完之后，再次查看 mvn -v

![-4.png](image/-4.png)

# 搞定！！！！！！！！！！！！！！！！！！！！
