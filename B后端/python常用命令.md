# python常用命令

安装Django

pip install django==1.11.11

创建项目

django-admin manage.py startproject projectname

启动项目

python manage.py runserver IP:端口--> 在指定的IP和端口启动

python manage.py runserver 端口 --> 在指定的端口启动

python manage.py runserver --> 默认在本机的8000端口启动

创建数据库

1. python manage.py makemigrations

2. python manage.py migrate

生成requirements.txt文件

pip freeze > requirements.txt

安装requirements.txt依赖

pip install -r requirements.txt
