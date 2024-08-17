# docker 清除缓存

要清除Docker的缓存，可以执行以下操作： 

1. 清除未使用的镜像：使用`docker image prune`命令清除未使用的镜像。该命令会删除未被任何容器使用的镜像。可以加上`-a`选项来删除所有未使用的镜像，包括那些被标记为"untagged"的镜像。

 docker image prune 

2. 清除无效的容器：使用`docker container prune`命令清除无效的容器。该命令会删除已经停止的、退出的或者被删除的容器。

 docker container prune 

3. 清除无效的卷：使用`docker volume prune`命令清除无效的卷。该命令会删除未被任何容器使用的卷。

 docker volume prune 

4. 清除无效的网络：使用`docker network prune`命令清除无效的网络。该命令会删除未被任何容器连接的网络。 

docker network prune 

5. 清除所有缓存：如果要一次性清除所有的缓存，可以使用`docker system prune`命令。该命令会删除未使用的镜像、容器、卷和网络。 

docker system prune

 注意：执行以上命令时，请谨慎操作，确认删除的内容不会对你的应用程序造成影响。
