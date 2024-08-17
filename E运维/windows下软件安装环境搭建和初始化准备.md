# windows下软件安装环境搭建和初始化准备

————————————————————————软件安装和初始化准备——————————————

JAVA：  jdk路径加入path变量，分号隔开

MyEclipse ： 装好激活后，配置jdk：window --> preferences—>Java --> Installed JREs->add,添加jdk路径后打对勾

     windows-preference -genneral -worlspace 设置编码为utf-8;

       设置jsp文件默认字符集：window-Preferences-myeclipse-files and editors—Jsp，找到encoding，设置utf-8。

mysql ：傻瓜式安装，安装时注意选择默认字符集为Utf-8；

SQLyog ：无一般注意事项。

tomcat： 解压缩版：解压后添加环境变量，名称为：CATALINA_HOME,值为tomcat的安装目录

                 通过bin文件夹里的shutdown.bat和startup.bat启停服务。

       安装版： 傻瓜式安装。 通过自带工具启停服务。

       初始化配置：

       1每次修改完servlet，不用重启tomcat的方法：

          在tomcat中打开conf文件，找到context.xml文件，打开文件，找到<Context>标签，

      将标签修改为

```
<Context reloadable="true">
```

然后重启tomcat

        2永久解决get方法提交乱码：找到tomcat/conf/server.xml 在connecter标签中添加

     

```
<connecter.............. URIEncoding="UTF-8">
```

然后重启tomcat

严重: Parse error in application web.xml file at jndi:/localhost/ipws/WEB-INF/web.xml java.lang.NoSuchMethodException: org.apache.catalina.deploy.WebXml

在tomcat 配置文件context.xml中添加

```
<Loader delegate="true" />
```

即可。

    3在myeclipse10中配置tomcat

     首先设置jsp文件默认字符集：window-Preferences-myeclipse-files and editors—Jsp，找到encoding，设置。

     然后进行Tomcat配置：window-Preferences-xxxxx-servers-Tomcat-Tomcat7.x，选择enable按钮，

     tomcat home directory，单击browse找到Tomcat安装目录。

     然后再Tomcat7.x下的JDK选项单击add按钮，添加jdk 的安装路径。

————————————————————————Eclipse中开始一个javaweb项目——————————————————————

1。建立项目，并右键-properties设置项目编码为“utf-8”，并完成Tomcat部署；

2。设计数据库，同样设置其编码为“utf-8”;

3。导入数据库连接jar包 （右键项目的webroot/web-inf/lib 导入）(可以同时导入fastjson的jar包。注意src和webroot/lib都要导入)；

4。建立数据库连接（jndi方式：把写好的context.xml文件放入项目的meta-inf文件夹下）（同时注意编码）;

5。分层（数据库连接层，业务逻辑层，表示层）实现项目功能；
