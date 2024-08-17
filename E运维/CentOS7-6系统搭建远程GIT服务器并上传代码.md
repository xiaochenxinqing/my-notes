# CentOS7.6系统搭建远程GIT服务器并上传代码

**一.配置git服务器环境和仓库**

# 1. 在服务端执行，安装GIT

[root@hostname ~]$ sudo yum install curl-devel expat-devel gettext-devel openssl-devel zlib-devel perl-devel

[root@hostname ~]$ sudo yum install git#

2. 创建git用户并修改密码

[root@hostname ~]$ sudo adduser git

[root@hostname ~]$ sudo passwd git

3.禁用git用户的shell登录

[root@hostname ~]$ vim  /etc/passwd

找到类似下面的一行：

     git:x:1001:1001::/home/git:/bin/bash

     改为：

     git:x:1001:1001::/home/git:/usr/bin/git-shell

#4.设定远程登录方式（增加密钥登录）

[root@hostname ~]sudo  vim /etc/ssh/sshd_config  后 改为如下配置：

        PubkeyAuthentication yes   使用公钥登录

修改完毕后

[root@hostname ~]service sshd reload

#5. 配置SSH

# 注：.ssh 及该目录下的文件不能用77x的权限，所以要755 （划重点）！！！！！！！！！

[root@hostname ~]$ cd /home/git

[root@hostname git]$ mkdir .ssh

[root@hostname git]$ chmod 755 .ssh

# 6. 收集客户端公钥(客户端生成的*.pub文件)内容并合并到/home/git/.ssh/authorized_keys中，每行一个公钥

[root@hostname git]$ cd .ssh

[root@hostname .ssh]$ vim   /home/git/.ssh/authorized_keys #添加公钥

[root@hostname .ssh]$ chmod 755 authorized_keys

#7.创建项目project.git裸仓库,以.git 结尾，project是仓库名，修改所属用户和组为git,不能执行就加sudo，用root权限

[root@hostname .ssh]$ cd /home/git

[root@hostname git]$ mkdir project.git

[root@hostname git]$ sudo git init --bare project.git

[root@hostname git]$ sudo chmod -R -v 777  project.git/

[root@hostname git]$ sudo chown -R -v git:git  project.git

**二.git生成ssh密钥对**

# 1.配置用户名和邮箱

git config --global user.name "yinxiaochen"

git config --global user.email "[842946343@qq.com](mailto:842946343@qq.com)"

# 2.生成公钥私钥，并保存到 个人目录/.ssh 下

$ ssh-keygen -t rsa -C "[842946343@qq.com](mailto:842946343@qq.com)"

按3次回车键

# **三.上传本地代码到git仓库**

**1  git init**

**2 git add -A, git commit -m**

**3  git remote add origin   url(即把url认定为origin)**

**4 git push -u origin master**

**（意思是，如果当前分支与多个主机存在追踪关系，则可以使用-u选项指定一个默认主机，这样以后就可以不加任何参数使用git push。**

**如果只有一个主机 则**

**$ git push  origin master**
