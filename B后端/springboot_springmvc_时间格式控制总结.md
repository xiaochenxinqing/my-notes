

```
@NotBlank
```

# springboot springmvc 时间格式控制总结

### 1.前端→对象（验证）

       方法一：JSR303

```

    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private Date overdueBeginTime;
```

![](data:image/gif;base64,R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw== "点击并拖拽以移动")

  然后用BindingResult可以进行处理    

或者

   Jackson的@JsonFormat注解

```
@JsonFormat(pattern = "yyyy-MM-dd")
private Date appointTime; // 用户预约时间
```

![](data:image/gif;base64,R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw== "点击并拖拽以移动")

此处注意：当content-type为  application/json时，且该字段同时注解了@DateTimeFormat和@JsonFormat，会优先使用@JsonFormat进行验证

若当content-type  不是  application/json时 则会优先用 @DateTimeFormat来进行验证  

### 2对象→前端

a.若转为json：

  使用fastjson的@JsonField注解或jackson的@JsonFormat注解均可(springboot默认使用jackson，无需配置。若使用fastjson则需要配置)

```
@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm",timezone = "GMT+8")
```

![](data:image/gif;base64,R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw== "点击并拖拽以移动")

b.若为jsp模板展示：

   使用fmt来展示，如4

```
<input class="form-control " name="expectArriveTime" type="text"
value="<fmt:formatDate value="${repair.expectArriveTime}" pattern="yyyy-MM-dd HH:mm:ss"/>">
```

![](data:image/gif;base64,R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw== "点击并拖拽以移动")

  此时页面需要加

```
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
```

![](data:image/gif;base64,R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw== "点击并拖拽以移动")
