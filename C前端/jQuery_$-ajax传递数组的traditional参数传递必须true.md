# jQuery $.ajax传递数组的traditional参数传递必须true

# jQuery $.ajax传递数组的traditional参数传递必须true

2014年04月27日 11:48:38 [彭浩_JAVA](https://me.csdn.net/oJACKhao) 阅读数 20595

**起初我认为traditional:true,可有可无，但是后来不用traditional的时候，发现后台无法获取selectUsers的值，那么可以肯定的是traditional默认值是false.**

**当提交的参数是数组( {selectUsers:[value,value,value]} ),如果是false的话,则提交时会是"selectUsers[]=value&selectUsers[]=value"**

**如果设置成true,则提交时会是"selectUsers=value&selectUsers=value"**

**这样后台就能用String[] ids=request.getParameterValues("selectUsers"); 获取到值。**

**官方文档的解释如下：**

**traditional�**�

**类型：Boolean**

**如果你想要用传统的方式来序列化数据，那么就设置为 true。**

**Set this to true if you wish to use the traditional style of param serialization**
