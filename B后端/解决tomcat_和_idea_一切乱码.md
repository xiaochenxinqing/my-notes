# 解决tomcat 和 idea 一切乱码

1、打开 tomcat 安装目录下的配置文件 conf/logging.[properties](https://so.csdn.net/so/search?q=properties&spm=1001.2101.3001.7020) ,将所有的GBK改为 UTF-8

2 idea启动配置中加入  -Dfile.encoding=UTF-8

3修改 IDEA 配置属性 HELP-> Edit Custom VM Options-> 添加 一行 -> 重启IDEA

-Dfile.encoding=UTF-8

! mysql安装时设置默认字符集为utf-8，同时新建数据库同时设置编码为“utf-8”;

！jdbc连接数据库设置，url的值也要设置utf-8；

！tomcat

    找到tomcat/conf/server.xml 在connecter标签中添加

      <connecter.............. URIEncoding="UTF-8">然后重启tomcat,

! 通过添加filter过滤器控制乱码(web.xml中)。

！cookies避免中文乱码：

  URLEncoder.encode(xxxxx,"UTF-8");传值

  URLDecoder.decode(xxxx，"UTF-8");取值
