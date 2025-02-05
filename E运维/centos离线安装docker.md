# centos离线安装docker

**1.准备安装匪*

 安装包官方地址：https://download.docker.com/linux/static/stable/x86_64/

可以先下载到本地，然后通过ftp工具上传到服务器上，或者在服务器上使用命令下载

wget https://download.docker.com/linux/static/stable/x86_64/docker-18.06.3-ce.tgz

**2.解压**

代码如下（示例）：

tar -zxvf docker-18.06.3-ce.tgz

**3.将解压出来的docker文件复制到 /usr/bin/ 目录下**

代码如下（示例）：

cp docker/* /usr/bin/

**4.进入/etc/systemd/system/目录,并创建docker.service文件，内容如下，这样可以将docker注册为service服务**

代码如下（示例）：



```
[Unit] 

Description=Docker Application Container Engine

Documentation=https://docs.docker.com

After=network-online.target firewalld.service

Wants=network-online.target

[Service]

Type=notify

# the default is not to use systemd for cgroups because the delegate issues still

# exists and systemd currently does not support the cgroup feature set required

# for containers run by docker

ExecStart=/usr/bin/dockerd -H tcp://0.0.0.0:2376 -H unix:// --selinux-enabled=false --insecure-registry=127.0.0.1

ExecReload=/bin/kill -s HUP $MAINPID

# Having non-zero Limit*s causes performance problems due to accounting overhead

# in the kernel. We recommend using cgroups to do container-local accounting.

LimitNOFILE=infinity

LimitNPROC=infinity

LimitCORE=infinity

# Uncomment TasksMax if your systemd version supports it.

# Only systemd 226 and above support this version.

#TasksMax=infinity

TimeoutStartSec=0

# set delegate yes so that systemd does not reset the cgroups of docker containers

Delegate=yes

# kill only the docker process, not all processes in the cgroup

KillMode=process

# restart the docker process if it exits prematurely

Restart=on-failure

StartLimitBurst=3

StartLimitInterval=60s

[Install]

WantedBy=multi-user.target
```







**注意:**

a.此处的–insecure-registry=127.0.0.1（此处改成你私服ip）设置是针对有搭建了自己私服Harbor时允许docker进行不安全的访问，否则访问将会被拒绝。

b.tcp://0.0.0.0:2376是允许外部链接访问,   若只允许本机更改为127.0.0.

**5.启动docker**

给docker.service文件添加执行权限

chmod +x /etc/systemd/system/docker.service 

重新加载配置文件（每次有修改docker.service文件时都要重新加载下）

systemctl daemon-reload 

启动

systemctl start docker

设置开机启动

systemctl enable docker

**6.查看docker服务状态**

 systemctl status docker

 docker info