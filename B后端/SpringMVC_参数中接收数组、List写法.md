# SpringMVC 参数中接收数组、List写法

本文使用SpringMVC版本：

> org.springframework:spring-web:4.3.9.RELEASE

 

写法及说明(示例代码的**类上的注解是@RestController，所以方法上****不需要****添加@ResponseBody**）：

![](https://common.cnblogs.com/images/copycode.gif)

@RequestMapping("/hello")

public String test(String name,@RequestBody List<ForListReceive> list) {

/**

* 接收List的条件

* 1、使用JSON格式数据，如[{"a":"a","b":"b"}] 放在RequestBody中传递

* 2、RequestHeader中需要有 Content-Type: application/json;charset=utf8

* 3、需要在参数前加上@RequestBody

*/

System.out.println(list.get(0).getA());

return list.size()+":"+name;

}

@RequestMapping("/hi")

public String hi(@RequestParam("list") List<String> list) {

/**

* 接收List<String>

* 1、Request Parameters中list=a,b,c

* 2、必须写上@RequestParam("list")

*/

System.out.println(list.get(0));

return list.size()+"";

}

@RequestMapping("/hey")

public String hey(String[] list) {

/**

* 接收数组

* 1、Request Parameters中list=a,b,c 即可成功接收

*/

System.out.println(list[0].toString());

System.out.println(list[1].toString());

return list.length+"";

}
