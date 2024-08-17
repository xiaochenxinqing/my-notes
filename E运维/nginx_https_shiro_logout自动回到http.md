# nginx https shiro logout自动回到http

# [nginx https shiro logout自动回到http](https://www.cnblogs.com/zsh-blogs/p/12165852.html)

开发毕设Docker部署nginx代理https之后，遇到一个问题

使用的Shiro点退出一直跳到http

![](https://img2018.cnblogs.com/blog/1201066/202001/1201066-20200108115818205-1241241528.png)

 

 解决方法：

proxy_redirect http:// https://

![](https://common.cnblogs.com/images/copycode.gif)

server {

    listen 9999;

    server_name [www.qqzsh.top;](http://www.qqzsh.top%3b/)

    ssl on;

    ssl_certificate /etc/nginx/b.pem;

    ssl_certificate_key /etc/nginx/a.key;

    ssl_session_timeout 5m;

    ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:ECDHE:ECDH:AES:HIGH:!NULL:!aNULL:!MD5:!ADH:!RC4;

    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;

    ssl_prefer_server_ciphers on;

    location / {

        proxy_pass http://172.30.0.2:10086;

        add_header Content-Security-Policy upgrade-insecure-requests;

        proxy_set_header Host $host:$server_port;

        proxy_set_header X-Real-IP $remote_addr;

        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

        proxy_redirect http:// https://; client_max_body_size 10M;

    }

}

![](https://common.cnblogs.com/images/copycode.gif)
