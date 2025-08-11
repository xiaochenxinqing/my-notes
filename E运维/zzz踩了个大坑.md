# 

docker 容器呢内 /etc/hosts文件不对 ， 会导致所有调用了  InetAddress.getLocalHost 进程的java进程 启动缓慢 

少这么一行： 

`172.20.111.16    648c58e55007`

详见 ：https://www.jianshu.com/p/ff62717521ba





java执行shell     带* 的命令会不识别  需要用 /bin/bash  -c



