# **一、配置IP**





**一、通过命令行配置(重启系统或网卡会失效)**

​    **#设置ens3网卡的静态ip和子网掩码****

**ip addr add 192.188.1.220/24 dev ens33**

**ifconfig ens33 192.188.1.220 netmask 255.255.255.0**    



 #   二、配置路由 #  

**ip route add default via 192.188.1.1    **

**route add default gw 192.188.1.1**#  设置系统默认路由



ip route add 192.168.2.0/24 via 192.168.1.1 设置192.168.2.0网段的网关为192.168.1.1

ip route add 192.168.4.0/24 via 192.168.0.254 dev eth0 设置192.168.4.0网段的网关为192.168.0.254,数据走eth0接口

ip route add default via 192.168.0.254 dev eth0 设置默认网关为192.168.0.254

ip route add default via 192.168.1.1 table 1 在一号表中添加默认路由为192.168.1.1

ip route add 192.168.0.0/24 via 192.168.1.2 table 1 在一号表中添加一条到192.168.0.0网段的路由为192.168.1.2

ip route add prohibit 209.10.26.51 设置请求的目的地不可达的路由

ip route add prohibit 209.10.26.51 from 192.168.99.35 假设您不想阻止所有用户访问此特定主机，则可以使用该from选项，阻止了源IP 192.168.99.35到达209.10.26.51

ip route change default via 192.168.99.113 dev eth0 更改默认路由。此操作等同于先删除，后新增





## 三、删除路由的语法

#### ✅ 1. 使用 `ip route` 删除路由

基本语法：

```
ip route del <目标网络> [via <网关>] [dev <接口>]
```

**示例 1：删除直连路由**

```
ip route del 192.168.10.0/24 dev eth0
```

**示例 2：删除指定网关的路由**

```
ip route del 10.0.0.0/8 via 192.168.1.1
```

**示例 3：删除默认路由**

```
ip route del default via 192.168.1.1
```

> 💡 可以先用 `ip route show` 查看当前所有路由，然后复制需要删除的那行，改成 `ip route del` 即可。

------

#### ✅ 2. 使用 `route` 命令删除路由

基本语法：

```
route del -net <目标网络> netmask <掩码> [gw <网关>] [dev <接口>]
```

**示例 1：删除直连路由**

```
route del -net 192.168.10.0 netmask 255.255.255.0 dev eth0
```

**示例 2：删除指定网关路由**

```
route del -net 10.0.0.0 netmask 255.0.0.0 gw 192.168.1.1
```

**示例 3：删除默认路由**

```
route del default gw 192.168.1.1
```



## 三、通过配置文件配置IP地址和网关



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



## 四、NMCLI方法配置

##添加连接 会在 /etc/sysconfig/network-scripts中添加文件持久化

nmcli con add con-name "新的 connection 名字"  type  ethernet  ifname  "对应device 名字"  ipv4.address  IP地址/子网掩码  ipv4.gateway IP网关地址 ipv4.dns DNS地址 ipv4.method manual     autoconnect yes  (将启动网卡设置 为固定IP地址)  

   注意: ipv4.method manual    不能省略

##更新连接

nmcli  con modify  [连接名称]  ipv4.address 192.188.1.103/24 ipv4.gateway 192.188.1.1 ipv4.method manual     ipv4.dns 8.8.8.8

##重载

nmcli con reload   这时候一般就能联了

##启动连接

nmcli con up  连接名

#开机自动连接

nmcli connection modify 连接名 connection.autoconnect yes

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

===========

默认路由可以有多个 但只有优先级最高的那个会生效

若插了不同网段的两根网线，则一般的后插的网线默认路由优先级高，原来的内网，同网段还是可以访问的，若要访问其他网段 需要添加路由



如

内网连了外网以后：

route PRINT -4查看 新连接带来的默认路由优先级更高，所有内网就只能访问192.168.18.xxx了，  192.188.1.x和192.188.4.x 都无法访问了，需要添加路由

route add 192.188.1.0 mask 255.255.255.0 192.168.18.1 metric 5 -p

route add 192.188.4.0 mask 255.255.255.0 192.168.18.1 metric 5 -p





##### 为社么用nmcli 命令添加 ipv4.gateway 会产生一条默认路由





**因为 `ipv4.gateway` 在 NetworkManager 的设计语义中，就是指“默认网关”。**

只要设置了这个值，NetworkManager 就会自动帮你生成一条指向 `0.0.0.0/0` 的默认路由。这是它的核心功能之一，而不是 bug。

这时候 nmcli show 连接名， 是看不到ipv4.routes的， 所以最好还是配置modify  ipv4.routes 来操作

———————

tips：如果配 ipv4.routes 会在 /etc/sysconfig/network-scripts/  额外成生成route-连接名这样的文件



**总结：**

   1）配置ip.address（等价于在ifcfg-xxx文件中配置IPADDR 和PREFIX） （192.188.1.68/24 ）   、

   2）配置ipv4.gateway（等价于在ifcfg-xxx文件中配置GATEWAY） 、    

   3）配置ipv4.routes（等价于route-xx文件中配置路由）, 

上述这三种行为都会产生路由，  其中配置ip会产生直接路由（U）， 后两种产生间接路由（UG）

一般建议用ip地址+ ipv4.routes 来配置



**注意：**

如果你想通过 **`nmcli` 命令**来配置 `ipv4.routes`，那么它**主要只支持带网关（`UG`）的路由**，对仅设备（`U`）的路由支持不足，不建议使用。”

ip route add 它可以产生两种路由：

- 如果写成 ip route ad`10.10.2.0/24 via 192.168.1.1` → 产生 **`UG`**（间接）。
- 如果写成 ip route ad  `10.10.2.0/24 dev eth0` → 产生 **`U`**（直接，无网关）。
  所以，它产生什么路由，取决于你配不配 `via` 网关。
