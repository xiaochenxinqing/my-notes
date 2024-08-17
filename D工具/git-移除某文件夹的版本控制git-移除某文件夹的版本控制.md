# git-移除某文件夹的版本控制git-移除某文件夹的版本控制

## **git-移除某文件夹的版本控制**

git-移除某文件夹的版本控制，如我们把.idea目录误提达到远端。

有时候我们一开始在上传项目的时候把某些不必要的文件也添加进了git的版本控制。此时 gitignore 对这些文件就不起作用了。因此我们要先从 git 里面把这些文件 untracked ，然后修改 gitignore ，最后提交。

核心，使用git rm命令，添加参数 --cached

–cached 的意思是只去除版本控制而不删除本地文件，如果不写的话会把本地文件也删掉。所以要不要加 --cached 参数就看自己需要了。

具体步骤如下：

1.git rm -r --cached ".idea" //执行命令.

2.修改 .gitignore， 把对应的规则写入 .gitignore，让忽略真正生效；

3.先本地conmmit一下(包括.idea文件和.gitignore文件)

git commit -m" remove .idea folder all file out of control" //提交

4.git push origin master //提交到远程服务器
