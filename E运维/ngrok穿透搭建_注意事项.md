# ngrok穿透搭建&注意事项

安装参考 

[https://blog.csdn.net/Carry_all/article/details/103935906](https://blog.csdn.net/Carry_all/article/details/103935906)

**配置开机启动和守护进程**

**vim /etc/systemd/system/ngrokd.service**

[Unit]

Description=ngrok-server

After=syslog.target network.target

[Service]

PrivateTmp=true

Type=simple

Restart=always

RestartSec=3

StandardOutput=null

StandardError=null

ExecStart=/usr/local/ngrok/bin/ngrokd -domain=[ngrok.loveweihai.com](http://ngrok.loveweihai.com/) -httpAddr=:880 -httpsAddr=:8443

ExecStop=/usr/bin/killall ngrokd

[Install]

WantedBy=multi-user.target

设置开机启动

**[root@localhost bin]# systemctl daemon-reload**

**[root@localhost bin]# systemctl start ngrokd.service**

**[root@localhost bin]# systemctl enable �**�**ngrokd****.service**

1服务器安全组和防火墙 打开4443  和 8088 和 8281 端口（若配置了nginx转发则8088和8281不用开）

*.[ngrok.hwsmart.net](http://ngrok.hwsmart.net/).      [ngrok.hwsmart.net](http://ngrok.hwsmart.net/).  都解析到ip

**2ngrok 配置：**

#ngrok内网穿透工具(访问端口：8082)

server

    {

        listen 80;

        server_name *.[ngrok.loveweihai.com;](http://ngrok.loveweihai.com%3b/)  

        location / {

            #此处二级域名可以随意填写

            proxy_pass [http://127.0.0.1:8088;](http://127.0.0.1:8082;/)

            # 这个是重点，$host 指的是与server_name相同的域名

            proxy_set_header Host $host:8088;  

            proxy_redirect off;

            client_max_body_size 10m;

            client_body_buffer_size 128k;

            proxy_connect_timeout 90;

            proxy_read_timeout 90;

            proxy_buffer_size 4k;

            proxy_buffers 6 128k;

            proxy_busy_buffers_size 256k;

            proxy_temp_file_write_size 256k;

        }

}

server {

        listen 80;

        listen  443 ssl;

        server_name *.[ngrok.hwsmart.net;](http://ngrok.hwsmart.net%3b/)

        ssl_certificate      cert/ngrok.crt;

        ssl_certificate_key  cert/ngrok.key;#当前conf/目录下

        ssl_session_timeout 5m;

        location / {

            proxy_set_header X-Real-IP $remote_addr;

            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

            proxy_set_header Host $http_host:8088;

            proxy_set_header X-Nginx-Proxy true;

            proxy_set_header Connection "";

            proxy_pass [http://127.0.0.1:8088;](http://127.0.0.1:8088;/)

        }

    }  

**3启动ngrok：**

cd /usr/local/ngrok/bin/

nohup ./ngrokd -domain="[ngrok.loveweihai.com](http://ngrok.loveweihai.com/)" -httpAddr=":8088" -httpsAddr=":8281" &

/usr/local/ngrok/bin/ngrokd -domain="[ngrok.hwsmart.net](http://ngrok.hwsmart.net/)" -httpAddr=":8088" -httpsAddr=":8281" -tlsKey="/usr/local/ngrok/bin/snakeoil.key" -tlsCrt="/usr/local/ngrok/bin/snakeoil.crt"

关于https证书：参考

[https://blog.csdn.net/weixin_30824121/article/details/112035590](https://blog.csdn.net/weixin_30824121/article/details/112035590)

[https://letsencrypt.osfipin.com/](https://letsencrypt.osfipin.com/)

[https://ohttps.com/](https://ohttps.com/)

注意

1https要申请通配符证书，cert格式用fullchain文件

2linux使用客户端要注意文件权限问题 chmod -R  777  ngrok/

如果遇到国内服务器 编译时go get 拉取不到包的问题  看这里  [https://goproxy.io/zh/](https://goproxy.io/zh/)
