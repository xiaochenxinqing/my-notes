# docker 后台进程存在但是dockerps提示连不上

1删除docker0网卡

[ifconfig](https://so.csdn.net/so/search?q=ifconfig&spm=1001.2101.3001.7020) docker0 down

 yum -y install bridge-utils

 brctl delbr docker0

      2. find / - name  '*docker *'

 文件夹都删除 

 3重装docker 
