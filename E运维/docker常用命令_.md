# docker常用命令:

docker system prune --volumes   删除缓存

docker  rmi  $(docker images -f "dangling=true" -q)    删除空镜像 或 docker image prune

(

### 有用镜像

通过 docker images -a 命令才会显示的 <none> 镜像，这些镜像是镜像分层的中间镜像，同时这些镜像不会造成空间损耗

### 无用镜像

通过 docker images 命令显示的 <none> 镜像，这些镜像是由于新加镜像占用了原有镜像的标签，原有镜像就变成了 <none> 镜像)

# 停止并删除工程中所有服务的容器、网络

docker-compose stop

# 停止并删除工程中所有服务的容器、网络、镜像

docker-compose down --rmi all 

docker-compose down --rmi local (只删除构建产生的镜像 基础镜像不删除)

# 停止并删除工程中所有服务的容器、网络、数据卷

docker-compose down -v

yum install pciutils  gcc make  automake autoconf libtool

启动Portainer:

docker run -d -p 8000:8000 -p 9000:9000 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer

24 个Docker的疑难杂症处理技巧  :https://www.51cto.com/article/714172.html

# [docker容器操作宿主机执行命](https://segmentfault.com/a/1190000042002239)

[令](https://segmentfault.com/a/1190000042002239)

https://segmentfault.com/a/1190000042002239
