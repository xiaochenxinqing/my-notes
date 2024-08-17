# Linux(centOs6.x)软件安装配置过程

Linux(centOs6.x)软件安装配置过程

————————————————————————JDK————————————————————————————————

tar -xvf xxxxxx.tar.gz -C 安装文件夹

安装完成后 vim  /etc/profile 插入如下代码后保存退出

export JAVA_HOME=/usr/local/jdk1.8.0_161

export PATH=$JAVA_HOME/bin:$PATH

export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

然后使其生效

source /etc/profile

检查版本，若显示则证明配置环境变量成功

java -version

————————————————————————tomcat————————————————————————

1、解压（若免安装版无需解压）

tar -xvf apache-tomcat-7.0.39.tar.gz -C /usr/local/

2开启8080端口

iptables -A INPUT -p tcp --dport 8080 -j ACCEPT

service iptables save

service iptables restart

3增加权限后启动

[root@localhost bin]# chmod u+x *.sh  

[root@localhost bin]# ./startup.sh

tips:

         1每次修改完servlet，不用重启tomcat的方法：

          在tomcat中打开conf文件，找到context.xml文件，打开文件，找到<Context>标签，

      将标签修改为<Context reloadable="true">然后重启tomcat

        2永久解决get方法提交乱码：找到tomcat/conf/server.xml 在connecter标签中添加

      <connecter.............. URIEncoding="UTF-8">然后重启tomcat

    jvm配置：将D:\Program File\tomcat8\bin中的service.bat文件的JvmMs值改为256，JvmMx的值改为512；

严重: Parse error in application web.xml file at jndi:/localhost/ipws/WEB-INF/web.xml java.lang.NoSuchMethodException: org.apache.catalina.deploy.WebXml

在tomcat 配置文件context.xml中添加<Loader delegate="true" />即可(注意有可能造成扫描规则的改变,通配符不能用！！！！慎用)

—————————————————————————MYSQL(centos6    5.7版本安装)—————————————————————————

注意 ！！！！！！！！！！！！！！！！！！！ centos看这里  [https://blog.csdn.net/ltx06/article/details/78052359](https://blog.csdn.net/ltx06/article/details/78052359)

1检查之前是否有mysql安装

rpm -qa|grep mysql

2强制卸载旧版本

rpm -e mysql-libs-5.1.71-1.el6.x86_64    --nodeps  （注意是--两道杠）

3建立mysql文件夹（根据需要）

[root@localhost local]# mkdir mysql

4解压tar文件至建立的mysql文件夹

[root@localhost local]# tar -xvf MySQL-5.x.xx-1.linux2.6.x86_64.rpm-bundle.tar  -C  /usr/local/mysql

5查看解压后目录文件

ls -l mysql

6安装mysql服务器端和客户端

    rpm -ivh  mysql-community-common-5.7.9-1.el7.x86_64.rpm

    rpm -ivh  mysql-community-libs-5.7.9-1.el7.x86_64.rpm             --（依赖于common）

    rpm -ivh  mysql-community-client-5.7.9-1.el7.x86_64.rpm          --（依赖于libs）

    rpm -ivh  mysql-community-server-5.7.9-1.el7.x86_64.rpm         --（依赖于client、common）

注意：若出现 file /usr/share/mysql/ukrainian/errmsg.sys from install of MySQL-server-5.5.24-1.linux2.6.x86_64 conflicts with file from package mysql-libs-5.1.61-1.el6_2.1.x86_64或者**mariadb-libs**

原因是系统已经安装了其他版本的mysql-libs包导致不兼容。

yum list | grep mysql

yum remove mysql-libs

# 

8生成初始随机密码

mysqld --initialize                         //新版的推荐此方法，执行生会在/var/log/mysqld.log生成随机密码

9更改mysql文件夹的权限（很重要，否则启动不了）

    chmod -R 777  /var/lib/mysql

10启动mysql

    service mysqld  start

11链接mysql

    mysql -u root -p  

12修改密码

      

       ALTER USER 'root'@'localhost' IDENTIFIED BY '新密码';

13显示数据库

    show databases;

14退出

    exit;

15修改配置文件

    vim /etc/my.cnf

[mysqld]

character_set_server=utf8mb4

init_connect='set names utf8mb4'

lower_case_table_names=1

max_allowed_packet = 100M

sql_mode=STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION

解释 ：

   字符集

    忽略字段大小写

    groupby问题：this is incompatible with sql_mode=only_full_group_by

    最大字段长度  max_allowed_packet

    忽略空格IGNORE_SPACE

16重启mysql服务

service mysqld restart  

17重新登入mysql显示字符集，看是否生效

show variables like 'chara%';

16开启3306端口（需要提前在阿里云中设置安全策略开放3306端口）：

/sbin/iptables -I INPUT -p tcp --dport 80 -j ACCEPT

iptables -A INPUT -ptcp --dport 3306 -j ACCEPT

service iptables save

service iptables restart

17授权所有用户（在<mysql>中写）

grant all privileges on *.* to root@'%' identified by '密码' with grant option; 授权用户给所有

flush privileges; 写入数据库授权；
