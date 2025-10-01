**二,通过命令行配置(重启系统或网卡会失效)**

**ifconfig ens33 192.188.1.220 netmask 255.255.255.0  设置ens3网卡的静态ip和子网掩码**

**ip route add default via 192.188.1.1 设置系统默认路由**

ip route add 192.168.2.0/24 via 192.168.1.1 设置192.168.2.0网段的网关为192.168.1.1

ip route add 192.168.4.0/24 via 192.168.0.254 dev eth0 设置192.168.4.0网段的网关为192.168.0.254,数据走eth0接口

ip route add default via 192.168.0.254 dev eth0 设置默认网关为192.168.0.254

ip route add default via 192.168.1.1 table 1 在一号表中添加默认路由为192.168.1.1

ip route add 192.168.0.0/24 via 192.168.1.2 table 1 在一号表中添加一条到192.168.0.0网段的路由为192.168.1.2

ip route add prohibit 209.10.26.51 设置请求的目的地不可达的路由

ip route add prohibit 209.10.26.51 from 192.168.99.35 假设您不想阻止所有用户访问此特定主机，则可以使用该from选项，阻止了源IP 192.168.99.35到达209.10.26.51

ip route change default via 192.168.99.113 dev eth0 更改默认路由。此操作等同于先删除，后新增



**一、通过配置文件配置IP地址和网关（network）：**

1、修改网卡配置文件

vim /etc/sysconfig/network-scripts/ifcfg-eth0

改BOOTPROTO="dhcp" 自动获取IP

ONBOOT="yes" 开机自动启用网卡

2、静态IP地址。

vim /etc/sysconfig/network-scripts/ifcfg-eth0  

ifcfg-eth0文件中dhcp改为静态IP，需要改 BOOTPROTO=static

并且添加下面三行参数，IP地址、子网掩码、网关

IPADDR=192.168.2.41

NETMASK=255.255.255.0

GATEWAY=192.168.2.1

 修改完后重启网卡

    systemctl restart network

二、通过配置文件配置IP地址和网关（ubuntu （18.04）netplan）：

cd /etc/netplan 修改相应配置文件



**=========nmcli命令===========**

##添加连接 会在 /etc/sysconfig/network-scripts中添加文件持久化

nmcli con add con-name "新的 connection 名字"  type  ethernet  ifname  "对应device 名字"  ipv4.address  IP地址/子网掩码  ipv4.gateway IP网关地址 ipv4.dns DNS地址 ipv4.method manual (将启动网卡设置 为固定IP地址)  

   注意: ipv4.method manual    不能省略

##更新连接

nmcli  con modify  [连接名称]  ipv4.address 192.188.1.103/24 ipv4.gateway 192.188.1.1 ipv4.method manual     ipv4.dns 8.8.8.8

##重载

nmcli con reload   这时候一般就能联了

##启动连接

nmcli con up  连接名

#开机自动连接

nmcli connection modify MyWiFi connection.autoconnect yes

##其他

nmcli dev con 设备名   

(注意:  nmcli con up 和 nmcli dev con 都会立即让新网络设置生效,   但  nmcli dev con会导致这个设备随机连接该设备下的某个链接,所以最好用上面的con up)



iptable防火墙：：

```SQL
iptables -P INPUT ACCEPT
iptables -F
iptables -vL

sudo tcpdump -i eth0 port 2181 -w /mnt/dbsec/2181.pcap
```
