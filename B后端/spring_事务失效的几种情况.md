# spring 事务失效的几种情况

[https://blog.csdn.net/mameng1988/article/details/85548812](https://blog.csdn.net/mameng1988/article/details/85548812)

[https://cloud.tencent.com/developer/beta/article/1497700](https://cloud.tencent.com/developer/beta/article/1497700)

# [同一个类中@Transactional 事务失效](https://www.cnblogs.com/guobi777/p/13883062.html "发布于 2020-10-27 09:20")

**1.在同一个类中一个没有事务 A 的方法调用另个有事务 B 的方法，那么那个有事务 B 的方法是失效的；**

![复制代码](https://assets.cnblogs.com/images/copycode.gif)public class test {      public void a() {          this.b();     }      @Transactional     public void b() {         /* … */     } }
![复制代码](https://assets.cnblogs.com/images/copycode.gif)**2.如果有事务 A 方法调用没有（或者有）事务 B 的方法，那么事务 A 都会生效，而方法 B 不会生效；**

![复制代码](https://assets.cnblogs.com/images/copycode.gif)public class test {      @Transactional     public void a() {          this.b();     }      @Transactional     // @Transactional     public void b() {         /* … */     } }
![复制代码](https://assets.cnblogs.com/images/copycode.gif)**3.但是如果是不同类的话就都会生效；**

# **总结�**�

**我们调用的方法A不带注解，因此代理类不开事务，而是直接调用目标对象的方法。当进入目标对象的方法后，执行的上下文已经变成目标对象本身了，因为目标对象的代码是我们自己写的，和事务没有半毛钱关系，此时你再调用带注解的方法，照样没有事务，只是一个普通的方法调用而已。简单来说，内部调用本类方法，不会再走代理了，所以B的事务不起作用。**

### 解决方案：

1. 可以将方法放入另一个类，并且该类通过spring注入，即符合了在对象之间调用的条件。
2. 获取本对象的代理对象，再进行调用。具体操作如：  1）Spring-content.xml上下文中，增加配置：<aop:aspectj-autoproxy expose-proxy=“true”/>  2）在xxxServiceImpl中，用(xxxService)(AopContext.currentProxy())，获取到xxxService的代理类，再调用事务方法，强行经过代理类，激活事务切面。 

1. public class test {      @Transactional     public void a() {          (test)(AopContext.currentProxy()).b();     }      @Transactional     // @Transactional     public void b() {         /* … */     } }

![](data:image/gif;base64,R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw==)1. 当然也可以@Autowired 注入自己来调用方法解决。
2. 把注解加到类名上面。

 
