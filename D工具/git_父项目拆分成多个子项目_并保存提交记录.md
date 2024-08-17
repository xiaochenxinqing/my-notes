# git 父项目拆分成多个子项目 并保存提交记录

git  fetch --all 

 git  pull --all

git remote  rm  origin

git filter-branch --tag-name-filter cat --prune-empty --subdirectory-filter  子目录名  -- --all

git reflog expire --expire=now --all

git gc --aggressive --prune=now

git  remote add origin  xxx

git  push --all origin -u

                                                    
