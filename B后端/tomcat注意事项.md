# tomcat注意事项

###############tomcat 重新加载修改后的class导致session中的值丢失问题,解决办法

博客分类： Web技术问题

TomcatJava

在项目开发阶段,我们服务器使用的是tomcat。通常我们在改变java文件后,不想重启服务器,可以要tomcat连接池中配置文件中加上 reloadable = true 。这样tomcat就支持热部署.即修改java文件后tomcat会自动加载class文件.

如此一来,就能马上看到改变后的效果.

    但是,同时会带来 session中存放的对象丢失的情况.即session对象为 null .我们在项目开发阶段一直没有找到原因.后来,受网上一篇文章的启发.将要放到session中的对象实现序列化接口(Serializable ).

  结果经测试果然如此,session不会过期.里面仍然有值.这样,不用每次过期之后就跳到登录页面了.

现贴出代码

   public class DataTable implements Serializable {

      内容省略......

    }

存放到session中的 DataTable对象

DataTable dtMFList = new LoginDAO().GetMFList(model.getUserid(),model.getOrgid(),model.getSystemid());

     session.setAttribute(dtMFList,dtMFList); 实现序列化后session就不会失效

############设置内存和指定jdk版本#############

编辑bin/catalina.sh

JAVA_HOME=/usr/java/jdk/jdk1.7.0_79

JAVA_OPTS="-server -XX:PermSize=256M -XX:MaxPermSize=512m"

############设置根路径为某项目##############

<Host name="localhost" unpackWARs="true" autoDeploy="false">

        <Context path="" docBase="/usr/java/tomcat/server/webapps/ECWeb_war" />

       

</Host>

############统一服务器上多个tomcat###########

要注意修改server.xml中的3个端口，都不能相同

############上传文件路径分离###############

############解决GET中文乱码###############
