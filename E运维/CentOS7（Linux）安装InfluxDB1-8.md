# CentOS7（Linux）安装InfluxDB1.8

2、安装InfluxDB1.8

（1）新建influxdb的文件夹，下载influxdb的安装包，下载的是1.8版本的

wget https://dl.influxdata.com/influxdb/releases/influxdb-1.8.0.x86_64.rpm

（2）本地安装

yum -y localinstall influxdb-1.8.0.x86_64.rpm

 （3）查看influxdb的版本，看是否安装成功

influx -version   //查看influxdb的版本

 （4）启动influxdb，并设置开机自启

systemctl start influxdb   //开启influxdb

systemctl enable influxdb  //开机自启

（5）进入influxdb，并设置数据库的密码

influx   //直接在控制台输入命令即可进入数据库

create user admin with password 'root' with all privileges;   //root为我设置的密码，账号为admin

（6）influxdb默认使用了8088和8086两个端口，没有关闭防火墙的就需要开放端口。

8086: 用于客户端和服务端交互的HTTP API

8088: 用于提供备份和恢复的RPC服务

需要更改端口的，在/etc/influxdb/influxdb.conf配置文件中，不建议修改。

————————————————

原文链接：https://blog.csdn.net/qq_46092784/article/details/127974242
