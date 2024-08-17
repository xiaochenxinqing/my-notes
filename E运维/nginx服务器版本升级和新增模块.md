# nginx服务器版本升级和新增模块

需求：Nginx的版本最开始使用的是Nginx-1.14.2,由于服务升级，需要将Nginx的版本升级到Nginx-1.16.1,要求Nginx不能中断提供服务。

为了应对上述的需求，这里我们给大家提供两种解决方案:

方案一:使用Nginx服务信号完成Nginx的升级

方案二:使用Nginx安装目录的make命令完成升级

**环境准备**

（1）先准备两个版本的Nginx分别是 1.14.2和1.16.1

（2）使用Nginx源码安装的方式将1.14.2版本安装成功并正确访问

进入安装目录

./configure

make && make install

1

2

3

（3）将Nginx1.16.1进行参数配置和编译，不需要进行安装。

进入安装目录

./configure

make

**方案一:使用Nginx服务信号进行升级**

第一步:将1.14.2版本的sbin目录下的nginx进行备份

cd /usr/local/nginx/sbin

mv nginx nginxold

第二步:将Nginx1.16.1安装目录编译后的objs目录下的nginx文件，拷贝到原来/usr/local/nginx/sbin目录下

cd ~/nginx/core/nginx-1.16.1/objs

cp nginx /usr/local/nginx/sbin

第三步:发送信号USR2给Nginx的1.14.2版本对应的master进程

会生成一个新的master,和worker进程，并将老的进程号记录在nginx.pid.oldbin下

kill -USR2 `cat /usr/local/nginx/logs/nginx.pid`

第四步:发送信号QUIT给Nginx的1.14.2版本对应的master进程

kill -QUIT `more /usr/local/logs/nginx.pid.oldbin`

完成后查看进程以及查看版本

ps -ef|grep nginx

./nginx -V

**方案二:使用Nginx安装目录的make命令完成升级**

第一步:将1.14.2版本的sbin目录下的nginx进行备份

cd /usr/local/nginx/sbin

mv nginx nginxold

第二步:将Nginx1.16.1安装目录编译后的objs目录下的nginx文件，拷贝到原来/usr/local/nginx/sbin目录下

cd ~/nginx/core/nginx-1.16.1/objs

cp nginx /usr/local/nginx/sbin

第三步:进入到Nginx1.16.1的安装目录，执行make upgrade

第四步:查看是否更新成功

./nginx -v

在整个过程中，其实Nginx是一直对外提供服务的。并且当Nginx的服务器启动成功后，我们是可以通过浏览器进行直接访问的，同时我们可以通过更改html目录下的页面来修改我们在页面上所看到的内容，那么问题来了，为什么我们要修改html目录下的文件，能不能多添加一些页面是Nginx的功能更加丰富，还有前面聊到Nginx的前端功能又是如何来实现的，这就需要我们对Nginx的核心配置文件进行一个详细的学习。

添加，删减模块

到nginx的安装目录下面

./confgiure --without

./configure --add

make
