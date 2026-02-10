Mysql优化技巧（转、持续更新......）

#### 1、查询SQL尽量不要使用select *，而是具体字段

反例

```
SELECT * FROM user
```

正例

```
SELECT id,username,tel FROM user
```

理由

1.节省资源、减少网络开销。  
2.可能用到覆盖索引，减少回表，提高查询效率。

#### 2、避免在where子句中使用 or 来连接条件

反例

```
SELECT * FROM user WHERE id=1 OR salary=5000
```

正例  
（1）使用  `union all`  

```
SELECT * FROM user WHERE id=1 
UNION ALL
SELECT * FROM user WHERE salary=5000
```

（2）分开两条sql写

```
SELECT * FROM user WHERE id=1

SELECT * FROM user WHERE salary=5000

```

理由

1. 使用  `or`  可能会使索引失效，从而全表扫描；
1. 对于  `or`  没有索引的salary这种情况，假设它走了id的索引，但是走到salary查询条件时，它还得全表扫描；
1. 也就是说整个过程需要三步：全表扫描+索引扫描+合并。如果它一开始就走全表扫描，直接一遍扫描就搞定；
1. 虽然mysql是有优化器的，出于效率与成本考虑，遇到or条件，索引还是可能失效的；


#### 3、尽量使用数值替代字符串类型

正例

1. 主键（id）：primary key优先使用数值类型  `int`  ，  `tinyint`  
1. 性别（sex）：0代表女，1代表男；数据库没有布尔类型，mysql推荐使用  `tinyint`  


理由

1. 因为引擎在处理查询和连接时会逐个比较字符串中每一个字符；
1. 而对于数字型而言只需要比较一次就够了；
1. 字符会降低查询和连接的性能，并会增加存储开销；


#### 4、使用varchar代替char

反例

```
`address` char(100) DEFAULT NULL COMMENT '地址'
```

正例

```
`address` varchar(100) DEFAULT NULL COMMENT '地址'
```

理由

1.   `varchar`  变长字段按数据内容实际长度存储，存储空间小，可以节省存储空间；
1.   `char`  按声明大小存储，不足补空格；
1. 其次对于查询来说，在一个相对较小的字段内搜索，效率更高；


#### 5、where中使用默认值代替null

反例

```
SELECT * FROM user WHERE age IS NOT NULL
```

正例

```
SELECT * FROM user WHERE age>0
```

理由

1. 并不是说使用了  `is null`  或者   `is not null`  就会不走索引了，这个跟mysql版本以及查询成本都有关；
1. 如果mysql优化器发现，走索引比不走索引成本还要高，就会放弃索引，这些条件   `!=，<>，is null，is not null`  经常被认为让索引失效；
1. 其实是因为一般情况下，查询的成本高，优化器自动放弃索引的；
1. 如果把null值，换成默认值，很多时候让走索引成为可能，同时，表达意思也相对清晰一点；


#### 6、避免在where子句中使用!=或<>操作符

反例

```
SELECT * FROM user WHERE salary!=5000

SELECT * FROM user WHERE salary<>5000
```

理由

1. 使用  `!=`  和  `<>`  很可能会让索引失效
1. 应尽量避免在  `where`  子句中使用  `!=`  或  `<>`  操作符，否则引擎将放弃使用索引而进行全表扫描
1. 实现业务优先，实在没办法，就只能使用，并不是不能使用


#### 7、inner join 、left join、right join，优先使用inner join

三种连接如果结果相同，优先使用inner join，如果使用left join左边表尽量小。

- inner join 内连接，只保留两张表中完全匹配的结果集；
- left join会返回左表所有的行，即使在右表中没有匹配的记录；
- right join会返回右表所有的行，即使在左表中没有匹配的记录；


为什么？

- 如果inner join是等值连接，返回的行数比较少，所以性能相对会好一点；
- 使用了左连接，左边表数据结果尽量小，条件尽量放到左边处理，意味着返回的行数可能比较少；
- 这是mysql优化原则，就是小表驱动大表，小的数据集驱动大的数据集，从而让性能更优；


#### 8、提高group by语句的效率

反例  
先分组，再过滤

```
select job, avg（salary） from employee 
group by job
having job ='develop' or job = 'test';
```

正例

先过滤，后分组

```
select job，avg（salary） from employee 
where job ='develop' or job = 'test' 
group by job;
```

理由

可以在执行到该语句前，把不需要的记录过滤掉

#### 9、清空表时优先使用[truncate]

truncate table在功能上与不带 where子句的 delete语句相同：二者均删除表中的全部行。但 truncate table比 delete速度快，且使用的系统和事务日志资源少。

delete语句每次删除一行，并在事务日志中为所删除的每行记录一项。truncate table通过释放存储表数据所用的数据页来删除数据，并且只在事务日志中记录页的释放。

truncate table删除表中的所有行，但表结构及其列、约束、索引等保持不变。新行标识所用的计数值重置为该列的种子。如果想保留标识计数值，请改用 DELETE。如果要删除表定义及其数据，请使用 drop table语句。

对于由 foreign key约束引用的表，不能使用 truncate table，而应使用不带 where子句的 DELETE 语句。由于 truncate table不记录在日志中，所以它不能激活触发器。

truncate table不能用于参与了索引视图的表。

#### 10、操作delete或者update语句，加个limit或者循环分批次删除

1、降低写错SQL的代价

清空表数据可不是小事情，一个手抖全没了，删库跑路？如果加limit，删错也只是丢失部分数据，可以通过binlog日志快速恢复的。

2、SQL效率很可能更高

SQL中加了limit 1，如果第一条就命中目标return， 没有limit的话，还会继续执行扫描表。

3、避免长事务

delete执行时,如果age加了索引，MySQL会将所有相关的行加写锁和间隙锁，所有执行相关行会被锁住，如果删除数量大，会直接影响相关业务无法使用。

4、数据量大的话，容易把CPU打满

如果你删除数据量很大时，不加 limit限制一下记录数，容易把cpu打满，导致越删越慢。

5、锁表

一次性删除太多数据，可能造成锁表，会有lock wait timeout exceed的错误，所以建议分批操作。

#### 11、优化like语句

模糊查询，程序员最喜欢的就是使用like，但是like很可能让你的索引失效。  
c反例

```
select * from citys where name like '%大连' (不使用索引)

select * from citys where name like '%大连%' (不使用索引)
```

正例

```
select * from citys where name like '大连%' (使用索引) 。
```

理由

- 首先尽量避免模糊查询，如果必须使用，不采用全模糊查询，也应尽量采用右模糊查询， 即like ‘…%’，是会使用索引的；
- 左模糊like ‘%…’无法直接使用索引，但可以利用reverse + function index的形式，变化成 like ‘…%’；
- 全模糊查询是无法优化的，一定要使用的话建议使用搜索引擎。

