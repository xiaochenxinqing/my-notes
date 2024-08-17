# docker 的坑

1pcie 如果装了原来驱动是卸载不干净的需要重启才能彻底卸载,然后装新驱动才可以 

1docker  rmi xxx 删除镜像, xxx为tagName和imageId时逻辑不一样, 用imageId可能会报错(镜像被依赖或者imageId有多个指向),  建议用tagName 可以避免这两个问题(有依赖会直接untag) 

  同样的对镜像进行save操作如果是用镜像id 会出现保存的镜像没有tagname 的情况  所以对镜像的操作最好都用tagName

2.centos7不支持type为 macvlan类型的网卡(口)自动加载

3.macvlan的parent是聚合的网口,  删除聚合网口后, 如果不配置eth0的ip直接重启

竟然会导致docker服务停掉并且启动不了 ,除非重启主机

# 容器报错docker: Error response from daemon: driver failed programming external connectivity

在启动容器时的容器时，会出现报错：Error response from daemon: driver failed programming external connectivity on endpoint XXX（端口映射或启动容器时报错）

如下： 

 原因：在我们启动了Docker后，我们再对防火墙firewalld进行操作，就会发生上述报错，

详细原因：docker服务启动时定义的自定义链DOCKER，当 centos7 firewall 被清掉时，

firewall的底层是使用iptables进行数据过滤，建立在iptables之上，这可能会与 Docker 产生冲突。

当 firewalld 启动或者重启的时候，将会从 iptables 中移除 DOCKER 的规则，从而影响了 Docker 的正常工作。

当你使用的是 Systemd 的时候， firewalld 会在 Docker 之前启动，但是如果你在 Docker 启动之后操作 firewalld ，你就需要重启 Docker 进程了。  解决办法：输入指令 如下指令，重启docker服务及可重新生成自定义链DOCKER

systemctl restart docker
