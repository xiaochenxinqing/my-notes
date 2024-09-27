# centos服务器初始化

1安装常用工具

     vim  git  ntpdate

3：配置yum源

]# mkdir /etc/yum.repos.d/repo_bak && mv /etc/yum.repos.d/CentOS* /etc/yum.repos.d/repo_bak

]# curl -o /etc/yum.repos.d/CentOS-7-ali.repo http://mirrors.aliyun.com/repo/Centos-7.repo

]# yum clean cache

]# yum makecache

]# yum repolist

4.关闭selinux

vim /etc/selinux/config    将

SELINUX=enforcing

指令更改为

SELINUX=disabled

重启生效

5.设置打开最大文件句柄数
