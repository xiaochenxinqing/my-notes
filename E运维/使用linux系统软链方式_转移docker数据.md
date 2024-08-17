# 使用linux系统软链方式 转移docker数据

---

 systemctl stop docker 

cp -r  /var/lib/docker    /home(空间足够的新目录)

rm -rf   /var/lib/docker

ln -s  /home/docker   /var/lib/docker

systemctl start  docker

注意:迁移以后可能会导致某些容器出现bug启动不了(比如mysql) ,  最好是迁移完毕后docker system prune

然后再删除初始镜像重新拉取或载入
