# Linux 设置开机启动

#### **一、在/etc/rc.d/rc.local文件中配置相应的启动脚本**

> 或者在/etc/rc.local文件中配置

# 例如启动Tomcat

/mnt/apache-tomcat-8.5.23/bin/startup.sh start

1

2

#### **二、在/etc/init.d目录下添加自启动脚本**

> linux在“/etc/rc.d/init.d”下有很多的文件，每个文件都是可以看到内容的，其实都是一些shell脚本或者可执行二进制文件
> 
> Linux开机的时候，会加载运行/etc/init.d目录下的程序，因此我们可以把想要自动运行的脚本放到这个目录下即可。系统服务的启动就是通过这种方式实现的。
