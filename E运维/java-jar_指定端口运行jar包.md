# java -jar 指定端口运行jar包

1、指定端口

java -jar springboot.jar --server.port=8181

1

2、指定配置文件

java -jar springboot.jar --spring.profiles.active=dev

1

3、同时指定端口与配置文件

java -jar springboot.jar --server.port=8181 --spring.profiles.active=dev

1

Linux

1、后台服务方式启动

nohup java -jar springboot.jar --server.port=8181 >outlog.log 2>&1 &

1

2、加载服务器配置文件application-dev.yml

nohup java -Dserver.port=8086  -Dspring.config.additional-location=./application-dev.yml -jar ./springboot.jar> nohup.out 2>&1 &
