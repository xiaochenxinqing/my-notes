# Docker启动容器报错：port is already allocated解决办法

# [Docker启动容器报错：port is already allocated解决办法](https://www.4spaces.org/944.html)

2020-05-21 分类：[博文](https://www.4spaces.org/blogs) 阅读(6177) 评论(0)

## 环境信息

- docker: 19.03.6；
- CENTOS 7[搬瓦工](https://www.4spaces.org/bwg/static/promotion.html) ；

## 错误原因

服务器重启后，docker启动nginx等容器报错：

复制

Failed to allocate and map port 443-443:Bindfor0.0.0.0:443 failed: port is already allocated

## 解决办法

通过查看端口，占用端口的是docker-proxy，虽然相关容器并没有在运行，但是依然被占用端口，解决办法如下：

1.查看进程

复制

ps -aux | grep -v grep | grep docker-proxy

2.停止docker

复制

sudo systemctl stop docker

3.删除local-kv.db文件

复制

sudo rm /var/lib/docker/network/files/local-kv.db

4.删除所有容器

复制

docker rm $(docker ps -aq)

5.重新启动容器

复制

docker-compose up -d
