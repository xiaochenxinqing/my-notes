# 华创各服务器账号密码.txt

#############################华创centOS(7)相关：##############################

IP：114.215.221.183

######系统用户：

     hc    0408

     root huachuang888

     git   0408

########一些密码：

mysql数据库账号密码：  root  FXqbMd1S

禅道管理员密码 ： admin    Huachuang888

Jenkins管理员密码 ： admin    Huachuang888

===========远程登录设置=============================

1设定远程登录方式（禁用密码登录）

sudo  vim /etc/ssh/sshd_config

UseDNS yes

AddressFamily inet

PermitRootLogin no

SyslogFacility AUTHPRIV

PasswordAuthentication no   禁用密码登录

RSAAuthentication yes

PubkeyAuthentication yes   使用公钥登录  

AllowUsers hc git  root

注意修改完毕后使用service sshd reload 使生效

2修改允许远程登录当前用户的客户端列表：

sudo  vim ~/.ssh/authorized_keys

===========================GIT配置==================================

#禁用shell登录：

     /etc/passwd文件完成。找到类似下面的一行：

     git:x:1001:1001:,,,:/home/git:/bin/bash

     改为：

     git:x:1001:1001:,,,:/home/git:/usr/bin/git-shell

#添加公钥  vim   /home/git/.ssh/authorized_keys

#初始化Git仓库:  $ sudo git init --bare xxxxx.git

#改权限:         $ sudo chmod -R -v 777  dic/

#把owner改为git：$ sudo chown -R -v git  :git xxxxx.git

###############幸福十号  IP： 47.93.236.218   root  xingfu10HAO centos

###############选吧      IP：47.96.152.188  root  xuanba  centos

###############天罡仪表  IP：140.249.19.84（windows） 项目地址：140.249.19.84:28080    windows

###############双轮      使用teamviewr  739768106

  密码123456

###############三寸时光     39.105.62.185       root               Scsg20090225

###############苹果机账号密码     hc    whcsoft888

###############幸福十号笔记本密码     0000
