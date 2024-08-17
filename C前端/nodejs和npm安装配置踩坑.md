# nodejs和npm安装配置踩坑

1 首先下载9及以下版本（不要下载10，以防止cnpm不支持）安装到d：\nodejs  

2 npm config set prefix "D:\nodejs\node_global"

   npm config set cache  "D:\nodejs\node_cache"

3 进入我的电脑→属性→高级→环境变量。在系统变量下新建“NODE_PATH”，输入“D:\nodejs\node_global\node_modules”

4 node -v  和npm -v检查是否正确。（注意重启cmd）

# **解决 npm install Error: EACCES: permission denied,** 

npm install _--unsafe-perm=true --allow-root_
