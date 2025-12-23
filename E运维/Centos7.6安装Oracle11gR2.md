# [centos7.6 安装oracle11gr2](https://www.cnblogs.com/wa-zz/p/15855507.html)

环境：centos7.6 安装了桌面

如果没有安装桌面。可以挂载yum源来安装。

```
yum -y groupinstall "GNOME Desktop" "Graphical Administration Tools"
```

 

软件包：oracle 11g r2

一：准备工作

1、关闭selinux

查看selinux状态：getenforce 或者sestatus -v
临时关闭：setenforce 0
永久关闭：vim /etc/selinux/config 设置SELINUX=disabled

2、关闭firewalld 安装iptables

systemctl stop firewalld.service
systemctl disable firewalld.service

二：创建用户及安装目录，安装依赖包

1、创建用户

[root@oracledb ~] groupadd oinstall
[root@oracledb ~] groupadd dba
[root@oracledb ~] useradd -g oinstall -G dba -m oracle
[root@oracledb ~] passwd oracle

2、创建安装目录，解压文件

[root@oracledb ~] mkdir -p /ora/oracle
[root@oracledb ~] unzip -d /ora/ linux.x64_11gR2_database_1of2.zip
[root@oracledb ~] unzip -d /ora/ linux.x64_11gR2_database_2of2.zip
[root@oracledb ~] chown -R oracle:oinstall /ora
[root@oracledb ~] chmod 755 -R /ora

3、安装依赖包

```
yum –y install binutils compat-libstdc++-33 elfutils-libelf elfutils-libelf-devel elfutils-libelf-devel-static gcc gcc-c++ glibc glibc-common glibc-devel glibc-headers glibc-static kernel-headers pdksh libaio libaio-devel libgcc libgomp libstdc++ libstdc++-devel libstdc++-static make numactl-devel sysstat unixODBC unixODBC-devel
```

base yum源里缺少了 compat-libstdc++-33，pdksh软件包。可以从下面的链接里下载。

> 链接：https://pan.baidu.com/s/1qGK5QTLG2lE893_e8jyP-g
> 提取码：6jae

三：修改系统内核等设置



```
1、以下适用于8G内存左右服务器配置，12G或者16G以上建议调整

[root@oracledb ~] vim /etc/sysctl.conf
fs.aio-max-nr = 1048576
fs.file-max = 6815744
kernel.shmall = 2097152
kernel.shmmax = 4294967295
kernel.shmmni = 4096
kernel.sem = 250 32000 100 128
net.ipv4.ip_local_port_range = 9000 65500
net.core.rmem_default = 262144
net.core.rmem_max = 4194304
net.core.wmem_default = 262144
net.core.wmem_max = 1048576
```



12G以上配置



```
kernel.shmmni = 4096
kernel.sem = 250 32000 100 128
fs.file-max = 6815744
fs.aio-max-nr = 3145728
net.ipv4.ip_local_port_range = 9000 65500
net.core.rmem_max=4194304
net.core.wmem_max = 1048576
net.core.wmem_default = 262144
net.core.rmem_default = 4194304
net.ipv4.tcp_wmem = 262144 262144 262144
net.ipv4.tcp_rmem = 262144 262144 262144
kernel.panic_on_oops = 1
net.ipv4.conf.all.rp_filter = 2
net.ipv4.conf.default.rp_filter = 2
kernel.shmmax = 412316860416
kernel.shmall = 100663296
```



```
2、完成后使用命令

[root@oracledb ~] sysctl -p
```



```
3、修改认证模块

[root@oracledb ~] vim /etc/security/limits.conf
oracle soft nproc 131072
oracle hard nproc 131072
oracle soft nofile 131072
oracle hard nofile 131072
oracle soft core unlimited
oracle hard core unlimited
oracle soft memlock 50000000
oracle hard memlock 50000000

4、修改用户登录认证

[root@oracledb ~] vim /etc/pam.d/login
session required /lib64/security/pam_limits.so
session required pam_limits.so
```





```
5、修改Oracle用户环境变量

[root@oracledb ~] vim /home/oracle/.bash_profile
export ORACLE_BASE=/ora/oracle
export ORACLE_HOME=$ORACLE_BASE/product/11.2.0/db_1
export ORACLE_SID=orcl
export ORACLE_TERM=xterm
export PATH=$ORACLE_HOME/bin:/usr/sbin:$PATH
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib
export NLS_LANG=AMERICAN_AMERICA.ZHS16GBK
```



四：通过桌面方式安装Oracle（如果是虚拟化集群中，可能会出现安装过程中显示不完整的情况，可以使用xstart调用桌面环境）

1、使用oracle用户登录桌面，打开终端运行安装程序

```
[root@oracledb ~] cd /ora/database
[root@oracledb ~] ./runInstaller
```

2、安装过程是都有相应提示的，并且鼠标直接点就完了。

注意：如果安装的数据库有问题，后续可以直接通过dbca图形界面删库重建即可。

> 参考文档：https://blog.csdn.net/csgd2000/article/details/100224722
>
> https://blog.csdn.net/lia17/article/details/82256565