# Git常用命令总结

设置拉取下来的项目换行方式为LF:git config --global core.autocrlf input

——————————————————————————————2017.12.20尹晓晨—————————

1.git fetch

git fetch 远程仓库名  分支名—— 将某个远程分支的commitId更新为最新，全部省略的时候代表更新所有远程仓库的所有分支

    (经常用git fetch+rebase进行合并，rebase和merge区别见[http://www.jianshu.com/p/cca69cb695a6](http://www.jianshu.com/p/cca69cb695a6))

    (merge和rebase优缺点自己百度，一般认为fetch+merge=pull)

—————————————————————————————————————————————————————————

2.git reset

git reset --hard 目标分支———用目标分支重构当前本地分支，目标分支可以是本地也可是远程

git reset --hard HEAD~n————将本地分支回退n次提交

git reset --hard HEAD~commitID————将本地分支回退到目标commitID的状态

—————————————————————————————————————————————————————————

3.

git checkout -b newbranchname ————以当前本地分支为蓝本创建一个新分支，并切换到新分支

git checkout 远程分支名 ——————直接生成某个远程分支的本地分支，并切换到该分支

4.删除本地分支

git branch -d branch (大写D为强制删除)

5.删除远程分支

git branch -r -d origin/远程分支名 

 或  git push origin   :远程分支名     

 或      git push <远程主机名> --detete <删除分支名>

更新远程分支的本地列表：git remote update origin --prune

6.合并目标分支到当前分支（若有冲突需要手动处理）

git merge branchName

7.改本地分支名

git branch -m oldname  newname

8.更改远程仓库的默认分支（默认为master）

git remote set-head origin 分支名

—————————————————————————————————————————————————————————

9.git rebase

git rebase -i HEAD~n ——重构本地当前分支的前n个提交（n代表数字）

git rebase  目标分支——用目标分支重构当前本地分支，目标分支可以是本地也可是远程，省略时代表本地当前分支关联的远程分支

—————————————————————————————————————————————————————————

10.单独抓取另一个分支（本地/远程）上的单个提交

git cherry-pick  commitId

——————————————————————————————————————————————————————————

11暂存功能

git stash ——暂存

git stash list ——查看暂存列表

git stash apply 暂存id ——应用某个暂存

git stash pop————应用所有暂存，并删除暂存列表

——————————————————————————————————————————————————————

12.如何push单个 commit点

例如：

$ git push origin 2dc2b7e393e6b712ef103eaac81050b9693395a4:master

13 git push -f 强制推送（慎用）

——————————————————————————————————————————————————————

14 git reflog   查看详细历史操作记录（恢复误操作的git reset常用）

15 重设远程origin的url

git remote set-url   origin    [url]

git rm -r --cached 移除某文件夹的版本控制
