# MYSQL查询某字段中以逗号分隔的字符串的方法

# [MYSQL查询某字段中以逗号分隔的字符串的方法](https://www.cnblogs.com/gmq-sh/p/6848929.html)

首先我们建立一张带有逗号分隔的字符串。

CREATE TABLE test(id int(6) NOT NULL AUTO_INCREMENT,PRIMARY KEY (id),pname VARCHAR(20) NOT NULL,pnum VARCHAR(50) NOT NULL);

然后插入带有逗号分隔的测试数据

INSERT INTO test(pname,pnum) VALUES('产品1','1,2,4');

INSERT INTO test(pname,pnum) VALUES('产品2','2,4,7');

INSERT INTO test(pname,pnum) VALUES('产品3','3,4');

INSERT INTO test(pname,pnum) VALUES('产品4','1,7,8,9');

INSERT INTO test(pname,pnum) VALUES('产品5','33,4');

 

**查找pnum字段中包含3或者9的记录**

[MySQL](http://lib.csdn.net/base/mysql "MySQL知识库")> SELECT * FROM test WHERE find_in_set('3',pnum) OR find_in_set('9',pnum);

+----+-------+---------+

| id | pname | pnum    |

+----+-------+---------+

|  3 | 产品3 | 3,4     |

|  4 | 产品4 | 1,7,8,9 |

+----+-------+---------+

2 rows in set (0.03 sec)

 

**使用正则**

mysql> SELECT * FROM test WHERE pnum REGEXP '(3|9)';

+----+-------+---------+

| id | pname | pnum    |

+----+-------+---------+

|  3 | 产品3 | 3,4     |

|  4 | 产品4 | 1,7,8,9 |

|  5 | 产品5 | 33,4    |

+----+-------+---------+

3 rows in set (0.02 sec)

这样会产生多条记录，比如33也被查找出来了。

 

换一种方式

 

 

1. **mysql>�**�**SELECT *�**�**FROM test�**�**WHERE CONCAT(****',',pnum,****',') REGEXP�**�**'[^0-9]+[3|9][^0-9]+'; �**�

+----+-------+---------+

| id | pname | pnum    |

+----+-------+---------+

|  3 | 产品3 | 3,4     |

|  4 | 产品4 | 1,7,8,9 |

+----+-------+---------+

2 rows in set (0.01 sec)

 

 

3、select * from oa_student_archives where CONCAT(',',pe_projects,',') like '%,11,%';

这种方式也可以。

 

注意：

标红的**mysql>�**�**SELECT *�**�**FROM test�**�**WHERE CONCAT(****',',pnum,****',') REGEXP�**�**'[^0-9]+[3|9][^0-9]+';�**�

**这种，当时小于10的数据搜索是可以的，但是如果是大于10的，则不能用，原因我还不太清楚，有大神可以解释下吗？**

 

总结如下：

1、select * from oa_student_archives where CONCAT(',',pe_projects,',') like '%,11,%';

2、select * from oa_student_archives where find_in_set('12', pe_projects);

 

以上的两个都可以用。

 
