# mybatis脏数据解决

为了提高项目的性能，减轻服务器压力，我们需要在项目中开启了二级缓存，但如果没有作其他处理，会导致经常读到脏数据。

对于我们这样的项目，要求每次读到的都要是最新的数据，出现这样的BUG是不能接受的，后来有幸读到几位大神的大作，

才让我等小白恍然大悟。解决方法有两种，一种是在配置的Mapper.xml文件中使用查询的方法添加useCache="false"。如：

<selectid="findOrderListResultMap" resultMap="ordersUserMap" useCache="false">  总结：针对每次查询都需要最

新的数据sql，要设置成useCache=false，禁用二级缓存。

另一种是方法的核心就是刷新缓存（就是清空缓存）在mapper的同一个namespace中，如果有其它insert、update、delete

操作数据后需要刷新缓存，如果不执行刷新缓存会出现脏读。设置statement配置中的flushCache="true" 属性，默认情况

下为true即刷新缓存，如果改成false则不会刷新。使用缓存时如果手动修改数据库表中的查询数据会出现脏读。

如下：

<insertid="insertUser" parameterType="cn.itcast.mybatis.po.User" flushCache="true">

总结：一般下执行完commit操作都需要刷新缓存，flushCache=true表示刷新缓存默认情况下为true,我们不用去设置它，

这样可以避免数据库脏读。
