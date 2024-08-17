# centos安装jdk

tar -xvf xxxxxx.tar.gz  

改名为jdk后移动到  /usr/local文件夹

然后 vim  /etc/profile 插入如下代码后保存退出

export JAVA_HOME=/usr/local/jdk

export PATH=$JAVA_HOME/bin:$PATH

export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

然后使其生效

source /etc/profile

检查版本，若显示则证明配置环境变量成功

java -version
