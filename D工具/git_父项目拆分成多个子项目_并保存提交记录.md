# git 父项目拆分成多个子项目 并保存提交记录

git  fetch --all 

 git  pull 

git remote  rm  origin

git filter-branch --tag-name-filter cat --prune-empty --subdirectory-filter  子目录名  -- --all

git reflog expire --expire=now --all

git gc --aggressive --prune=now





git  remote add origin  xxx

git  push --all origin -u

​                                                    

==========脚本==============



@echo off
setlocal

:: 设置子目录名和新的远程地址
set "SUBDIR_NAME=子文件夹名称，如  xxx/xxxa 或xxx，   window下也是正斜杠"
set "NEW_REMOTE_URL=git@github.com:user/moduleA.git"

echo Fetching all remote branches and tags...
git fetch --all

echo Filtering branch history for subdirectory: %SUBDIR_NAME%
git filter-branch --tag-name-filter cat --prune-empty --subdirectory-filter "%SUBDIR_NAME%" -- --all

echo Cleaning up history...
git reflog expire --expire=now --all
git gc --aggressive --prune=now

echo Removing old remote origin...
git remote rm origin

echo Adding new remote origin: %NEW_REMOTE_URL%
git remote add origin %NEW_REMOTE_URL%

echo Pushing all branches to new origin...
git push --all origin -u

echo Pushing all tags to new origin...
git push --tags origin

echo Done.
pause
