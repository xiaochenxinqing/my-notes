# Linux常用命令



ps -ef|grep xxx                  查看进程

netstat -tunlp|grep  8081        查看某端口被哪个进程占用.

netstat -anp|grep 8081|awk '{printf $7}'|cut -d/ -f1  #直接获得进程值

ps --pid 1234； 其次根据进程ID显示指定的进程信息，

nohup ....... &                      进程挂起运行

du -sh               查看文件夹占用空间大小

chmod -R -v 777  dic/             更改某文件夹的权限

sudo chown -R -v git  :git xxxxx.git   xxx          更改文件或文件夹所有者

top               显示当前系统正在执行的进程的相关信息，包括进程ID、内存占用率、CPU占用率等

mkdir &touch   创建文件夹/文件

whereis       查找二进制文件

systemctl    start /stop/status/enable/disable  xxx.service systemctl 相关操作(启动、停止、查看状态、设置开机启动、禁止开机启动)

### firewalld

```
firewall-cmd --zone=public --add-port=80/tcp --permanent    （--permanent永久生效，没有此参数重启后失效）
```

重新载入

```
firewall-cmd --reload
```

查看

```
firewall-cmd --zone=public --query-port=80/tcp
```

删除

firewall-cmd --zone=public --remove-port=80/tcp --permanent

查看所有端口列表:

firewall-cmd --list-all 

### 查看系统版本



 cat /etc/redhat-release (,适用于RedHat,CentOS)

 cat /proc/version

 cat /etc/.productinfo(麒麟v10查看)

    nkvers(麒麟v10查看)

 uname -a 或  uname -r

du -h --max-depth=1 * ,可以查看当前目录下各文件、文件夹的大小,子目录大小等

du -sh 查询当前目录总大小可以使用

rpm -qa|grep   -e   -ivh 

yum list install-y 
