@echo off
chcp 936 >nul
echo  开始同步......

git add -A

git commit -m "save" 

git  pull

git push

echo  同步完成！即将退出...
timeout /t 3
exit /b 0