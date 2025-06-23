```
##tar导入为镜像

docker load - i      包名.tar 

##镜像运行为容器

docker run  -itd  --name  容器名   --privileged=true    镜像名:镜像tag     bash             （注：再有其他需要的参数可自行添加）

docker run  -itd  --name  finaltest  -p 3002:2181 -p 3001:2000 -p 3000:3000 -p 8014:3307   -v /root/finaltest-data:/mnt/all-data       venus-dbsec-final:1.0     bash  

docker run  -itd  --name  yxcfinaltest1    -e HSM_IP=120.226.208.115 -e HSM_PORT=9034   -v /root/yxcfinaltest1-data:/mnt/all-data   venus-dbsec-final:1.0     bash  


docker run  -itd  --name  finaltest  -p 2181:2181 -p 2000:2000 -p 3000:3000 -p 3307:3307  -p 3306:3306 -v /root/finaltest-data:/mnt/all-data        venus-dbsec-final:1.0     bash  




docker run  -itd \
	--name  finaltest \
	-p 3002:2181 -p 3001:2000 -p 3000:3000 -p 5901:3307  \
    -e HSM_IP=120.226.208.115 -e HSM_PORT=9034    \
    -v /root/finaltest1-data:/mnt/all-data    \
    
    venus-dbsec-final:1.0     bash  






-p 3002:2181 -p 3001:2000 -p 3000:3000 -p 5901:3307  -p 8014:3306 (测)
   10156        10140		10116		  10320			10439

（注：再有其他需要的参数可自行添加）

##进入容器

docker exec -it   容器名 bash



##向容器内复制文件

docker cp  /path/file.txt    容器名:/root



##容器提交为新镜像

docker commit  --change='ENTRYPOINT ["/root/baseStart.sh"]' --change='HEALTHCHECK --interval=20s CMD /root/healthCheck.sh'  容器名   新镜像名:新镜像tag
docker commit   basetest   venus-dbsec-base:1.0


##镜像导出为tar

docker save -o    venus-dbsec-base-1.0.tar     venus-dbsec-base:1.0

docker save -o    venus-dbsec-final-1.0.tar     venus-dbsec-final:1.0

##
压缩镜像 
docker export -o basecon.tar 容器id
docker import basecon.tar  venus-dbsec-base:1.0


```







mysql: 

https://blog.csdn.net/m0_63838460/article/details/144735715

https://blog.csdn.net/wcy18818429914/article/details/143720576?utm_medium=distribute.pc_relevant.none-task-blog-2~default~baidujs_baidulandingword~default-1-143720576-blog-144735715.235^v43^pc_blog_bottom_relevance_base2&spm=1001.2101.3001.4242.2&utm_relevant_index=4

https://blog.csdn.net/Fponyo/article/details/143377467



```
cd /etc/yum.repos.d

rm -rf  * 

curl -o /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-7.repo

yum makecache
yum -y update
yum repolist
```





 docker run  -itd  --name  finaltest1  -e HSM_IP=120.226.208.115 -e HSM_PORT=9034     venus-dbsec-final:1.0     bash

 docker run  -itd  --name  finaltest2   --network=none  -e HSM_IP=120.226.208.115 -e HSM_PORT=9034     venus-dbsec-final:1.0     bash

docker network disconnect none  finaltest2 

docker network connect bridge finaltest2 







docker run -d  --name es   -e "ES_JAVA_OPTS=-Xms1024M -Xmx1024m"  -e "discovery.type=single-node"  --privileged  -p 9200:9200  -p 9300:9300  





docker exec finaltest   device_manage import conf



docker   rm -f  finaltest

docker run  -itd  --name  finaltest  -p 2181:2181 -p 2000:2000 -p 3000:3000 -p 3307:3307 -p5433:5433  -v /root/image_data:/image_data   -e PROXY_TYPES="mysql" -e JAVA_MEM_COMMON_OPTS="-Xmx8g -Xms512m -Xmn512m -Xss512k"    venus-dbsec-final:1.0     bash



docker run  -itd  --name  finaltest  -p 2181:2181 -p 2000:2000 -p 3000:3000 -p 3307:3307 -p5433:5433  -v /root/finaltest-data:/mnt/all-data   -e PROXY_TYPES="mysql" -e JAVA_MEM_COMMON_OPTS="-Xmx4g -Xms512m -Xmn512m -Xss512k"    venus-dbsec-final:1.0     bash



docker run  -itd  --name  finaltest  -p 2181:2181 -p 2000:2000 -p 3000:3000 -p 3307:3307 -p5433:5433  -v /root/image_data:/image_data  -v /root/finaltest-data:/mnt/all-data     -e PROXY_TYPES="mysql" -e JAVA_MEM_COMMON_OPTS="-Xmx8g -Xms512m -Xmn512m -Xss512k"    venus-dbsec-final:1.0     bash

=============================

数据准备



登录 MySQL：mysql -u root -p
执行这条SQL： ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY 'password';    #root和password需要根据实际情况替换为自己的数据。

​          



清空数据 

sysbench oltp_read_only --mysql-host='192.188.1.222' --mysql-port=3307 --mysql-user=root --mysql-password='root' --mysql-db=testdb --tables=1 --table-size=1000000 --report-interval=10 --time=3600 --threads=128 --max-requests=0 --percentile=99 --mysql-ignore-errors="all" --rand-type=uniform --range_selects=off --auto_inc=off cleanup

sysbench oltp_read_only --mysql-host='192.188.1.221' --mysql-port=3306 --mysql-user=root --mysql-password='root' --mysql-db=testdb1 --tables=1 --table-size=1000000 --report-interval=10 --time=3600 --threads=128 --max-requests=0 --percentile=99 --mysql-ignore-errors="all" --rand-type=uniform --range_selects=off --auto_inc=off cleanup



#插入数据

sysbench oltp_insert --mysql-host='192.188.1.222' --mysql-port=3307 --mysql-user=root --mysql-password='root' --mysql-db=testdb --tables=1 --table-size=1000000 --report-interval=10 --time=3600 --threads=1  prepare

sysbench oltp_insert --mysql-host='192.188.1.221' --mysql-port=3306 --mysql-user=root --mysql-password='root' --mysql-db=testdb1 --tables=1 --table-size=1000000 --report-interval=10 --time=3600 --threads=1  prepare

#性能测试

sysbench oltp_read_write --mysql-host='192.188.1.222' --mysql-port=3307 --mysql-user=root --mysql-password='root' --mysql-db=testdb --tables=1 --table-size=1000000 --report-interval=5 --time=180 --threads=200 --max-requests=0 --mysql-ignore-errors="all" --range_selects=off --rand-type=uniform --auto_inc=off run

sysbench oltp_read_write --mysql-host='192.188.1.221' --mysql-port=3306 --mysql-user=root --mysql-password='root' --mysql-db=testdb1 --tables=1 --table-size=1000000 --report-interval=5 --time=180 --threads=200 --max-requests=0 --mysql-ignore-errors="all" --range_selects=off --rand-type=uniform --auto_inc=off run







mysql    !6#v@R4Y*k      10001
