# 【nginx】 配置域名转发到相同地址不同端口下执行相应业务

# 【nginx】 配置域名转发到相同地址不同端口下执行相应业务

快速奔跑的大米粒 2019-05-21 [原文](https://www.bbsmax.com/link/Z0dkWGoyeUdKNA==)

1. #doctor
2. upstream doc {
3. server 52.**.**.***:8090;
4. }
5. #patient
6. upstream pat {
7. server 52.**.**.***:8088;
8. }
9. server {
10. listen 80;
11. server_name www.baidu.com; #自己的域名
12. #patient
13. location /pat/ {
14. proxy_set_header host $host;
15. 　　 proxy_set_header X-forwarded-for $proxy_add_x_forwarded_for;
16. 　　 proxy_set_header X-real-ip $remote_addr;
17. 　　 proxy_pass http://pat;
18. }
19. #doctor
20. location /doc/ {
21. proxy_set_header host $host;
22. proxy_set_header X-forwarded-for $proxy_add_x_forwarded_for;
23. proxy_set_header X-real-ip $remote_addr;
24. proxy_pass http://doc;
25. }
