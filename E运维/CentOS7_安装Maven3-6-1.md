# CentOS7 安装Maven3.6.1

# **CentOS7 安装Maven3.6.1**

[![.png](image/.png)](https://www.jianshu.com/u/830d5fabc5ad)

[爱学习的蹭蹭](https://www.jianshu.com/u/830d5fabc5ad)

0.312019.07.28 06:54:55字数 693阅读 10,065

# **1、什么是Maven**

- Apache Maven是一个软件项目管理和理解工具。Maven基于项目对象模型(POM)的概念，可以从一个中心信息段管理项目的构建、报告和文档。

# **2、 Maven安装准备工作**

### **2.1** [Apache Maven官方网](https://links.jianshu.com/go?to=http%3A%2Fmaven.apache.org%2Fdownload.cgi)

![.webp](image/.webp)

image.png

- 点击下载即可或者Linux的wget命令下载，不同Linux有不同的命令，通过官方网的网站的，然后通过浏览器鼠标
- ![](https://upload-images.jianshu.io/upload_images/14586304-bd4167e95bb4b4c9.png?imageMogr2/auto-orient/strip|imageView2/2/w/778/format/webp)
    maven.png

# **2.2 下载**

- wget命令下载,但是必须要安装wget命令
- 安装命令：yum install -y wget

wget http://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/3.6.1/binaries/apache-maven-3.6.1-bin.tar.gz

# **3、指定文件目录安�**�

- 进入/usr/local/目录进行创建一个maven3文件夹
- 或者直接指定参数进行创建,-p(parent)，如果父目录下面的子目录无也进行创建

mkdir maven3 或

mkdir -p /usr/local/maven3

# **4、解压指定文件**

- 使用tar命令进行解压tar.gz文件

tar -zxvf apache-maven-3.6.1-bin.tar.gz

# **5、拷贝指定目录**

- 把解压的文件拷贝到指定目录
- -r 表示递归持续复制,用于目录的复制行为;
- 星号代表所有内容都进行拷贝

cp -r * /usr/local/maven3

# **6、配置环境变量**

### **6.1方法一、Vim命令进行编辑**

- 编辑profile文件进行配置环境变量

vim /etc/profile

- 配置的内容

# set mvn

export M2_HOME=/usr/local/maven3

export PATH=$PATH:$JAVA_HOME/bin:$M2_HOME/bin

### **6.2 方法二、echo命令进行修改**

- 两个>代表追加到指定的文件，且是追加到此文件的末尾行
- 而两个<表示shell的一个标识符的规范约束.
- EOF是一个shell的一个标识符，作用是标识shell脚本的开始<<EOF和结束EOF,可以任意字符，但是必须要有开始和结束，通常习惯用EOF.而且必须无有特殊字符：比如空格.

echo >> /etc/profile <<-EOF

export M2_HOME=/usr/local/maven3

export PATH=$PATH:$JAVA_HOME/bin:$M2_HOME/bin

EOF

### **6.3 source 命令**

- 重启加载profile让系统文件生效

source /etc/profile

### **6.4 验证是否安装成功**

mvn -version

//输出的内容

Apache Maven 3.6.1 (d66c9c0b3152b2e69ee9bac180bb8fcc8e6af555; 2019-04-05T03:00:29+08:00)

Maven home: /usr/local/maven3

Java version: 1.8.0_121, vendor: Oracle Corporation, runtime: /usr/local/jdk1.8/jre

Default locale: en_US, platform encoding: UTF-8OS name: "linux", version: "3.10.0-957.12.2.el7.x86_64", arch: "amd64", family: "unix"

> 查看是否生效，这里出现，Java version: 1.8.0_121, vendor: Oracle，因为Maven是依赖Jdk环境，故要安装jdk才能运行.
