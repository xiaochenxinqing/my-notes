# VUE填坑

watch中写this时 不能用箭头函数，

watch中如果想监听对象的属性值变化  必须加deep:true，否则监听不到

更改对象的属性值，必须提前给一个默认值，否则不会监听到

试试Vue.set（）方法

# [vue路由跳转到新页面显示空白，刷新一下正常显示](https://segmentfault.com/q/1010000011181463) 原因可能是路由中有多余空格

_<!-- <meta http-equiv="Content-Security-Policy" content="upgrade-insecure-requests"/>--> <!--__此行的作用是自动将页面请求转为__https-->_
