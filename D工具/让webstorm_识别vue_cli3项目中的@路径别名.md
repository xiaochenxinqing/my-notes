# 让webstorm 识别vue cli3项目中的@路径别名

# 让webstorm 识别vue cli3项目中的@路径别名

axel10 2019-02-22 [原文](https://www.bbsmax.com/link/MU81RTIzVjRkNw==)

在setting -> languages&frameworks -> webpack里选择配置文件路径为 node_modules/@vue/cli-service/webpack.config.js即可。

需要注意的是如果在scss中使用@别名则需要加~号。比如在src目录下有一个var.scss文件，其他文件引用时则需写成：

1. @import "~@/var.scss";
