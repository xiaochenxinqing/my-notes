# linux 安装node

### 一、进入/usr/local目录中

cd /usr/local

### 二、下载源码包

**1.访问：**[http://nodejs.cn/download/](https://links.jianshu.com/go?to=http%3A%2F%2Fnodejs.cn%2Fdownload%2F)

下载包

**2.获取到下载地址使用wget命令下载(注意下载对应服务器的版本)**

wget https://npm.taobao.org/mirrors/node/v14.15.4/node-v14.15.4-linux-x64.tar.xz

### 三、解压并改名 

xz -d node-v14.15.4-linux-x64.tar.xz

tar -xvf node-v14.15.4-linux-x64.tar

mv  node-v14.15.4-linux-x64  node

### 四、软链

ln -s /usr/local/node/bin/node  /usr/bin/node

ln -s /usr/local/node/bin/npm  /usr/bin/npm

### 五、查看是否安装成功

node -v

npm config set registry https://registry.npmmirror.com

npm install @vue/cli-service -g

