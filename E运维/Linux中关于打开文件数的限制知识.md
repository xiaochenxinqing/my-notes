# Linux中关于打开文件数的限制知识

正常情况下， /etc/security/limits.conf 的改动，应该在下次访问时就生效才对。

一、修改方法

1.临时方法

为了优化linux性能，可能需要修改这个最大值。临时修改的话ulimit -n 204800就可以了，重启后失效!且仅对当前会话有效。

2.永久生效方法

(1)、修改/etc/security/limits.conf文件 在文件末尾添加如下内容，

* soft nofile 204800

* hard nofile 204800

* soft nproc 204800

* hard nproc 204800

然后重启服务器或重新登录即可生效。重启后用查看命令进行查看，如果显示数字等于204800即证明修改成功。如果不成功请继续往下看。

查看命令:(-n是可以打开最大文件描述符的数量。 -u是用户最大可用的进程数。)

ulimit -n

ulimit -u

我在解决这个问题时候，发现网上都是说修改这一个文件就行，但是我修改后重启服务器发现没更改过来。

后来发现，还需要修改两个文件。如果你重启后也没生效，请继续跟着往下修改。

注：在修改下面(2)、(3)所示的这些文件时候，有些文件可能并不存在，或者90-nproc.conf没有，但是有20-nproc.conf，建议从根路径下，自己亲自cd进去。然后一步步找到目标文件。如果90-nproc.conf不存在，修改类似的文件即可，即xx-nproc.conf。

(2)、/etc/security/limits.d/90-nproc.conf文件尾添加

* soft nproc 204800

* hard nproc 204800

(3)、/etc/security/limits.d/def.conf文件尾添加

* soft nofile 204800

* hard nofile 204800

修改后，重启服务器，继续用查看命令查看，如果还是没解决，继续往下看。

4) /etc/systemd/system.conf

末尾添加

DefaultLimitNOFILE=65536

DefaultLimitNPROC=65535

二、不生效原因及解决方案

1. 确保 pam 生效

在 /etc/pam.d/login 中，存在:

session required pam_limits.so

2. 确保 ssh 使用 pam

在 /etc/pam.d/sshd 中，存在:

session required pam_limits.so

在 /etc/ssh/ssd_config 中, 存在:

UsePAM yes

3. limits.conf 建议不要使用星号

官方 manual 以及网上的教程有很多都用了 * 符号，然而不是所有系统都认的，比如我在解决这个问题时候，发现ubuntu系统就不支持。最前面一列代表用户名即root和evan。

不兼容方式:

* soft nofile 204800

* hard nofild 204800

兼容方式

root soft nofile 204800

root hard nofile 204800

evan soft nofile 204800

evan hard nofile 204800

**=========相关命令=========**

查看某个进程号当前打开的文件数 :

        lsof -p 进程号 | wc -l

查看当前shell 会话（以及从这个 shell 启动的进程，如 Nginx）可以打开的最大文件数 :     

       ulimit -n (等价于ulimit -Sn 软限制, 硬限制是 -Hn)

查看单个进程当前允许打开的最大文件数

prlimit --pid <PID> --nofile 

         或  cat /proc/<PID>/limits | grep "Max open files"

临时设置单个进程当前允许打开的最大文件数

prlimit --pid <PID> --nofile=1024:2048

--------------------------------------------------

**疑问一:**

ulimit -n 查看到当前用户进程允许打开的最大文件数是1024  为何用prlimit查到的某进程允许的最大文件数为524288  (不一致)

**答:**  该进程在启动时或运行过程中提高了其文件描述符限制

--------------------------------------------------

**疑问二**

既然prlimit查到的某进程最大文件数为524288，为何lsof -p 进程号 | wc -l 查看到已打开的文件数为65570， 就无法再打开文件了 

**答:** 你的限制是这么大没错,但是 还有其他进程啊,也会抢占资源 

可以/proc/sys/fs/file-max查看系统允许同时打开的文件描述符的最大数量。这个值是全系统范围内的，即所有进程加起来的最大文件描述符数  (而/etc/security/limits.conf是控制当前用户进程的限制的)

总结:还是要在根源上(编码上)减少打开文件数,这才是正途

进程树 : 子进程可以自由定义最大打开文件数,,可以超过父进程的软限制(只要root用户可以,但由于基本都是root用户执行, 所以软限制等于形同虚设)   但子进程的最大打开文件数不会超过父进程的硬限制(root用户也不行)     

查看进程树  ps -elf  

查看某进程的父进程号:   ps -o ppid= -p <PID> 

查看与特定进程相关的网络连接

netstat -p | grep <PID>

坑:父进程是systemd 也不一定最大文件打开数就继承父进程 有可能systemd只是继父进程 
