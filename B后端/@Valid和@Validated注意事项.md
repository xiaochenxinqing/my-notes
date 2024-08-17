# @Valid和@Validated注意事项

1,要引入的包必须全  特别是检查hibernate-validator包是否存在

2.controller 中如果有BindingResult 参数,则全局异常捕获不会捕获BindException异常

3嵌套验证,类中的待验证类要加@Valid注解

4.验证@RequestParam注解的参数,需要再Controller上加@Validated注解否则不生效
