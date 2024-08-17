# git团队开发一般步骤及注意事项

前期准备：

1.指派一个人在本地master分支的基础上检出develop分支并切换到该分支

git checkout -b develop

2还是这个人将本地develop分支推送到远程

git push --set-upstream origin develop

3然后其他人在本地检出develop分支（要先git fetch）

git fetch

git checkout develop

————————————————————————————————————————————————

团队协作：

master分支仅做发布稳定版本用，大家都在develop分支合作（分以下两种情况），

*如果想拉取别人的提交：

1.在本地develop分支更改文件后可以直接用idea软件commit ，要加注释（idea只需add一次以后都不需要add）

2.git fetch  刷新远程develop

3.git rebase origin/develop  无冲突更好，有冲突的话切回idea处理完冲突（右键项目-git-resolve conflics）后， git rebase --continue

*如果想把自己的更改提交到远程：

1.在本地develop分支更改文件后可以直接用idea软件commit ，要加注释（idea只需add一次以后都不需要add）

2. git fetch  刷新远程develop

3.git rebase origin/develop  无冲突更好，有冲突的话切回idea处理完冲突（右键项目-git-resolve conflics）后， git rebase --continue

4.git push

-----------------------------——————————————————————————————————

注意事项：

1.开发阶段就没必要新建自己的分支了，自己想建也可以，建完用本地develop来merge效果是一样的

2.可以通过log命令来查看本地和远程的最新commit的信息，以确保该分支上是否有自己或别人的信息，

    git log <要查看的分支名字>

3 commit一定要写注释，要详细写明改了什么

——————————————————————————————————————————————————

什么情况下建自己的分支：

1.比如你有个bug要修改，但是一时半会改不完，而且改的过程中会影响项目开发，那就可以自己建个分支放那，

  随改随切，改完了再用devlop来merge。

2.小组新来个成员，但由于他对项目不熟悉，直接在develop分支开发可能会出乱子，那就让他自己新建个分支玩，

   自己再摘取他有用的commit

3.项目分好几个版本 发给客户的版本是正式版，但是自己想加一些功能不想给客户用，那就可以自己弄个属于自己的分支

4.其他情况....

注意：分支固然有用，但时要有需要的时候才建，没必要为了建分支而建分支，给自己找不必要的麻烦。
