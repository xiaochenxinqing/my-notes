# SpringBoot 还在用 if 校验参数？那你真的太low了，老司机都是这么玩的！

# SpringBoot 还在用 if 校验参数？那你真的太low了，老司机都是这么玩的！

Java基基

_2024-02-03 18:10_

_发表于上海_

👉 **这是一个或许对你有用的社群**

🐱 一对一交流/面试小册/简历优化/求职解惑，欢迎加入「[**芋道快速开发平台**](http://mp.weixin.qq.com/s?__biz=MzUzMTA2NTU2Ng==&mid=2247576697&idx=1&sn=a5f8a37fe0c6f05509c5bed6244471a8&chksm=fa4bd3c8cd3c5aded28a6b68a9944ce671f3d2748644f71550c0468d75058e90dd378a1babe8&scene=21#wechat_redirect)」知识星球。下面是星球提供的部分资料： 

- [《项目实战（视频）》](http://mp.weixin.qq.com/s?__biz=MzUxOTc4NjEyMw==&mid=2247561735&idx=1&sn=1b0a95d87fc647c3cf5e2b88576a8f55&chksm=f9f7e9e3ce8060f5809daa189fea465e95fa5445797f96fd8023f424c2acf4d31751a62792fc&scene=21#wechat_redirect)：从书中学，往事中**“练****”**
- [《互联网高频面试题》](http://mp.weixin.qq.com/s?__biz=MzUxOTc4NjEyMw==&mid=2247561735&idx=1&sn=1b0a95d87fc647c3cf5e2b88576a8f55&chksm=f9f7e9e3ce8060f5809daa189fea465e95fa5445797f96fd8023f424c2acf4d31751a62792fc&scene=21#wechat_redirect)：面朝简历学习，春暖花开
- [《架构 x 系统设计》](http://mp.weixin.qq.com/s?__biz=MzUxOTc4NjEyMw==&mid=2247561735&idx=1&sn=1b0a95d87fc647c3cf5e2b88576a8f55&chksm=f9f7e9e3ce8060f5809daa189fea465e95fa5445797f96fd8023f424c2acf4d31751a62792fc&scene=21#wechat_redirect)：摧枯拉朽，掌控面试高频场景题
- [《精进 Java 学习指南》](http://mp.weixin.qq.com/s?__biz=MzUxOTc4NjEyMw==&mid=2247561735&idx=1&sn=1b0a95d87fc647c3cf5e2b88576a8f55&chksm=f9f7e9e3ce8060f5809daa189fea465e95fa5445797f96fd8023f424c2acf4d31751a62792fc&scene=21#wechat_redirect)：系统学习，互联网主流技术栈
- [《必读 Java 源码专栏》](http://mp.weixin.qq.com/s?__biz=MzUxOTc4NjEyMw==&mid=2247561735&idx=1&sn=1b0a95d87fc647c3cf5e2b88576a8f55&chksm=f9f7e9e3ce8060f5809daa189fea465e95fa5445797f96fd8023f424c2acf4d31751a62792fc&scene=21#wechat_redirect)：知其然，知其所以然

![.jpg](image/.jpg)

👉**这是一个或许对你有用的开源项目**

国产 Star 破 10w+ 的开源项目，前端包括管理后台 + 微信小程序，后端支持单体和微服务架构。

功能涵盖 RBAC 权限、SaaS 多租户、数据权限、商城、支付、工作流、大屏报表、微信公众号等等功能：

- Boot 仓库：https://gitee.com/zhijiantianya/ruoyi-vue-pro
- Cloud 仓库：https://gitee.com/zhijiantianya/yudao-cloud
- 视频教程：https://doc.iocoder.cn

【国内首批】支持 JDK 21 + SpringBoot 3.2.2、JDK 8 + Spring Boot 2.7.18 双版本 

[来源：juejin.im/post/](https://mp.weixin.qq.com/s?__biz=MzUzMTA2NTU2Ng==&mid=2247487551&idx=1&sn=18f64ba49f3f0f9d8be9d1fdef8857d9&scene=21#wechat_redirect)[6856541106626363399](https://mp.weixin.qq.com/s?__biz=MzUzMTA2NTU2Ng==&mid=2247487551&idx=1&sn=18f64ba49f3f0f9d8be9d1fdef8857d9&scene=21#wechat_redirect)

- [简单使用](https://mp.weixin.qq.com/s?__biz=MzUzMTA2NTU2Ng==&mid=2247487551&idx=1&sn=18f64ba49f3f0f9d8be9d1fdef8857d9&chksm=fa496f8ecd3ee698f4954c00efb80fe955ec9198fff3ef4011e331aa37f55a6a17bc8c0335a8&scene=21&token=899450012&lang=zh_CN#wechat_redirect)
    - [引入依赖](https://mp.weixin.qq.com/s?__biz=MzUzMTA2NTU2Ng==&mid=2247487551&idx=1&sn=18f64ba49f3f0f9d8be9d1fdef8857d9&chksm=fa496f8ecd3ee698f4954c00efb80fe955ec9198fff3ef4011e331aa37f55a6a17bc8c0335a8&scene=21&token=899450012&lang=zh_CN#wechat_redirect)
    - [requestBody参数校验](https://mp.weixin.qq.com/s?__biz=MzUzMTA2NTU2Ng==&mid=2247487551&idx=1&sn=18f64ba49f3f0f9d8be9d1fdef8857d9&chksm=fa496f8ecd3ee698f4954c00efb80fe955ec9198fff3ef4011e331aa37f55a6a17bc8c0335a8&scene=21&token=899450012&lang=zh_CN#wechat_redirect)
    - [requestParam/PathVariable参数校验](https://mp.weixin.qq.com/s?__biz=MzUzMTA2NTU2Ng==&mid=2247487551&idx=1&sn=18f64ba49f3f0f9d8be9d1fdef8857d9&chksm=fa496f8ecd3ee698f4954c00efb80fe955ec9198fff3ef4011e331aa37f55a6a17bc8c0335a8&scene=21&token=899450012&lang=zh_CN#wechat_redirect)
    - [统一异常处理](https://mp.weixin.qq.com/s?__biz=MzUzMTA2NTU2Ng==&mid=2247487551&idx=1&sn=18f64ba49f3f0f9d8be9d1fdef8857d9&chksm=fa496f8ecd3ee698f4954c00efb80fe955ec9198fff3ef4011e331aa37f55a6a17bc8c0335a8&scene=21&token=899450012&lang=zh_CN#wechat_redirect)
- [进阶使用](https://mp.weixin.qq.com/s?__biz=MzUzMTA2NTU2Ng==&mid=2247487551&idx=1&sn=18f64ba49f3f0f9d8be9d1fdef8857d9&chksm=fa496f8ecd3ee698f4954c00efb80fe955ec9198fff3ef4011e331aa37f55a6a17bc8c0335a8&scene=21&token=899450012&lang=zh_CN#wechat_redirect)
    - [分组校验](https://mp.weixin.qq.com/s?__biz=MzUzMTA2NTU2Ng==&mid=2247487551&idx=1&sn=18f64ba49f3f0f9d8be9d1fdef8857d9&chksm=fa496f8ecd3ee698f4954c00efb80fe955ec9198fff3ef4011e331aa37f55a6a17bc8c0335a8&scene=21&token=899450012&lang=zh_CN#wechat_redirect)
    - [嵌套校验](https://mp.weixin.qq.com/s?__biz=MzUzMTA2NTU2Ng==&mid=2247487551&idx=1&sn=18f64ba49f3f0f9d8be9d1fdef8857d9&chksm=fa496f8ecd3ee698f4954c00efb80fe955ec9198fff3ef4011e331aa37f55a6a17bc8c0335a8&scene=21&token=899450012&lang=zh_CN#wechat_redirect)
    - [集合校验](https://mp.weixin.qq.com/s?__biz=MzUzMTA2NTU2Ng==&mid=2247487551&idx=1&sn=18f64ba49f3f0f9d8be9d1fdef8857d9&chksm=fa496f8ecd3ee698f4954c00efb80fe955ec9198fff3ef4011e331aa37f55a6a17bc8c0335a8&scene=21&token=899450012&lang=zh_CN#wechat_redirect)
    - [自定义校验](https://mp.weixin.qq.com/s?__biz=MzUzMTA2NTU2Ng==&mid=2247487551&idx=1&sn=18f64ba49f3f0f9d8be9d1fdef8857d9&chksm=fa496f8ecd3ee698f4954c00efb80fe955ec9198fff3ef4011e331aa37f55a6a17bc8c0335a8&scene=21&token=899450012&lang=zh_CN#wechat_redirect)
    - [编程式校验](https://mp.weixin.qq.com/s?__biz=MzUzMTA2NTU2Ng==&mid=2247487551&idx=1&sn=18f64ba49f3f0f9d8be9d1fdef8857d9&chksm=fa496f8ecd3ee698f4954c00efb80fe955ec9198fff3ef4011e331aa37f55a6a17bc8c0335a8&scene=21&token=899450012&lang=zh_CN#wechat_redirect)
    - [快速失败（Fail Fast）](https://mp.weixin.qq.com/s?__biz=MzUzMTA2NTU2Ng==&mid=2247487551&idx=1&sn=18f64ba49f3f0f9d8be9d1fdef8857d9&chksm=fa496f8ecd3ee698f4954c00efb80fe955ec9198fff3ef4011e331aa37f55a6a17bc8c0335a8&scene=21&token=899450012&lang=zh_CN#wechat_redirect)
    - [@Valid和@Validated区别](https://mp.weixin.qq.com/s?__biz=MzUzMTA2NTU2Ng==&mid=2247487551&idx=1&sn=18f64ba49f3f0f9d8be9d1fdef8857d9&chksm=fa496f8ecd3ee698f4954c00efb80fe955ec9198fff3ef4011e331aa37f55a6a17bc8c0335a8&scene=21&token=899450012&lang=zh_CN#wechat_redirect)
- [实现原理](https://mp.weixin.qq.com/s?__biz=MzUzMTA2NTU2Ng==&mid=2247487551&idx=1&sn=18f64ba49f3f0f9d8be9d1fdef8857d9&chksm=fa496f8ecd3ee698f4954c00efb80fe955ec9198fff3ef4011e331aa37f55a6a17bc8c0335a8&scene=21&token=899450012&lang=zh_CN#wechat_redirect)
    - [requestBody参数校验实现原理](https://mp.weixin.qq.com/s?__biz=MzUzMTA2NTU2Ng==&mid=2247487551&idx=1&sn=18f64ba49f3f0f9d8be9d1fdef8857d9&chksm=fa496f8ecd3ee698f4954c00efb80fe955ec9198fff3ef4011e331aa37f55a6a17bc8c0335a8&scene=21&token=899450012&lang=zh_CN#wechat_redirect)
    - [方法级别的参数校验实现原理](https://mp.weixin.qq.com/s?__biz=MzUzMTA2NTU2Ng==&mid=2247487551&idx=1&sn=18f64ba49f3f0f9d8be9d1fdef8857d9&chksm=fa496f8ecd3ee698f4954c00efb80fe955ec9198fff3ef4011e331aa37f55a6a17bc8c0335a8&scene=21&token=899450012&lang=zh_CN#wechat_redirect)

---

之前也写过一篇关于Spring Validation使用的文章，不过自我感觉还是浮于表面，本次打算彻底搞懂Spring Validation。本文会详细介绍Spring Validation各种场景下的最佳实践及其实现原理，死磕到底！

项目源码：https://github.com/chentianming11/spring-validation

## [简单使用](https://mp.weixin.qq.com/s?__biz=MzUzMTA2NTU2Ng==&mid=2247487551&idx=1&sn=18f64ba49f3f0f9d8be9d1fdef8857d9&scene=21#wechat_redirect)

Java API规范(JSR303)定义了Bean校验的标准validation-api，但没有提供实现。hibernate validation是对这个规范的实现，并增加了校验注解如@Email、@Length等。

Spring Validation是对hibernate validation的二次封装，用于支持spring mvc参数自动校验。接下来，我们以spring-boot项目为例，介绍Spring Validation的使用。

### [引入依赖](https://mp.weixin.qq.com/s?__biz=MzUzMTA2NTU2Ng==&mid=2247487551&idx=1&sn=18f64ba49f3f0f9d8be9d1fdef8857d9&scene=21#wechat_redirect)

如果spring-boot版本小于2.3.x，spring-boot-starter-web会自动传入hibernate-validator依赖。如果spring-boot版本大于2.3.x，则需要手动引入依赖：

<dependency><groupId>org.hibernate</groupId><artifactId>hibernate-validator</artifactId><version>6.0.1.Final</version></dependency>

对于web服务来说，为防止非法参数对业务造成影响，在Controller层一定要做参数校验的！大部分情况下，请求参数分为如下两种形式：

- POST、PUT请求，使用requestBody传递参数；
- GET请求，使用requestParam/PathVariable传递参数。

下面我们简单介绍下requestBody和requestParam/PathVariable的参数校验实战！

### [requestBody参数校验](https://mp.weixin.qq.com/s?__biz=MzUzMTA2NTU2Ng==&mid=2247487551&idx=1&sn=18f64ba49f3f0f9d8be9d1fdef8857d9&scene=21#wechat_redirect)

POST、PUT请求一般会使用requestBody传递参数，这种情况下，后端使用DTO对象进行接收。只要给DTO对象加上@Validated注解就能实现自动参数校验。比如，有一个保存User的接口，要求userName长度是2-10，account和password字段长度是6-20。

如果校验失败，会抛出MethodArgumentNotValidException异常，Spring默认会将其转为400（Bad Request）请求。

DTO表示数据传输对象（Data Transfer Object），用于服务器和客户端之间交互传输使用的。在spring-web项目中可以表示用于接收请求参数的Bean对象。

在DTO字段上声明约束注解

@DatapublicclassUserDTO{      private Long userId;      @NotNull@Length(min = 2, max = 10)    private String userName;      @NotNull@Length(min = 6, max = 20)    private String account;      @NotNull@Length(min = 6, max = 20)    private String password; } 

在方法参数上声明校验注解

@PostMapping("/save") public Result saveUser(@RequestBody @Validated UserDTO userDTO){    _// 校验通过，才会执行业务逻辑处理_return Result.ok(); } 

这种情况下，使用@Valid和@Validated都可以。

### [requestParam/PathVariable参数校验](https://mp.weixin.qq.com/s?__biz=MzUzMTA2NTU2Ng==&mid=2247487551&idx=1&sn=18f64ba49f3f0f9d8be9d1fdef8857d9&scene=21#wechat_redirect)

GET请求一般会使用requestParam/PathVariable传参。如果参数比较多(比如超过6个)，还是推荐使用DTO对象接收。

否则，推荐将一个个参数平铺到方法入参中。在这种情况下，必须在Controller类上标注@Validated注解，并在入参上声明约束注解(如@Min等)。如果校验失败，会抛出ConstraintViolationException异常。

代码示例如下：

@RequestMapping("/api/user") @RestController@ValidatedpublicclassUserController{    _// 路径变量_@GetMapping("{userId}")    public Result detail(@PathVariable("userId") @Min(10000000000000000L) Long userId) {        _// 校验通过，才会执行业务逻辑处理_        UserDTO userDTO = new UserDTO();        userDTO.setUserId(userId);        userDTO.setAccount("11111111111111111");        userDTO.setUserName("xixi");        userDTO.setAccount("11111111111111111");        return Result.ok(userDTO);    }      _// 查询参数_@GetMapping("getByAccount")    public Result getByAccount(@Length(min = 6, max = 20) @NotNull String  account) {        _// 校验通过，才会执行业务逻辑处理_        UserDTO userDTO = new UserDTO();        userDTO.setUserId(10000000000000003L);        userDTO.setAccount(account);        userDTO.setUserName("xixi");        userDTO.setAccount("11111111111111111");        return Result.ok(userDTO);    } } 

### [统一异常处理](https://mp.weixin.qq.com/s?__biz=MzUzMTA2NTU2Ng==&mid=2247487551&idx=1&sn=18f64ba49f3f0f9d8be9d1fdef8857d9&scene=21#wechat_redirect)

前面说过，如果校验失败，会抛出MethodArgumentNotValidException或者ConstraintViolationException异常。在实际项目开发中，通常会用统一异常处理来返回一个更友好的提示。

比如我们系统要求无论发送什么异常，http的状态码必须返回200，由业务码去区分系统的异常情况。

@RestControllerAdvicepublicclassCommonExceptionHandler{      @ExceptionHandler({MethodArgumentNotValidException.class})    @ResponseStatus(HttpStatus.OK)    @ResponseBodypublicResulthandleMethodArgumentNotValidException(MethodArgumentNotValidExceptionex) {        BindingResult bindingResult = ex.getBindingResult();        StringBuilder sb = new StringBuilder("校验失败:");        for (FieldError fieldError : bindingResult.getFieldErrors()) {            sb.append(fieldError.getField()).append("：").append(fieldError.getDefaultMessage()).append(", ");        }        String msg = sb.toString();        return Result.fail(BusinessCode.参数校验失败, msg);    }      @ExceptionHandler({ConstraintViolationException.class})    @ResponseStatus(HttpStatus.OK)    @ResponseBodypublicResulthandleConstraintViolationException(ConstraintViolationExceptionex) {        return Result.fail(BusinessCode.参数校验失败, ex.getMessage());    } } 

基于 Spring Boot + MyBatis Plus + Vue & Element 实现的后台管理系统 + 用户小程序，支持 RBAC 动态权限、多租户、数据权限、工作流、三方登录、支付、短信、商城等功能

- 项目地址：https://github.com/YunaiV/ruoyi-vue-pro
- 视频教程：https://doc.iocoder.cn/video/

## [进阶使用](https://mp.weixin.qq.com/s?__biz=MzUzMTA2NTU2Ng==&mid=2247487551&idx=1&sn=18f64ba49f3f0f9d8be9d1fdef8857d9&scene=21#wechat_redirect)

### [分组校验](https://mp.weixin.qq.com/s?__biz=MzUzMTA2NTU2Ng==&mid=2247487551&idx=1&sn=18f64ba49f3f0f9d8be9d1fdef8857d9&scene=21#wechat_redirect)

在实际项目中，可能多个方法需要使用同一个DTO类来接收参数，而不同方法的校验规则很可能是不一样的。这个时候，简单地在DTO类的字段上加约束注解无法解决这个问题。因此，spring-validation支持了分组校验的功能，专门用来解决这类问题。

还是上面的例子，比如保存User的时候，UserId是可空的，但是更新User的时候，UserId的值必须>=10000000000000000L；其它字段的校验规则在两种情况下一样。这个时候使用分组校验的代码示例如下：

约束注解上声明适用的分组信息groups

@DatapublicclassUserDTO{      @Min(value = 10000000000000000L, groups = Update.class)    privateLonguserId;      @NotNull(groups = {Save.class, Update.class})    @Length(min= 2, max = 10, groups = {Save.class, Update.class})    privateStringuserName;      @NotNull(groups = {Save.class, Update.class})    @Length(min= 6, max = 20, groups = {Save.class, Update.class})    privateStringaccount;      @NotNull(groups = {Save.class, Update.class})    @Length(min= 6, max = 20, groups = {Save.class, Update.class})    privateStringpassword;      _/**      * 保存的时候校验分组      */_publicinterfaceSave{    }      _/**      * 更新的时候校验分组      */_publicinterfaceUpdate{    } } 

@Validated注解上指定校验分组

@PostMapping("/save") public Result saveUser(@RequestBody @Validated(UserDTO.Save.class) UserDTO userDTO) {    _// 校验通过，才会执行业务逻辑处理_return Result.ok(); }  @PostMapping("/update") public Result updateUser(@RequestBody @Validated(UserDTO.Update.class) UserDTO userDTO) {    _// 校验通过，才会执行业务逻辑处理_return Result.ok(); } 

### [嵌套校验](https://mp.weixin.qq.com/s?__biz=MzUzMTA2NTU2Ng==&mid=2247487551&idx=1&sn=18f64ba49f3f0f9d8be9d1fdef8857d9&scene=21#wechat_redirect)

前面的示例中，DTO类里面的字段都是基本数据类型和String类型。但是实际场景中，有可能某个字段也是一个对象，这种情况先，可以使用嵌套校验。

比如，上面保存User信息的时候同时还带有Job信息。需要注意的是，此时DTO类的对应字段必须标记@Valid注解。

@DatapublicclassUserDTO{      @Min(value = 10000000000000000L, groups = Update.class)    privateLonguserId;      @NotNull(groups = {Save.class, Update.class})    @Length(min= 2, max = 10, groups = {Save.class, Update.class})    privateStringuserName;      @NotNull(groups = {Save.class, Update.class})    @Length(min= 6, max = 20, groups = {Save.class, Update.class})    privateStringaccount;      @NotNull(groups = {Save.class, Update.class})    @Length(min= 6, max = 20, groups = {Save.class, Update.class})    privateStringpassword;      @NotNull(groups = {Save.class, Update.class})    @ValidprivateJobjob;      @DatapublicstaticclassJob{          @Min(value = 1, groups = Update.class)        privateLongjobId;          @NotNull(groups = {Save.class, Update.class})        @Length(min= 2, max = 10, groups = {Save.class, Update.class})        privateStringjobName;          @NotNull(groups = {Save.class, Update.class})        @Length(min= 2, max = 10, groups = {Save.class, Update.class})        privateStringposition;    }      _/**      * 保存的时候校验分组      */_publicinterfaceSave{    }      _/**      * 更新的时候校验分组      */_publicinterfaceUpdate{    } } 

嵌套校验可以结合分组校验一起使用。还有就是嵌套集合校验会对集合里面的每一项都进行校验，例如List<Job>字段会对这个list里面的每一个Job对象都进行校验

### [集合校验](https://mp.weixin.qq.com/s?__biz=MzUzMTA2NTU2Ng==&mid=2247487551&idx=1&sn=18f64ba49f3f0f9d8be9d1fdef8857d9&scene=21#wechat_redirect)

如果请求体直接传递了json数组给后台，并希望对数组中的每一项都进行参数校验。此时，如果我们直接使用java.util.Collection下的list或者set来接收数据，参数校验并不会生效！我们可以使用自定义list集合来接收参数：

包装List类型，并声明@Valid注解

publicclassValidationList<E> implementsList<E> {      @Delegate_// @Delegate是lombok注解_@Valid_// 一定要加@Valid注解_public List<E> list = new ArrayList<>();      _// 一定要记得重写toString方法_@Overridepublic String toString(){        return list.toString();    } } 

@Delegate注解受lombok版本限制，1.18.6以上版本可支持。如果校验不通过，会抛出NotReadablePropertyException，同样可以使用统一异常进行处理。

比如，我们需要一次性保存多个User对象，Controller层的方法可以这么写：

@PostMapping("/saveList") public Result saveList(@RequestBody @Validated(UserDTO.Save.class) ValidationList<UserDTO> userList) {    _// 校验通过，才会执行业务逻辑处理_return Result.ok(); } 

### [自定义校验](https://mp.weixin.qq.com/s?__biz=MzUzMTA2NTU2Ng==&mid=2247487551&idx=1&sn=18f64ba49f3f0f9d8be9d1fdef8857d9&scene=21#wechat_redirect)

业务需求总是比框架提供的这些简单校验要复杂的多，我们可以自定义校验来满足我们的需求。

自定义spring validation非常简单，假设我们自定义加密id（由数字或者a-f的字母组成，32-256长度）校验，主要分为两步：

自定义约束注解

@Target({METHOD, FIELD, ANNOTATION_TYPE, CONSTRUCTOR, PARAMETER}) @Retention(RUNTIME) @Documented@Constraint(validatedBy = {EncryptIdValidator.class}) public @interfaceEncryptId{      _// 默认错误消息_String message()default "加密id格式错误";      _// 分组_    Class<?>[] groups() default {};      _// 负载_    Class<? extends Payload>[] payload() default {}; } 

实现ConstraintValidator接口编写约束校验器

publicclassEncryptIdValidatorimplementsConstraintValidator<EncryptId, String> {      privatestaticfinal Pattern PATTERN = Pattern.compile("^[a-f\\d]{32,256}$");      @OverridepublicbooleanisValid(String value, ConstraintValidatorContext context){        _// 不为null才进行校验_if (value != null) {            Matcher matcher = PATTERN.matcher(value);            return matcher.find();        }        returntrue;    } } 

这样我们就可以使用@EncryptId进行参数校验了！

### [编程式校验](https://mp.weixin.qq.com/s?__biz=MzUzMTA2NTU2Ng==&mid=2247487551&idx=1&sn=18f64ba49f3f0f9d8be9d1fdef8857d9&scene=21#wechat_redirect)

上面的示例都是基于注解来实现自动校验的，在某些情况下，我们可能希望以编程方式调用验证。这个时候可以注入javax.validation.Validator对象，然后再调用其api。

@Autowiredprivate javax.validation.Validator globalValidator;  _// 编程式校验_@PostMapping("/saveWithCodingValidate") public Result saveWithCodingValidate(@RequestBody UserDTO userDTO){    Set<ConstraintViolation<UserDTO>> validate = globalValidator.validate(userDTO, UserDTO.Save.class);    _// 如果校验通过，validate为空；否则，validate包含未校验通过项_if (validate.isEmpty()) {        _// 校验通过，才会执行业务逻辑处理_    } else {        for (ConstraintViolation<UserDTO> userDTOConstraintViolation : validate) {            _// 校验失败，做其它逻辑_            System.out.println(userDTOConstraintViolation);        }    }    return Result.ok(); } 

### [快速失败(Fail Fast)](https://mp.weixin.qq.com/s?__biz=MzUzMTA2NTU2Ng==&mid=2247487551&idx=1&sn=18f64ba49f3f0f9d8be9d1fdef8857d9&scene=21#wechat_redirect)

Spring Validation默认会校验完所有字段，然后才抛出异常。可以通过一些简单的配置，开启Fali Fast模式，一旦校验失败就立即返回。

@Beanpublic Validator validator(){    ValidatorFactory validatorFactory = Validation.byProvider(HibernateValidator.class)            .configure()            // 快速失败模式            .failFast(true)            .buildValidatorFactory();    return validatorFactory.getValidator(); } 

### [@Valid和@Validated区别](https://mp.weixin.qq.com/s?__biz=MzUzMTA2NTU2Ng==&mid=2247487551&idx=1&sn=18f64ba49f3f0f9d8be9d1fdef8857d9&scene=21#wechat_redirect)

%!(EXTRA markdown.ResourceType=, string=, string=)

[https://mp.weixin.qq.com/s?__biz=MzUzMTA2NTU2Ng==&mid=2247487551&idx=1&sn=18f64ba49f3f0f9d8be9d1fdef8857d9&scene=21#wechat_redirect](https://mp.weixin.qq.com/s?__biz=MzUzMTA2NTU2Ng==&mid=2247487551&idx=1&sn=18f64ba49f3f0f9d8be9d1fdef8857d9&scene=21#wechat_redirect)

基于 Spring Cloud Alibaba + Gateway + Nacos + RocketMQ + Vue & Element 实现的后台管理系统 + 用户小程序，支持 RBAC 动态权限、多租户、数据权限、工作流、三方登录、支付、短信、商城等功能

- 项目地址：https://github.com/YunaiV/yudao-cloud
- 视频教程：https://doc.iocoder.cn/video/

## [实现原理](https://mp.weixin.qq.com/s?__biz=MzUzMTA2NTU2Ng==&mid=2247487551&idx=1&sn=18f64ba49f3f0f9d8be9d1fdef8857d9&scene=21#wechat_redirect)

### [requestBody参数校验实现原理](https://mp.weixin.qq.com/s?__biz=MzUzMTA2NTU2Ng==&mid=2247487551&idx=1&sn=18f64ba49f3f0f9d8be9d1fdef8857d9&scene=21#wechat_redirect)

在spring-mvc中，RequestResponseBodyMethodProcessor是用于解析@RequestBody标注的参数以及处理@ResponseBody标注方法的返回值的。显然，执行参数校验的逻辑肯定就在解析参数的方法resolveArgument()中：

publicclassRequestResponseBodyMethodProcessorextendsAbstractMessageConverterMethodProcessor{    @Overridepublic Object resolveArgument(MethodParameter parameter, @Nullable ModelAndViewContainer mavContainer,                                  NativeWebRequest webRequest, @Nullable WebDataBinderFactory binderFactory)throws Exception {          parameter = parameter.nestedIfOptional();        _//将请求数据封装到DTO对象中_        Object arg = readWithMessageConverters(webRequest, parameter, parameter.getNestedGenericParameterType());        String name = Conventions.getVariableNameForParameter(parameter);          if (binderFactory != null) {            WebDataBinder binder = binderFactory.createBinder(webRequest, arg, name);            if (arg != null) {                _// 执行数据校验_                validateIfApplicable(binder, parameter);                if (binder.getBindingResult().hasErrors() && isBindExceptionRequired(binder, parameter)) {                    thrownew MethodArgumentNotValidException(parameter, binder.getBindingResult());                }            }            if (mavContainer != null) {                mavContainer.addAttribute(BindingResult.MODEL_KEY_PREFIX + name, binder.getBindingResult());            }        }        return adaptArgumentIfNecessary(arg, parameter);    } } 

可以看到，resolveArgument()调用了validateIfApplicable()进行参数校验。

protectedvoidvalidateIfApplicable(WebDataBinder binder, MethodParameter parameter){    _// 获取参数注解，比如@RequestBody、@Valid、@Validated_    Annotation[] annotations = parameter.getParameterAnnotations();    for (Annotation ann : annotations) {        _// 先尝试获取@Validated注解_        Validated validatedAnn = AnnotationUtils.getAnnotation(ann, Validated.class);        _//如果直接标注了@Validated，那么直接开启校验。//如果没有，那么判断参数前是否有Valid起头的注解。_if (validatedAnn != null || ann.annotationType().getSimpleName().startsWith("Valid")) {            Object hints = (validatedAnn != null ? validatedAnn.value() : AnnotationUtils.getValue(ann));            Object[] validationHints = (hints instanceof Object[] ? (Object[]) hints : new Object[] {hints});            _//执行校验_            binder.validate(validationHints);            break;        }    } } 

看到这里，大家应该能明白为什么这种场景下@Validated、@Valid两个注解可以混用。我们接下来继续看WebDataBinder.validate()实现。

@Overridepublicvoidvalidate(Object target, Errors errors, Object... validationHints){    if (this.targetValidator != null) {        processConstraintViolations(            _//此处调用Hibernate Validator执行真正的校验_this.targetValidator.validate(target, asValidationGroups(validationHints)), errors);    } } 

最终发现底层最终还是调用了Hibernate Validator进行真正的校验处理。

### [方法级别的参数校验实现原理](https://mp.weixin.qq.com/s?__biz=MzUzMTA2NTU2Ng==&mid=2247487551&idx=1&sn=18f64ba49f3f0f9d8be9d1fdef8857d9&scene=21#wechat_redirect)

上面提到的将参数一个个平铺到方法参数中，然后在每个参数前面声明约束注解的校验方式，就是方法级别的参数校验。

实际上，这种方式可用于任何Spring Bean的方法上，比如Controller/Service等。其底层实现原理就是AOP，具体来说是通过MethodValidationPostProcessor动态注册AOP切面，然后使用MethodValidationInterceptor对切点方法织入增强。

publicclassMethodValidationPostProcessorextendsAbstractBeanFactoryAwareAdvisingPostProcessorimplementsInitializingBean{    @OverridepublicvoidafterPropertiesSet(){        _//为所有`@Validated`标注的Bean创建切面_        Pointcut pointcut = new AnnotationMatchingPointcut(this.validatedAnnotationType, true);        _//创建Advisor进行增强_this.advisor = new DefaultPointcutAdvisor(pointcut, createMethodValidationAdvice(this.validator));    }      _//创建Advice，本质就是一个方法拦截器_protected Advice createMethodValidationAdvice(@Nullable Validator validator){        return (validator != null ? new MethodValidationInterceptor(validator) : new MethodValidationInterceptor());    } } 

接着看一下MethodValidationInterceptor：

publicclassMethodValidationInterceptorimplementsMethodInterceptor{    @Overridepublic Object invoke(MethodInvocation invocation)throws Throwable {        _//无需增强的方法，直接跳过_if (isFactoryBeanMetadataMethod(invocation.getMethod())) {            return invocation.proceed();        }        _//获取分组信息_        Class<?>[] groups = determineValidationGroups(invocation);        ExecutableValidator execVal = this.validator.forExecutables();        Method methodToValidate = invocation.getMethod();        Set<ConstraintViolation<Object>> result;        try {            _//方法入参校验，最终还是委托给Hibernate Validator来校验_            result = execVal.validateParameters(                invocation.getThis(), methodToValidate, invocation.getArguments(), groups);        }        catch (IllegalArgumentException ex) {            ...        }        _//有异常直接抛出_if (!result.isEmpty()) {            thrownew ConstraintViolationException(result);        }        _//真正的方法调用_        Object returnValue = invocation.proceed();        _//对返回值做校验，最终还是委托给Hibernate Validator来校验_        result = execVal.validateReturnValue(invocation.getThis(), methodToValidate, returnValue, groups);        _//有异常直接抛出_if (!result.isEmpty()) {            thrownew ConstraintViolationException(result);        }        return returnValue;    } } 

实际上，不管是requestBody参数校验还是方法级别的校验，最终都是调用Hibernate Validator执行校验，Spring Validation只是做了一层封装。
