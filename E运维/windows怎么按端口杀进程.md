# windows怎么按端口杀进程

1netstat -ano |findstr "端口号" 然后回车就可以看到这个端口被哪个应用占用。

2查看到对应的进程id之后，就可以通过id查找对应的进程名称，使用命令tasklist |findstr "进程id号"

3通过命令杀掉进程，或者是直接根据进程的名称杀掉所有的进程，，在命令框中输入如下命令taskkill /f /t /im "进程id或者进程名称"
