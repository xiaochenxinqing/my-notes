# 【SpringMVC转发和重定向】

**【SpringMVC】【请求转发和重定向】**

原创 2018年01月23日 17:15:01

**视图解析器**

    <bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">

        <property name="prefix" value="/WEB-INF/view/"/>

        <property name="suffix" value=".jsp"/>

    </bean>

- forward:请求转发(去前后缀)
- redirect:重定向．

**基于返回mv对象**

mv.setViewName("str");

- str=”forward : 路径” 　　　　　　　请求转发到一个jsp中
- str=”forward : controller的映射” 　请求转发到一个controller方法中
- str=”redirect: 路径” 　　　　　　　 请求转发到一个非WEB-INF的jsp

常用：

- str=”redirect : controller的映射” 　重定向到一个controller方法中
- str=”XXX” 　　　　　　　　　　　根据前后缀,**请求转发**到 前缀/XXX.后缀

**1:请求转发到jsp(默认的)**

    @RequestMapping("/method1")

    public ModelAndView method1(HttpServletRequest req,ModelAndView mv) throws Exception{

        //请求转发到/WEB-INF/view/main.jsp

        mv.setViewName("main");  //默认加入前后缀

        return mv;

    }

    //访问非视图解析器的视图时,用forward

    @RequestMapping("/method3")

    public ModelAndView method3(HttpServletRequest req,ModelAndView mv) throws Exception{

        mv.setViewName("forward:WEB-INF/view/main.jsp");  //不添加前后缀

        return mv;

    }

**2:请求转发到controller(必须用forward)**

    @RequestMapping("/method4")

    public ModelAndView method4(HttpServletRequest req,ModelAndView mv) throws Exception{

        mv.setViewName("forward:method1"); 

        return mv;

    }

**3:重定向到controller**

    @RequestMapping("/method5")

    public ModelAndView method5(HttpServletRequest req,ModelAndView mv) throws Exception{

        mv.setViewName("redirect:method3"); 

        return mv;

    }

**4:重定向到jsp**

    @RequestMapping("/method5")

    public ModelAndView method5(HttpServletRequest req,ModelAndView mv) throws Exception{

        mv.setViewName("redirect:index.jsp"); 

        return mv;

    }

**基于返回字符串**

**由于返回是字符串,所以mv的设置将没有作用,要用req来传送值**

- str=”forward : 路径” 　　　　　　　请求转发到一个jsp中
- str=”forward : controller的映射” 　请求转发到一个controller方法中
- str=”redirect: 路径” 　　　　　　　 请求转发到一个非WEB-INF的jsp

常用：

- str=”redirect : controller的映射” 　重定向到一个controller方法中
- str=”XXX” 　　　　　　　　　　　根据前后缀,**请求转发**到 前缀/XXX.后缀

    @RequestMapping("method1")

    public String method1() throws Exception{

        return "redirect:method2";

    }

    @RequestMapping("method2")

    public String method2() throws Exception{

        return "forward:WEB-INF/view/main.jsp";

    }
