# 服务器环境java进程执行【包含重启自身进程代码的脚本】注意事项

1.必须加sudo

Runtime.getRuntime().exec(new String[]{"sudo", "/bin/sh", "-c",  "xxx.sh"});

原因:

**环境隔离**：

sudo 会创建一个隔离的执行环境，并可能使用 root 权限。这种隔离有助于在 Java 进程重启后，新的 shell 环境继续执行剩余的脚本。

没有 sudo 的情况下，新的 shell 直接作为 Java 进程的子进程运行。当 Java 进程重启时，原有的 shell 进程失去其父进程（Java 进程）的控制，可能导致它无法正常继续执行。
