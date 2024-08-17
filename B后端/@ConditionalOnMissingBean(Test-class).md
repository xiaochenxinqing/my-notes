# @ConditionalOnMissingBean(Test.class)

@ConditionalOnMissingBean(Test.class)

如果当前容器中已经有Test的bean了，就不注入，如果没有，则注入，

@ConditionalOnClass (KafkaTemplate.class)

这个注解通俗的说就是Spring工程 说只有在classpath下能找有KafkaTemplate这个类    才会构建这个bean

@ConditionalOnProperty

@Retention(RetentionPolicy.RUNTIME)

@Target({ ElementType.TYPE, ElementType.METHOD })

@Documented

@Conditional(OnPropertyCondition.class)public @interface ConditionalOnProperty {

String[] value() default {}; //数组，获取对应property名称的值，与name不可同时使用

String prefix() default "";//property名称的前缀，可有可无

String[] name() default {};//数组，property完整名称或部分名称（可与prefix组合使用，组成完整的property名称），与value不可同时使用

String havingValue() default "";//可与name组合使用，比较获取到的属性值与havingValue给定的值是否相同，相同才加载配置

boolean matchIfMissing() default false;//缺少该property时是否可以加载。如果为true，没有该property也会正常加载；反之报错

boolean relaxedNames() default true;//是否可以松散匹配，至今不知道怎么使用的 }

}

@EnableConfigurationProperties

@EnableConfigurationProperties注解的作用是：使使用 @ConfigurationProperties 注解的类生效。

#### 说明：

如果一个配置类只配置@ConfigurationProperties注解，而没有使用@Component，那么在IOC容器中是获取不到properties 配置文件转化的bean。说白了 @EnableConfigurationProperties 相当于把使用 @ConfigurationProperties 的类进行了一次注入。

测试发现 @ConfigurationProperties 与 @EnableConfigurationProperties 关系特别大

作者：咪雅先森

链接：[https://www.jianshu.com/p/7f54da1cb2eb](https://www.jianshu.com/p/7f54da1cb2eb)

来源：简书

著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。

@ConfigurationProperties
