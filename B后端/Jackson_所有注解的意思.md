# Jackson 所有注解的意思

# Jackson Annotation学习笔记

Jackson中的注解：

命名类注解

1.@JsonProperty：表明java类绑定json中的属性名。调用格式可以无参数表示与类中属性同名，同样可以用@JsonProperty ("name")，重新定义json中此属性的名字。

包含类注解

    案例：

public class Name {   @JsonProperty("firstName")   public String _first_name; }

    结果，

{ "firstName" : "Bob" }

2.@JsonAutoDetect：类注解，用于类定义属性检测。

    案例：

@JsonAutoDetect(fieldVisibility=JsonAutoDetect.Visibility.ANY) public class POJOWithFields {   private int value; }

    案例：

@JsonAutoDetect(fieldVisibility=JsonAutoDetect.Visibility.NONE) public class POJOWithNoFields {   // will NOT be included, unless there is access 'getValue()'   public int value; }

3.@JsonIgnore：用于忽略指定属性的简单注解。

    案例：

public class Value {   public int value;   @JsonIgnore public int internalValue; }

    结果，

{ "value" : 42 }

4.@JsonIgnoreProperties：指定忽略一组属性或者忽略所有未知属性。

    案例（序列化过层中忽略列表中的指定属性）：

@JsonIgnoreProperties({"prop1", "prop2"})

  案例：

@JsonIgnoreProperties({ "extra", "uselessValue" }) public class Value {   public int value; }

   可处理， 

{ "value" : 42, "extra" : "fluffy", "uselessValue" : -13 }

    案例（反序列化过程中忽略所有的未知属性，即未知属性没有set与get方法）：

@JsonIgnoreProperties(ignoreUnknown=true)

  案例：

@JsonIgnoreProperties(ignoreUnknown=true) public class PojoWithAny {   public int value; }

5.@JsonIgnoreType：忽略指定类型的所有属性。

6.@JsonInclude：用于序列化中忽略null值或者empty值，可以指定某一个属性，也可以指定某一个类中所有属性。

序列化和反序列化细节类注解：

7.@JsonFormat：用于指定一类特定行为，比如日期转换格式。

8.@JsonUnwrapped：用与指定序列化过程中值为展开的，反序列化过程中重新包裹。

9.@JsonView：用于指定属性需要被序列化或者反序列化。 

反序列化类注解

10.@JacksonInject：指定反序列化过程中，属性值不从json中获取，而需要注入方式获得。

11.@JsonAnySetter：用于定义一个两个参数的方法，实现未绑定属性的反序列化，保证这些未绑定属性反序列化之后拥有set和get方法。

12.@JsonCreator：用于定义实现反序列化的实体初始化。

13.@JsonSetter：用于代替@JsonProperty，来指定属性的set方法。

序列化类注解

11.@JsonAnyGetter：用于定义一个get方法，返回java.util.Map类型。java类中属性将被序列化为json对象的属性。

12.@JsonGetter：用于代替@JsonProperty，指定属性的get方法。

13.@JsonPropertyOrder：指定属性的序列化顺序。

14.@JsonRawValue：用于指定序列化过程中获取不带任何装饰和格式规范的json。

15.@JsonValue：指定类属性以string类型进行序列化，相当于java的tostring方法。

16.@JsonRootName：如果json根包裹可用，指定最外层包裹名。

类型处理类注解

17.@JsonSubTypes：处理多态时，指定生成子类反序列化过程中注解类型。

18.@JsonTypeId：类标记用于指定属性来标记java类，而不是通过类名或者其他来标记。

19.@JsonTypeInfo：用来指定何种类型的属性值被序列化，如何序列化。

    案例：

// Include Java class name ("com.myempl.ImplClass") as JSON property "class" @JsonTypeInfo(use=Id.CLASS, include=As.PROPERTY, property="class") public abstract class BaseClass { }  public class Impl1 extends BaseClass {   public int x; } public class Impl2 extends BaseClass {   public String name; }  public class PojoWithTypedObjects {   public List<BaseClass> items; }

    生成，

{ "items" : [   { "class":"Impl2", "name":"Bob" },   { "class":"Impl1", "x":13 } ]}

20.@JsonTypeName：类标记指定逻辑类型名称，如果定义了@JsonTypeInfo，还可以作为java类标记。

对象引用和定义类注解

21.@JsonManagedReference, @JsonBackReference：标记父子匹配关联关系。

22.@JsonIdentityInfo：用于指示对象标识是序列化/反序列化的值，以使得多个引用的单个Java对象可以适当地反序列化时使用。这可以用来妥善处理循环对象图和有向无环图。

元注解

23.@JacksonAnnotation：添加所有注解。

24.@JacksonAnnotationsInside：表示将注解捆绑，然后定义一个捆绑后的注解。

25.@JsonDeserialize

26.@JsonSerialize

    案例：

public class ValueContainer {   // although nominal type is 'Value', we want to read JSON as 'ValueImpl'   @JsonDeserialize(as=ValueImpl.class)   public Value value;    // although runtime type may be 'AdvancedType', we really want to serialize   // as 'BasicType'; two ways to do this:   @JsonSerialize(as=BasicType.class)   // or could also use: @JsonSerialize(typing=Typing.STATIC)   public BasicType another; }
