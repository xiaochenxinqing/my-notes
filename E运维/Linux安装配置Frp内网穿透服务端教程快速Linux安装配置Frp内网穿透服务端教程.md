# Linux安装配置Frp内网穿透服务端教程快速Linux安装配置Frp内网穿透服务端教程

# 快速Linux安装配置Frp内网穿透服务端教程

**必要条件是需要一台公网固定IP的服务器来安装frp服务器端，如果没有的话以下内容就看个乐呵。**

## 安装frps文件

### 进入安装目录(本文以/usr/local/为例)

cd /usr/local

### 官方下载frp最新版[Releases · fatedier/frp · GitHub](https://github.com/fatedier/frp/releases)

wget https://[github.com/fatedier/frp/releases/download/v0.28.2/frp_0.28.2_linux_amd64.tar.gz](http://github.com/fatedier/frp/releases/download/v0.28.2/frp_0.28.2_linux_amd64.tar.gz)

### 解压文件

tar -xzvf frp_0.28.2_linux_amd64.tar.gz

### 

### 拷贝下载的服务器端文件到frps文件夹

mv frp_0.28.2_linux_amd64 frp

### 删除无用文件和文件夹

rm -rf frp_0.28.2_linux_amd64 frp_0.28.2_linux_amd64.tar.gz

### 然后试着运行一下frps，看看是否能正常运行

cd frp

./frps --help

正常显示如下：

root@SteelblueVirtuous-VM:/usr/local/frps# ./frps --help

frps is the server of frp (https://[github.com/fatedier/frp](http://github.com/fatedier/frp))

Usage:

frps [flags]

Flags:

--allow_ports string allow ports

--bind_addr string bind address (default "0.0.0.0")

-p, --bind_port int bind port (default 7000)

--bind_udp_port int bind udp port

-c, --config string config file of frps

--dashboard_addr string dasboard address (default "0.0.0.0")

--dashboard_port int dashboard port

--dashboard_pwd string dashboard password (default "admin")

--dashboard_user string dashboard user (default "admin")

-h, --help help for frps

--kcp_bind_port int kcp bind udp port

--log_file string log file (default "console")

--log_level string log level (default "info")

--log_max_days int log max days (default 3)

--max_ports_per_client int max ports per client

--proxy_bind_addr string proxy bind address (default "0.0.0.0")

--subdomain_host string subdomain host

-t, --token string auth token

-v, --version version of frpc

--vhost_http_port int vhost http port

--vhost_http_timeout int vhost http response header timeout (default 60)

--vhost_https_port int vhost https port

如果提示-bash: ./frps: cannot execute binary file: Exec format error就说明你下错版本了

## 配置frps

### 编辑frps.ini文件

vi frps.ini

修改参照

参考以下配置说明来书写配置文件frps.ini，你可以先在电脑上打一份草稿

此处只解释说明一些必要和常用的配置，如需研究完整配置说明请看目录下的frps_full.ini，以及参考[frp中文说明](https://github.com/fatedier/frp/blob/master/README_zh.md)

# 下面这句开头必须要有，表示配置的开始

[common]

# frp [服务端](https://stgod.com/tag/%e6%9c%8d%e5%8a%a1%e7%ab%af/ "查看与 服务端 相关的文章")[端口](https://stgod.com/tag/%e7%ab%af%e5%8f%a3/ "查看与 端口 相关的文章")（必须）

bind_port = 7000

# frp [服务端](https://stgod.com/tag/%e6%9c%8d%e5%8a%a1%e7%ab%af/ "查看与 服务端 相关的文章")密码（必须）

token = 12345678

# 认证超时时间，由于时间戳会被用于加密认证，防止报文劫持后被他人利用# 因此[服务端](https://stgod.com/tag/%e6%9c%8d%e5%8a%a1%e7%ab%af/ "查看与 服务端 相关的文章")与客户端所在[机器](https://stgod.com/tag/%e6%9c%ba%e5%99%a8/ "查看与 机器 相关的文章")的时间差不能超过这个时间（秒）# 默认为900秒，即15分钟，如果设置成0就不会对报文时间戳进行超时验证

authentication_timeout = 900

# 仪表盘[端口](https://stgod.com/tag/%e7%ab%af%e5%8f%a3/ "查看与 端口 相关的文章")，只有设置了才能使用仪表盘（即后台）

dashboard_port = 7500

# 仪表盘访问的[用户](https://stgod.com/tag/%e7%94%a8%e6%88%b7/ "查看与 用户 相关的文章")名密码，如果不设置，则默认都是 admin

dashboard_user = admin

dashboard_pwd = admin

# 如果你想要用 frp 穿透访问内网中的[网站](https://stgod.com/tag/%e7%bd%91%e7%ab%99/ "查看与 网站 相关的文章")（例如路由器设置页面）# 则必须要设置以下两个监听[端口](https://stgod.com/tag/%e7%ab%af%e5%8f%a3/ "查看与 端口 相关的文章")，不设置则不会开启这项功能

vhost_http_port = 10080

vhost_https_port = 10443

#日志路径#日志记录级别#日志保留天数

log_file = /usr/local/frp/frps.log

log_level = de[bug](https://stgod.com/tag/bug/ "查看与 bug 相关的文章")

log_max_days = 7

# 此设置需要配合客户端设置，仅在穿透到内网中的 http 或 https 时有用（可选）# 假设此项设置为 [example.com](http://example.com/)，客户端配置 http 时将 subdomain 设置为 test，# 则你将 [test.example.com](http://test.example.com/) 解析到[服务端](https://stgod.com/tag/%e6%9c%8d%e5%8a%a1%e7%ab%af/ "查看与 服务端 相关的文章")后，可以使用此域名来访问客户端对应的 http

subdomain_host = frp.loveweihai.com

然后把你的准备好的配置文件内容写入frps.ini

更多配置参考:[GitHub](https://github.com/fatedier/frp/blob/master/README_zh.md)[官方](https://github.com/fatedier/frp/blob/master/README_zh.md)[README](https://github.com/fatedier/frp/blob/master/README_zh.md)[.](https://github.com/fatedier/frp/blob/master/README_zh.md)[md](https://github.com/fatedier/frp/blob/master/README_zh.md)[说明](https://github.com/fatedier/frp/blob/master/README_zh.md)

[GitHub](https://github.com/fatedier/frp/blob/master/conf/frps_full.ini)[官方](https://github.com/fatedier/frp/blob/master/conf/frps_full.ini)[frps](https://github.com/fatedier/frp/blob/master/conf/frps_full.ini)[.](https://github.com/fatedier/frp/blob/master/conf/frps_full.ini)[ini](https://github.com/fatedier/frp/blob/master/conf/frps_full.ini)[说明](https://github.com/fatedier/frp/blob/master/conf/frps_full.ini)

注意:阿里云腾讯云服务器需在安全组添加7000,6443[端口](https://stgod.com/tag/%e7%ab%af%e5%8f%a3/ "查看与 端口 相关的文章")开放,如果使用到了各种j集成环境面板，例如宝塔面板也需要添加[端口](https://stgod.com/tag/%e7%ab%af%e5%8f%a3/ "查看与 端口 相关的文章")放行。

## 启动frps

### 启动frps命令

cd /usr/local/frp #先进入安装目录，再执行下面的启动Frp命令./frps -c ./frps.ini

### 保持后台运行frps命令

nohup ./frps -c ./frps.ini &

## 配置systemctl来控制frp

### 创建frp.service

sudo vim /lib/systemd/system/frp.service

### 在frps.service里添加以下内容

[Unit]Description=frp service

After=network.target syslog.target

Wants=network.target

[Service]Type=simple

ExecStart=/usr/local/frp/frps -c /usr/local/frp/frps.ini //启动服务的命令（此处写你的frps的实际安装目录）

[Install]WantedBy=multi-user.target

> 注意"ExecStart="之后的路径要填写你的frps安装路径(本文以安装到/usr/local/为例)

ESC退出编辑

输入:wq回车即可保存

## 使用systemctl命令来控制frps

### 启动frps

sudo systemctl start frp

### 服务器开机自动启动frps

sudo systemctl enable frp

### 重启frps

sudo systemctl restart frp

### 停止frps

sudo systemctl stop frp

### 查看日志

sudo systemctl status frp

## 检查服务器端安装情况

浏览器输入服务器IP访问[http://xxx.xxx.xxx.xxx:7500](http://xxx.xxx.xxx.xxx:7500/)来查看frps服务状态。

客户端下载[https://blog.csdn.net/pariese/article/details/118386759](https://blog.csdn.net/pariese/article/details/118386759)
