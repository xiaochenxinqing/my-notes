# Mysql性能调优(my.cnf参数篇)

# [Mysql性能调优(my.cnf参数篇)](https://www.cnblogs.com/wangyifu/p/7202656.html)

MySQL的合理优化，直接影响到DB的速度和承载量！

MySQL也是优化难度最大的一个部分，不但需要理解一些MySQL专业知识，同时还需要长时间的观察统计并且根据经验进行判断，然后设置合理的参数。

本主题调优针对于my.cnf配置来做详细的参数说明

示例配置如下：

#cat my.cnf

# MySQL client library initialization.

[client]

port            = 3306

socket          = /tmp/mysql.sock

character-set-server = utf8

# The MySQL server

[mysqld]

init_connect = 'set names utf8' //设定连接mysql数据库时使用utf8编码，以让mysql数据库以utf8运行

   >show variables like 'character%'\G; 可查询mysql字符相关

init_connect = 'SET autocommit=0' //关闭自动提交模式，就认为用户总是以事务方式操作

character-set-server = utf8

port            = 3306

socket          = /tmp/mysql.sock

basedir         = /opt/justone/mysqldM/mysql

datadir         = /opt/justone/mysqldM/mysql/data

skip-locking //避免MySQL的外部锁定，减少出错几率增强稳定性。

#skip-networking //开启该选项即彻底关闭MySQL的TCP/IP连接方式，如果WEB服务器是以远程连接的方式访问MySQL数据库服务器则不要开启该选项！否则将无法正常连接！

skip_name_resolve //禁止MySQL对外部连接进行DNS解析，使用这一选项可以消除MySQL进行DNS解析的时间。如果开启该选项，则所有远程主机连接授权都要使用IP地址方式，否则MySQL将无法正常处理连接请求！

#back_log = 384 //监听队列中所能保持的连接数即保存了在MySQL连接管理器线程处理之前的连接。

   back_log参数的值指出在MySQL暂时停止响应新请求之前的短时间内多少个请求可以被存在堆栈中。

   如果一个短时间内有很多连接，则需要增大该参数的值，来指定到来的TCP/IP连接的侦听队列的大小。

   不同的操作系统在这个队列大小上有它自己的限制。试图设定back_log高于你的操作系统的限制将是无效的。

   默认值为50。对于Linux系统推荐设置为小于512的整数。系统值由ulimit -a查看。

max_connections = 2000 //允许的同时客户的数量。增加该值即增加mysqld要求的文件描述符的数量。

   注：该值过小，客户端会经常有Too many connections 错误。

wait_timeout=10 //指定一个请求的最大连接时间，对于4GB左右内存的服务器可以设置为5-10。

max_connect_errors = 500 //如同一主机有超出该参数值个数的中断错误连接，则该主机将被禁止连接。

   如需对该主机进行解禁，执行：FLUSH HOST;

table_open_cache = 2048 //所有线程打开表的数量

max_allowed_packet = 16M //一个查询语句包的最大尺寸,信息交换中使用信息包的允许大小(如：导入表)

     用客户端工具如sqlyog异地cp数据库出错时，可考虑加大此值。

max_heap_table_size = 256M //HEAP数据表(内存表)的最大长度(默认设置是16M);

   超过这个长度的HEAP数据表将被存入一个临时文件而不是驻留在内存里。

sort_buffer_size = 512K //查询排序时所能使用的缓冲区大小。

   该参数对应的分配内存是每连接独占,如有100个连接，实际分配的排序缓冲区大小为100×512K＝50MB。

   所以，对于内存在4GB左右的服务器推荐设置为6-8M。

join_buffer_size = 1M //联合查询操作所能使用的缓冲区大小，该参数对应的分配内存也是每连接独享.

thread_cache_size = 8 //可以复用的保存在线程缓存中的线程的数量.内存G*8即2G设为16

   数据库的每一个连接都要使用自己的线程。线程创建需要时间，所以如果这个连接关闭时并不需要关闭这个线程，服务器会把它保存在自己的线程缓存中，以便下一个连接使用。

thread_concurrency = 8 //该参数取值为服务器逻辑CPU数量×2

bulk_insert_buffer_size = 8M //指定 MyISAM 类型数据表表使用特殊的树形结构的缓存。

   使用整块方式(bulk)能够加快插入操作( INSERT … SELECT, INSERT … VALUES (…), (…), …, 和 LOAD DATA INFILE) 的速度和效率。该参数限制每个线程使用的树形结构缓存大小，如果设置为0则禁用该加速缓存功能。注意：该参数对应的缓存操作只能用户向非空数据表中执行插入操作！默认值为 8MB。

query_cache_size = 64M //指定MySQL查询缓冲区的大小。

   可以通过在MySQL控制台执行以下命令观察：

   > SHOW VARIABLES LIKE '%query_cache%';

   > SHOW STATUS LIKE 'Qcache%';

   Qcache_lowmem_prunes的值非常大，则表明经常出现缓冲不够的情况；

   Qcache_hits的值非常大，则表明查询缓冲使用非常频繁，如果该值较小反而会影响效率，那么可以考虑不用查询缓冲；

   Qcache_free_blocks，如果该值非常大，则表明缓冲区中碎片很多。

default-storage-engine = InnoDB //新数据表的默认数据表类型 默认设置是MyISAM

lower_case_table_names = 1 //MySQL实现不区分大小写

transaction_isolation = REPEATABLE-READ //设置所有连接的默认事务隔离级

tmp_table_size = 256M //临时HEAP数据表的最大长度

   默认设置是32M; 超过这个长度的临时数据表将被转换为MyISAM数据表并存入一个临时文件。

slow_query_log = 1

log = /opt/justone/mysqldM/mysql/logs/mysql.log

long_query_time = 2

log-slow-queries = /opt/justone/mysqldM/mysql/logs/slowquery.log

# Replication related settings

server-id = 1 //设定为master

log-bin=mysql-bin //产生的log以mysql-bin开头

binlog_cache_size = 8M //为binary log指定在查询请求处理过程中SQL 查询语句使用的缓存大小。

   如果频繁应用于大量、复杂的SQL表达式处理，则应该加大该参数值以获得性能提升。

binlog_format=mixed //日志格式,亦可自定义。

InnoDB和MyISAM类型区别

   InnoDB和MyISAM是许多人在使用MySQL时最常用的两个表类型，这两个表类型各有优劣，视具体应用而定。

   基本的差别为：MyISAM类型不支持事务处理等高级处理，而InnoDB类型支持。

   MyISAM类型的表强调的是性能，其执行数度比InnoDB类型更快，但是不提供事务支持，而InnoDB提供事务支持已经外部键等高级数据库功能。

   InnoDB注意的地方：

   1.InnoDB不支持FULLTEXT类型的索引。

   2.InnoDB 中不保存表的具体行数，也就是说，执行select count(*) from table时，InnoDB要扫描一遍整个表来计算有多少行，但是MyISAM只要简单的读出保存好的行数即可。注意的是，当count(*)语句包含 where条件时，两种表的操作是一样的。

   3.对于AUTO_INCREMENT类型的字段，InnoDB中必须包含只有该字段的索引，但是在MyISAM表中，可以和其他字段一起建立联合索引。

   4.DELETE FROM table时，InnoDB不会重新建立表，而是一行一行的删除。

   5.LOAD TABLE FROM MASTER操作对InnoDB是不起作用的，解决方法是首先把InnoDB表改成MyISAM表，导入数据后再改成InnoDB表，但是对于使用的额外的InnoDB特性（例如外键）的表不适用。

   6.InnoDB表的行锁也不是绝对的，如果在执行一个SQL语句时MySQL不能确定要扫描的范围，InnoDB表同样会锁全表，例如update table set num=1 where name like “?a%”

# MyISAM Specific options

key_buffer_size = 32M //索引块的缓冲区大小，增加它可得到更好处理的索引(对所有读和多重写)

   索引块是缓冲的并且被所有的线程共享。如果你使它太大，系统将开始换页并且真的变慢了。

   默认数值是8388600(8M)，MySQL主机有2GB内存，可设为402649088(400MB)。

   注意：该参数值设置的过大反而会是服务器整体效率降低！

read_buffer_size = 256K //读查询操作所能使用的缓冲区大小，该参数对应的分配内存也是每连接独享.

read_rnd_buffer_size = 256K //针对按某种特定顺序(如ORDER BY子句)输出的查询结果(默认256K)

   加速排序操作后的读数据，提高读分类行的速度。

myisam_sort_buffer_size = 128M //myisam引擎的sort_buffer_size

myisam_max_sort_file_size = 10G //类似于上

myisam_recover //自动检查和修复无法正确关闭MyISAM表

#skip-innodb //去掉innodb支持

#skip-bdb //去掉bdb事务型表支持

# INNODB Specific options ***

innodb_additional_mem_pool_size = 16M //InnoDB用来存储数据字典和其他内部数据结构的内存池大小。

   应用程序里的表越多就应该分配越多的内存，如果innodb用光了这个内存就会向系统内存要。

   并且写入警告日志,根据MySQL手册，对于2G内存的机器，推荐值是20M。

   缺省值是1M。通常不用太大，只要够用就行，与表结构的复杂度有关系。

#innodb_buffer_pool_size = 6G //指定大小的内存来缓冲数据和索引。

   对于单独的MySQL数据库服务器，最大可以把该值设置成物理内存的80%。

   根据MySQL手册，对于2G内存的机器，推荐值是1G（50%）

innodb_buffer_pool_size = 512M

innodb_data_file_path = ibdata1:10M:autoextend //用来容纳InnoDB为数据表的表空间:

   可能涉及一个以上的文件; 每一个表空间文件的最大长度都必须以字节(B)、兆字节(MB)或千兆字节(GB)为单位给出;

   表空间文件的名字必须以分号隔开; 最后一个表空间文件还可以带一个autoextend属性和一个最大长度(max:n)。

   例如，ibdata1:1G;ibdata2:1G:autoextend:max:2G的意思是:

     表空间文件ibdata1的最大长度是1GB，ibdata2的最大长度也是1G，但允许它扩充到2GB。

   除文件名外，还可以用硬盘分区的设置名来定义表空间，此时必须给表空间的最大初始长度值加上newraw关键字做后缀，给表空间的最大扩充长度值加上raw关键字做后缀(例如/dev/hdb1:20Gnewraw或/dev/hdb1:20Graw); MySQL 4.0及更高版本的默认设置是ibdata1:10M:autoextend。

innodb_file_io_threads = 4 //IO操作(硬盘写操作)的最大线程个数(默认设置是4)。

innodb_file_per_table = 1 //为每一个新数据表创建一个表空间文件而不是把数据表都集中保存在中央表空间里

   如果系统中表的个数不多，并且没有超大表，使用该参数可以使得各个表之间的,维护相对独立。

innodb_thread_concurrency = 16 //InnoDB驱动程序能够同时使用的最大线程个数(默认设置是8)。

innodb_flush_log_at_trx_commit = 1 //InnoDB记录日志的方式。

   如果设置为1，则每个事务提交的时候，MySQL都会将事务日志写入磁盘。

   如果设置为0或者2，则大概每秒中将日志写入磁盘一次。

   实际测试发现，该值对插入数据的速度影响非常大

     设置为2时插入10000条记录只需要2秒，设置为0时只需要1秒，而设置为1时则需要229秒。

   建议尽量将插入操作合并成一个事务，这样可以大幅提高速度。

   在存在丢失最近部分事务的危险的前提下，可以把该值设为0。

innodb_log_buffer_size = 8M //日志缓存的大小

   默认的设置在中等强度写入负载以及较短事务的情况下，一般可以满足服务器的性能要求。

   如果更新操作峰值或者负载较大就应该加大这个值。8-16M即可。

innodb_log_file_size = 256M //日志组中每个日志文件的大小 在高写入负载尤其是大数据集的情况下很重要。

   这个值越大性能就越高，但恢复时时间会加长。默认是5M。 Javaeye推荐innodb_log_file_size = 64M

   需要注意的是 修改完以后要STOP服务 接着删除原来的日志ib_logfile0和ib_logfile1，然后启动服务.

   整体性能分析报告> show engine innodb status\G;

innodb_log_files_in_group = 3 //日志组中的日志文件数目,推荐使用3

innodb_max_dirty_pages_pct = 90 //最大脏页的百分数

   当系统中脏页所占百分比超过这个值，INNODB就会进行写操作以把页中的已更新数据写入到磁盘文件中。

innodb_flush_method = O_DIRECT //InnoDB日志文件的同步办法(仅适用于UNIX/Linux系统)。

   O_DIRECT跳过了操作系统的文件系统Disk Cache，让MySQL直接读写磁盘。

innodb_lock_wait_timeout = 120 //事务获得资源超时设置,默认50s

   如果某个事务在等待n秒(s)后还没有获得所需要的资源，就使用ROLLBACK命令放弃这个事务。

   这项设置对于发现和处理未能被InnoDB数据表驱动程序识别出来的死锁条件有着重要的意义。

   但是不能对表锁导致的死锁进行自动监测。

[mysqldump]

quick //不缓冲查询，直接导出至stdout；使用mysql_use_result()做它。

   不要在将内存中的整个结果写入磁盘之前缓存. 在导出非常巨大的表时需要此项

max_allowed_packet = 16M

[mysql]

no-auto-rehash //不自动补齐命令，设置auto-rehash为自动补齐。默认TAB补齐

#safe-updates //仅仅允许使用键值的 UPDATE 和 DELETE

[myisamchk] //MyISAM表维护的一个非常实用的工具。

   可以使用myisamchk实用程序来获得有关数据库表的信息或检查、修复、优化他们。

   myisamchk适用MyISAM表(对应.MYI和.MYD文件的表)。

key_buffer_size = 512M

sort_buffer_size = 512M

read_buffer = 8M

write_buffer = 8M

[mysqlhotcopy]

interactive-timeout //把一个数据传输的最大时间量设置为默认的28800秒

[mysqld_safe]

open-files-limit = 8192 //每个进程的可打开文件数量.

   确认你已经将系统限制设定的足够高 #ulimit -HSn 65536

另：服务器硬件对MySQL性能的影响

   a) 磁盘寻道能力（磁盘I/O）

     目前高转速SCSI硬盘(7200转/秒)理论上每秒寻道7200次，物理特性，无法改变.

     MySQL每秒钟都在进行大量、复杂的查询操作，对磁盘的读写量可想而知。

     磁盘I/O是制约MySQL性能的最大因素之一.如：日均访问100Wpv的论坛.

     由于磁盘I/O的制约，MySQL的性能会非常低下,可以考虑以下几种解决方案：

       使用RAID-0+1磁盘阵列

         注意不要尝试使用RAID-5，MySQL在RAID-5磁盘阵列上的效率不会像你期待的那样快；

       抛弃传统的硬盘，使用速度更快的闪存式存储设备。

         经过Discuz!公司技术工程的测试，使用闪存式存储设备可比传统硬盘速度高出6－10倍左右。

   b) CPU 对于MySQL应用，推荐使用S.M.P.架构的多路对称CPU，例如：两颗Intel Xeon 3.6GHz的CPU。

   c) 服务器内存建议不要小于2GB，推荐使用4GB以上的物理内存。
