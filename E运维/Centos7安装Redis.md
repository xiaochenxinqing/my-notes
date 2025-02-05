# Centos7安装Redis

一、安装gcc依赖

由于 redis 是用 C 语言开发，安装之前必先确认是否安装 gcc 环境（gcc -v），如果没有安装，执行以下命令进行安装

** [root@localhost local]# yum install -y gcc�**�

 

二、下载并解压安装包

**[root@localhost local]# wget**[**http://download.redis.io/releases/redis-5.0.5.tar.gz**](http://download.redis.io/releases/redis-5.0.3.tar.gz)

**[root@localhost local]# tar -zxvf redis-5.0.5.tar.gz**

 

三、cd切换到redis解压目录下，执行编译

**[root@localhost local]# cd redis-5.0.5**

 

四、安装并指定安装目录

**[root@localhost redis-5.0.5]#make &make install PREFIX=/usr/local/redis**

 

五、启动服务

 

5.2后台启动

从 redis 的源码目录中复制 redis.conf 到 redis 的安装目录

**[root@localhost ~]# cp /root/redis-5.0.5/redis.conf   /usr/local/redis/bin/**

 

修改 redis.conf 文件，

**[root@localhost ~]#�**�cd /usr/local/redis/bin/

**[root@localhost bin]# vim redis.conf**

关键配置:

daemonize yes

protected-mode no

**注意:bind    这里很多人会误以为绑定的ip应该是请求来源的ip。其实不然，这里应该绑定的是你redis服务器本身接受请求的ip。**

后台启动

**[root@localhost bin]# ./redis-server redis.conf**
