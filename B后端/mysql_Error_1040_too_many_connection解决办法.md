# mysql Error 1040 too many connection解决办法

最近在用SpringMVC开发的时候，突然出现1040 too many connection的错误，看错误的意思是连接的人数太多了。

方法/步骤

当最大连接数比较小时，可能会出现“1040 too many connection”错误。

首先需要重启mysql服务，执行命令：service mysql restar

也有可能是：service mysqld restart

登录mysql:mysql -uroot -p

输入密码，回车；

登录成功后执行以下语句查询当前的最大连接数：select VARIABLE_VALUE from information_schema.GLOBAL_VARIABLES where VARIABLE_NAME='MAX_CONNECTIONS';

4

执行以下语句修改最大连接数：set global max_connections = 3600;

mysql> set global wait_timeout=10;

mysql> show global variables like 'wait_timeout';

+----------------------------+-------+

| Variable_name              | Value |

+----------------------------+-------+

| wait_timeout               | 10    |

+----------------------------+-------+
