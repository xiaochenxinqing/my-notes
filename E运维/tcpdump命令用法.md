# tcpdump命令用法

## 实战：基础用法

我们先通过几个简单的示例来介绍 tcpdump 基本用法。

1. 不加任何参数，默认情况下将抓取第一个非 lo 网卡上所有的数据包

$ tcpdump

2. 抓取 eth0 网卡上的所有数据包

$ tcpdump -i eth0

3. 抓包时指定 -n 选项，不解析主机和端口名。这个参数很关键，会影响抓包的性能，一般抓包时都需要指定该选项。

$ tcpdump -n -i eth0

4. 抓取指定主机 192.168.1.100 的所有数据包

$ tcpdump -ni eth0 host 192.168.1.100

5. 抓取指定主机 10.1.1.2 发送的数据包

$ tcpdump -ni eth0 src host 10.1.1.2

6. 抓取发送给 10.1.1.2 的所有数据包

$ tcpdump -ni eth0 dst host 10.1.1.2

7. 抓取 eth0 网卡上发往指定主机的数据包，抓到 10 个包就停止，这个参数也比较常用

$ tcpdump -ni eth0 -c 10 dst host 192.168.1.200

8. 抓取 eth0 网卡上所有 SSH 请求数据包，SSH 默认端口是 22

$ tcpdump -ni eth0 dst port 22

9. 抓取 eth0 网卡上 5 个 ping 数据包

$ tcpdump -ni eth0 -c 5 icmp

10. 抓取 eth0 网卡上所有的 arp 数据包

$ tcpdump -ni eth0 arp

11. 使用十六进制输出，当你想检查数据包内容是否有问题时，十六进制输出会很有帮助。

$ tcpdump -ni eth0 -c 1 arp -X

listening on eth0， link-type EN10MB （[Ethernet](http://www.elecfans.com/tags/ethernet/)）， capture size 262144 bytes

1231.602995 ARP， Request who-has 172.17.92.133 tell 172.17.95.253， length 28

0x0000： 0001 0800 0604 0001 eeff ffff ffff ac11 。。。。。。。。。。。。。。。。

0x0010： 5ffd 0000 0000 0000 ac11 5c85 _.。。。。。。。。。

12. 只抓取 eth0 网卡上 IPv6 的流量

$ tcpdump -ni eth0 ip6

13. 抓取指定端口范围的流量

$ tcpdump -ni eth0 portrange 80-9000

14. 抓取指定网段的流量

$ tcpdump -ni eth0 net 192.168.1.0/24

## 实战：高级进阶

tcpdump 强大的功能和灵活的策略，主要体现在过滤器（BPF）强大的表达式组合能力。

本节主要分享一些常见的所谓高级用法，希望读者能够举一反三，根据自己实际需求，来灵活使用它。

1. 抓取指定客户端访问 ssh 的数据包

$ tcpdump -ni eth0 src 192.168.1.100 and dst port 22

2. 抓取从某个网段来，到某个网段去的流量

$ tcpdump -ni eth0 src net 192.168.1.0/16 and dst net 10.0.0.0/8 or 172.16.0.0/16

3. 抓取来自某个主机，发往非 ssh 端口的流量

$ tcpdump -ni eth0 src 10.0.2.4 and not dst port 22

4. 当构建复杂查询的时候，你可能需要使用引号，单引号告诉 tcpdump 忽略特定的特殊字符，这里的 （） 就是特殊符号，如果不用引号的话，就需要使用转义字符

$ tcpdump -ni eth0 ‘src 10.0.2.4 and （dst port 3389 or 22）’

5. 基于包大小进行筛选，如果你正在查看特定的包大小，可以使用这个参数

小于等于 64 字节：

$ tcpdump -ni less 64

大于等于 64 字节：

$ tcpdump -ni eth0 greater 64

等于 64 字节：

$ tcpdump -ni eth0 length == 64

6. 过滤 TCP 特殊标记的数据包

抓取某主机发送的 [RS](http://www.elecfans.com/tags/rs/)T 数据包：

$ tcpdump -ni eth0 src host 192.168.1.100 and ‘tcp［tcpflags］ & （tcp-rst） ！= 0’

抓取某主机发送的 SYN 数据包：

$ tcpdump -ni eth0 src host 192.168.1.100 and ‘tcp［tcpflags］ & （tcp-syn） ！= 0’

抓取某主机发送的 FIN 数据包：

$ tcpdump -ni eth0 src host 192.168.1.100 and ‘tcp［tcpflags］ & （tcp-fin） ！= 0’

抓取 TCP 连接中的 SYN 或 FIN 包

$ tcpdump ‘tcp［tcpflags］ & （tcp-syn|tcp-fin） ！= 0’

7. 抓取所有非 ping 类型的 ICMP 包

$ tcpdump ‘icmp［icmptype］ ！= icmp-echo and icmp［icmptype］ ！= icmp-echoreply’

8. 抓取端口是 80，网络层协议为 IPv4， 并且含有数据，而不是 SYN、FIN 以及 ACK 等不含数据的数据包

$ tcpdump ‘tcp port 80 and （（（ip［2:2］ - （（ip［0］&0xf）《《2）） - （（tcp［12］&0xf0）》》2）） ！= 0）’

解释一下这个复杂的表达式，具体含义就是，整个 IP 数据包长度减去 IP 头长度，再减去 TCP 头的长度，结果不为 0，就表示数据包有 data，如果还不是很理解，需要自行补一下 tcp/ip 协议

9. 抓取 HTTP 报文，0x4754 是 GET 前两字符的值，0x4854 是 HTTP 前两个字符的值

$ tcpdump -ni eth0 ‘tcp［20:2］=0x4745 or tcp［20:2］=0x4854’
