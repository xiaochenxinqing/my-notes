# tomcat提示后台缓存收回进程无法释放上下文[/BUSINESS的缓存的[10]%-请考虑增加缓存的最大大小

Tomcat启动时提示：“后台缓存收回进程无法释放上下文[/BUSINESS的缓存的[10]%-请考虑增加缓存的最大大小”;

原因：出现该问题是Tomcat启动时，占用的缓存较大，Tomcat默认的缓存是10000KB.

解决：需要调整Tomcat目录下Tomcat8.5.73\conf\context.xml文件中的缓存的最大值，需要添加在<Context></Context>标签内，添加项如下

<Resources cachingAllowed="true" cacheMaxSize="8000000" />
