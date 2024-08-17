# lwindows和linux 本地地址端口转发命令

windows:

netsh interface portproxy add v4tov4 8314 192.168.1.108 8314 127.0.0.1

netsh interface portproxy show all

netsh interface portproxy  reset

linux

# 配置转发端口

firewall-cmd --permanent --zone=public --add-rich-rule 'rule family="ipv4" source address="172.24.8.0/24" forward-port port="5423" protocol="tcp" to-port="80"'

# 生效配置

firewall-cmd --reload
