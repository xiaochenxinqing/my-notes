# echo.js 延迟加载图片控件使用方法

echo.js 延迟加载图片控件

echo.js的github地址：[https://github.com/toddmotto/echo](https://github.com/toddmotto/echo)

echo是一个独立的JavaScript、轻量级的、延迟图片加载插件，echo压缩后体积不到1k，使用html的标准data-*属性，echo支持IE8+。

使用echo.js非常简单，在网页需要延迟加载的img标签中，设置data-echo属于指向需要加载的图片路径，src属性指向默认加载图片路径。然后引入echo.min.js，并初始化echo即可。

```
<script src="echo.min.js"></script>
<script>
     echo.init({
         // options初始化参数
     });
</script>
1
<img src="img/blank.gif" alt="Photo" data-echo="img/photo.jpg">
options :
     offset  默认值为0。设置上下左右到viewport的距离多少才加载图片。
     offsetVertical  默认值为0。设置上下到viewport的距离是多少才加载图片。
     offsetHorizontal  默认值为0。设置左右到viewport的距离是多少才加载图片。
     offsetTop  默认值为offsetVertical。设置顶部距离viewport的距离
     offsetButton  默认值为offsetVertical。设置顶部距离viewport的距离
     offsetLeft  默认值为offsetVertical。设置左边距离viewport的距离
     offsetRight  默认值为offsetVertical。设置右边距离viewport的距离
     throttle 单位毫秒 设置图片延迟加载时间，通俗点说就是函数调用的频度控制器，是连续执行时间间隔控制。主要应用的场景比如：鼠标移动，mousemove事件；DOM元素动态定位，window对象的resize和scroll事件。     
     debounce 单位布尔值，默认true，      unload 单位布尔值，默认false。该选项告诉echo，当图片滑动超过了viewport的时候不在加载该图片。
     callback 单位函数，回调函数会传递已更新的元素和操作（load或者unload）给回调函数。
同时，通过调用echo.reader()函数模式scroll函数，触发echo加载图片。
```
