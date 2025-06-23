# nginx各种配置参考

`#user  nobody;`

`worker_processes  1;`

`#error_log  logs/error.log;`

`#error_log  logs/error.log  notice;`

`#error_log  logs/error.log  info;`

`#pid        logs/nginx.pid;`

`events {`

`    worker_connections  1024;`

`}`

`http {`

`    include       mime.types;`

`    default_type  application/octet-stream;`

`    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;	`

`    #log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '`

`    #                  '$status $body_bytes_sent "$http_referer" '`

`    #                  '"$http_user_agent" "$http_x_forwarded_for"';`

`    #access_log  logs/access.log  main;`

`    sendfile        on;`

`    #tcp_nopush     on;`

`    keepalive_timeout  125;`

`	keepalive_requests 10000; `

`	client_max_body_size 100M;`

`    #gzip  on;`

`    upstream wdzhsqapinormala {`

`        server  localhost:8080;`

`        server  localhost:8081;`

`    }`

`	upstream wdzhsqapinormalb {`

`        server  localhost:8082;`

`        server  localhost:8083;`

`    }`

`	upstream wdzhsqapivideoa {`

`        server  192.168.162.49:8080;`

`        server  192.168.162.49:8081;`

`    }`

`	upstream wdzhsqapivideob {`

`        server  192.168.162.49:8080;`

`        server  192.168.162.49:8081;`

`    }`

`    server {`

`        listen        443 ssl ;#文登智慧社区后台api端`

`        server_name  wdzhsqapi.weihai.cn;`

`        ssl_certificate      cert/wdzhsqapi.crt;`

`        ssl_certificate_key  cert/wdzhsqapi.key;`

`        ssl_session_cache    shared:SSL:10m;`

`        ssl_session_timeout  5m;`

`        #ssl_server_tokens off;`

`        ssl_ciphers  ECDHE-RSA-AES128-GCM-SHA256:ECDHE:ECDH:AES:HIGH:!NULL:!aNULL:!MD5:!ADH:!RC4;`

`        ssl_protocols  TLSv1.2;`

`        ssl_prefer_server_ciphers  on;`

`		proxy_http_version 1.1;`

`		proxy_connect_timeout 1;`

`        proxy_read_timeout 120;`

`        proxy_send_timeout 120;`

`		proxy_next_upstream_timeout 3;`

`        location ~/ {`

`			set $target "wdzhsqapi";`

`			#先判断服务器分组`

`			if ($http_target_server_type = "videoServer") { `

`				 set $target "${target}video";`

`			}`

`			if ($http_target_server_type = "normalServer") {`

`				set $target "${target}normal";`

`			}`

`			if ($http_target_server_type = "") {`

`				 set $target "${target}normal";`

`			}`

`			#先判断每台服务器上的分组`

`			if ($http_target_api_group = "A") {`

`				 set $target "${target}a";`

`			}`

`			if ($http_target_api_group = "B") {`

`				set $target "${target}b";`

`			}`

`			if ($http_target_api_group = "") {`

`				 set $target "${target}a";`

`			}`

`			proxy_pass http://$target;`

`            proxy_set_header Host $http_host;`

`            proxy_set_header X-Real-IP $remote_addr;`

`            proxy_set_header X-Forwarded-Proto https;`

`            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;`

`			proxy_set_header Upgrade $http_upgrade;`

`			proxy_set_header Connection "upgrade";		`

`            proxy_next_upstream  http_502 http_504 error timeout invalid_header;`

`            proxy_redirect http:// https://;`

`        }`

`    }`

`	server {`

`        listen 80;`

`        server_name wdzhsqapi.weihai.cn;`

`        rewrite ^/(.*)$  https://wdzhsqapi.weihai.cn/$1 permanent;`

`    }`

`   	server {`

`        listen       443 ssl ;#文登智慧社区后台web端`

`        server_name   wdzhsqweb.weihai.cn;`

`		charset   utf-8;`

`        ssl_certificate      cert/wdzhsqweb.crt;`

`        ssl_certificate_key  cert/wdzhsqweb.key;`

`        ssl_session_cache    shared:SSL:10m;`

`        ssl_session_timeout  5m;`

`        #ssl_server_tokens off;`

`        ssl_ciphers  ECDHE-RSA-AES128-GCM-SHA256:ECDHE:ECDH:AES:HIGH:!NULL:!aNULL:!MD5:!ADH:!RC4;`

`        ssl_protocols  TLSv1.2;`

`        ssl_prefer_server_ciphers  on;`

`        #charset koi8-r;`

`        #access_log  logs/host.access.log  main;`

`		location /videoplay {`

`			# 拦截非法referer`

`			valid_referers  wdzhsqweb.weihai.cn ; `

`			if ($invalid_referer) { `

`				return 403 ; `

`			} `

`			if ($request_uri ~* ^/videoplay(.*)$){`

`				set $my_url $1;`

`				proxy_pass http:/$my_url;`

`			}`

`        }`

`		location / {`

`            root        /usr/java/wdzhsqweb/dist;#vue项目的打包后的dist`

`			try_files $uri $uri/ /index.html;`

`            index  index.html index.htm;`

`        }`

`    }`

`	server {`

`        listen 80;`

`        server_name wdzhsqweb.weihai.cn;`

`        rewrite ^/(.*)$  https://wdzhsqweb.weihai.cn/$1 permanent;`

`    }`

`   	server {`

`        listen       443 ssl;#文登智慧社区爱山东端`

`        server_name   wdzhsqasd.weihai.cn;`

`		charset   utf-8;`

`		ssl_certificate      cert/wdzhsqasd.crt;`

`        ssl_certificate_key  cert/wdzhsqasd.key;#当前conf/目录下`

`        ssl_session_cache    shared:SSL:10m;`

`        ssl_session_timeout  5m;`

`        #charset koi8-r;`

`        #access_log  logs/host.access.log  main;`

`        root        /usr/java/wdzhsqasd/SmartCommunityASD;#vue项目的打包后的dist`

`        location / {`

`	    proxy_hide_header  X-Frame-Options;`

`            try_files $uri $uri/ @router;#需要指向下面的@router否则会出现vue的路由在nginx中刷新出现404`

`            index  index.html;`

`        }`

`        #对应上面的@router，主要原因是路由的路径资源并不是一个真实的路径，所以无法找到具体的文件`

`        #因此需要rewrite到index.html中，然后交给路由在处理请求资源`

`        location @router {`

`            rewrite ^.*$ /index.html last;`

`        }`

`        #.......其他部分省略`

`    }`

`	server {`

`        listen 80;`

`        server_name wdzhsqasd.weihai.cn;`

`        rewrite ^/(.*)$  https://wdzhsqasd.weihai.cn/$1 permanent;`

`    }`

`server {`

`		listen  8099      ;#文登智慧社区视频播放(通过一体机)`

`		proxy_http_version 1.1;`

`        proxy_connect_timeout 1;`

`        proxy_read_timeout 120;`

`        proxy_send_timeout 120;`

`        proxy_next_upstream_timeout 3;`

`        location / {`

`				proxy_pass http:/$request_uri;`

`        }		`

`    }`

`   server {`

`		listen  8088      ;#文登智慧社区视频播放(通过大华云平台)`

`        location /hls {`

`            # Serve HLS fragments`

`            types {`

`                application/vnd.apple.mpegurl m3u8;`

`                video/mp2t ts;`

`            }`

`            root /usr/local/nginx/html;`

`            #expires -1;`

`           add_header Access-Control-Allow-Origin * ;`

`        }       `

`    }`

`}`

`rtmp {    `

`    server {    `

`        listen 8554;  #监听的端口  `

`        chunk_size 4000;    `

`        application hls {  #rtmp推流请求路径 被FFmpeg推到这里后被转换为.m3u8文件然后通过上面的8888端口拉流播放 `

`            live on;    `

`            hls on;    `

`            hls_path /usr/local/nginx/html/hls;    `

`            hls_fragment 5s;    `

`        }    `

`    }    `

`}`

//=======================================================

多个项目通过后缀访问：

```
server {
        listen 443 ssl;
        server_name esms;

        proxy_set_header Cookie $http_cookie;
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header X-Forwarded-Server $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

        ssl_certificate      cert/server.pem;
        ssl_certificate_key  cert/server.key.nopass;#当前conf/目录下

       location /im {
             alias    /usr/fisec/esms/web;
             index  index.html index.htm;
             try_files $uri $uri/    @router;
       }
        #解决刷新404的问题
        location @router {
         rewrite ^.*$ /im/index.html;
        }
        #接口转发
       location /encChat/ {
          proxy_pass  https://127.0.0.1:8081/;
       }



    }
```



单个web通过端口访问：

```
server {
        listen 443 ssl;
        server_name esms;

        proxy_set_header Cookie $http_cookie;
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header X-Forwarded-Server $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

        ssl_certificate      cert/server.pem;
        ssl_certificate_key  cert/server.key.nopass;#当前conf/目录下


         root   /usr/fisec/esms/web;  #vue项目的打包后的dist

         location / {
             try_files $uri $uri/ @router;#需要指向下面的@router否则会出现vue的路由在nginx中刷新出现404
             index  index.html index.htm;
         }
         #对应上面的@router，主要原因是路由的路径资源并不是一个真实的路径，所以无法找到具体的文件
         #因此需要rewrite到index.html中，然后交给路由在处理请求资源
         location @router {
              rewrite ^.*$ /index.html last;
         }
        #接口转发
       location /encChat/ {
          proxy_pass  https://127.0.0.1:8081/;
       }



    }
```
