# MySQL查询训练

[MySQL](http://lib.csdn.net/base/mysql "MySQL知识库")...

--1、查询"01"课程比"02"课程成绩高的学生的信息及课程分数

SELECT a.*,b.score AS'01分数',c.scoreAS '02分数'

FROM student a

INNER JOIN sc b

ON a.s=b.s AND b.c='01'

INNER JOIN sc c

ON a.s=c.s AND c.c='02'

WHERE b.score>c.score

--2、查询"01"课程比"02"课程成绩低的学生的信息及课程分数

--3、查询平均成绩大于等于60分的同学的学生编号和学生姓名和平均成绩

SELECT a.s

       ,a.sname

       ,AVG(b.score) AS avgnum

FROM student a

INNER JOIN sc b

ON a.s=b.s

GROUP BY a.s

       ,a.sname

HAVING AVG(b.score)>60

--4、查询平均成绩小于60分的同学的学生编号和学生姓名和平均成绩

--5、查询所有同学的学生编号、学生姓名、选课总数、所有课程的总成绩

SELECT a.s

       ,a.sname

       ,COUNT(b.c)

       ,SUM(b.score)

FROM student a

LEFT JOIN sc b

ON a.s=b.s

GROUP BY 1,2

--6、查询"李"姓老师的数量 

SELECT COUNT(1) FROM teacherWHERE tname LIKE '李%'

--7、查询学过"张三"老师授课的同学的信息 

SELECT a.*

FROM student a

INNER JOIN sc b

ON a.s=b.s

INNER JOIN course c

ON b.c=c.c

INNER JOIN teacher d

ON c.t=d.t

WHERE d.tname='张三'

GROUP BY 1,2,3,4

--方法2

SELECT a.*

FROM student a

LEFT JOIN (

       SELECT a.*

       FROM student a

       INNER JOIN sc b

       ON a.s=b.s

       INNER JOIN course c

       ON b.c=c.c

       INNER JOIN teacher d

       ON c.t=d.t

       WHERE d.tname='张三'

       GROUP BY 1,2,3,4

)b

ON a.s=b.s

WHERE b.s IS NULL

--8、查询没学过"张三"老师授课的同学的信息 

SELECT a.*

FROM student a

LEFT JOIN sc b

ON a.s=b.s

WHERE NOT EXISTS(

              SELECT *

              FROM course aa

              INNER JOIN teacher b

              ON aa.t=b.t

              INNER JOIN sc c

              ON aa.c=c.c

              WHERE b.tname='张三'

              AND c.s=a.s

       )

GROUP BY 1,2,3,4

--9、查询学过编号为"01"并且也学过编号为"02"的课程的同学的信息

SELECT a.*

FROM student a

INNER JOIN sc b

ON a.s=b.s AND b.c='01'

INNER JOIN sc c

ON a.s=c.s AND c.c='02'

--10、查询学过编号为"01"但是没有学过编号为"02"的课程的同学的信息

select *

from student a

left join sc b

on a.s=b.s and b.c='01'

left join sc c

on a.s=c.s and c.c='02'

where b.c='01' and c.c is null

--11、查询没有学全所有课程的同学的信息 

SELECT a.*

FROM student a

LEFT JOIN sc b

ON a.s=b.s

LEFT JOIN (SELECT COUNT(1) anumFROM course) c

ON 1=1

GROUP BY 1,2,3,4

HAVING MAX(c.anum)>COUNT(b.c)

--12、查询至少有一门课与学号为"01"的同学所学相同的同学的信息 

SELECT a.*

FROM student a

INNER JOIN sc b

ON a.s=b.s

WHERE EXISTS(

    SELECT 1 FROM sc WHERE s='01' AND c=b.c

)

GROUP BY 1,2,3,4

--13、查询和"01"号的同学学习的课程完全相同的其他同学的信息 

SELECTa.s,a.sname,a.sage,a.ssex

FROM (SELECT a.*,COUNT(b.c) ASsnum

       FROM student a

       INNER JOIN sc b

       ON a.s=b.s

       WHERE EXISTS(

           SELECT 1 FROM scWHERE s='01' AND c=b.c

       )

       GROUP BY 1,2,3,4)a

INNER JOIN (SELECTa.*,COUNT(b.c) AS anum

       FROM student a

       INNER JOIN sc b

       ON a.s=b.s

       GROUP BY 1,2,3,4)b

ON a.s=b.s

INNER JOIN (SELECT COUNT(1) ASnum1 FROM sc WHERE s='01')c

ON 1=1

WHERE a.snum=b.anum ANDa.snum=c.num1

--方法二

 

 

SELECT a.*

       ,COUNT(b.c) AS anum

       ,SUM(CASE WHEN EXISTS(SELECT 1 FROM sc WHERE s='01' AND c=b.c)THEN 1 ELSE 0 END) AS snum

       ,MAX(c.num1) AS num1

FROM student a

INNER JOIN sc b

ON a.s=b.s

INNER JOIN (SELECT COUNT(1) ASnum1 FROM sc WHERE s='01')c

ON 1=1

GROUP BY 1,2,3,4

HAVING anum=snum AND anum=num1

--14、查询没学过"张三"老师讲授的任一门课程的学生姓名 

SELECT a.*

FROM student a

LEFT JOIN(

       SELECT a.s

       FROM student a

       LEFT JOIN sc b

       ON a.s=b.s

       LEFT JOIN course c

       ON b.c=c.c

       LEFT JOIN teacher d

       ON c.t=d.t AND d.tname='张三'

       WHERE d.t IS NOT NULL

       )b

ON a.s=b.s

WHERE b.s IS NULL

--15、查询两门及其以上不及格课程的同学的学号，姓名及其平均成绩 

SELECT a.s

       ,a.sname

       ,AVG(b.score)

FROM student a

INNER JOIN sc b

ON a.s=b.s

GROUP BY 1,2

HAVING SUM(CASE WHENb.score>=60 THEN 0 ELSE 1 END)>=2

--16、检索"01"课程分数小于60，按分数降序排列的学生信息

SELECT a.*

       ,b.score

FROM student a

INNER JOIN sc b

ON a.s=b.s

WHERE

  b.c='01'

  AND b.score<60

ORDER BY b.score DESC

--17、按平均成绩从高到低显示所有学生的所有课程的成绩以及平均成绩

SELECT a.*

       ,SUM(CASE WHEN b.c='01' THEN b.scoreELSE 0 END) AS s01

       ,SUM(CASE WHEN b.c='02' THEN b.scoreELSE 0 END) AS s02

       ,SUM(CASE WHEN b.c='03' THEN b.score ELSE0 END) AS s03

       ,AVG(CASE WHEN b.score IS NULL THEN 0ELSE b.score END) avs

FROM student a

LEFT JOIN sc b

ON a.s=b.s

GROUP BY 1,2,3,4

ORDER BY avs DESC

--18、查询各科成绩最高分、最低分和平均分：以如下形式显示：课程ID，课程name，最高分，最低分，平均分，及格率，中等率，优良率，优秀率

--及格为>=60，中等为：70-80，优良为：80-90，优秀为：>=90

SELECT a.c

       ,a.cname

       ,MAX(b.score)

       ,MIN(b.score)

       ,AVG(b.score)

       ,SUM(CASE WHEN b.score>=60 THEN 1ELSE 0 END)/COUNT(1)

       ,SUM(CASE WHEN b.score>=70 ANDb.score<80 THEN 1 ELSE 0 END)/COUNT(1)

       ,SUM(CASE WHEN b.score>=80 ANDb.score<90 THEN 1 ELSE 0 END)/COUNT(1)

       ,SUM(CASE WHEN b.score>=90 THEN 1ELSE 0 END)/COUNT(1)

FROM course a

INNER JOIN sc b

ON a.c=b.c

GROUP BY 1,2

--19、按各科成绩进行排序，并显示排名

SET @rn:=0;

SELECT a.*,@rn:=@rn+1

FROM(

    SELECT a.*,b.score

    FROM course a

    INNER JOIN sc b

    ON a.c=b.c

    WHERE a.c='01'

    ORDER BY b.c,score DESC

)a

--20、查询学生的总成绩并进行排名

SELECT a.*

       ,COUNT(b.c)+1 asall

FROM sc a

LEFT JOIN sc b

ON a.c=b.c ANDa.score<b.score

GROUP BY 1,2,3

ORDER BY a.c,asall

--21、查询不同老师所教不同课程平均分从高到低显示 

SELECT a.*

       ,b.cname

       ,AVG(c.score) ascore

FROM teacher a

INNER JOIN course b

ON a.t=b.t

INNER JOIN sc c

ON b.c=c.c

GROUP BY 1,2,3

ORDER BY ascore DESC

--22、查询所有课程的成绩第2名到第3名的学生信息及该课程成绩

SELECT a.*,b.cname,b.score

FROM student a

INNER JOIN (

       SELECT a.*

              ,c.cname

              ,COUNT(b.c)+1 AStp

       FROM sc a

       LEFT JOIN sc b

       ON a.c=b.c AND a.score<b.score

       LEFT JOIN course c

       ON a.c=c.c

       GROUP BY 1,2,3,4

       HAVING COUNT(b.c)+1 IN(2,3)

       ORDER BY a.c,tp)b

ON a.s=b.s

--23、统计各科成绩各分数段人数：课程编号,课程名称,[100-85],[85-70],[70-60],[0-60]及所占百分比 

SELECT a.c

       ,a.cname

       ,SUM(CASE WHEN b.score<=100 ANDb.score>85 THEN 1 ELSE 0 END) AS '[100-85]'

       ,SUM(CASE WHEN b.score<=85 ANDb.score>70 THEN 1 ELSE 0 END) AS '[85-70]'

       ,SUM(CASE WHEN b.score<=70 ANDb.score>60 THEN 1 ELSE 0 END) AS '[70-60]'

       ,SUM(CASE WHEN b.score<=60 ANDb.score>0 THEN 1 ELSE 0 END) AS '[60-0]'

      

       ,SUM(CASE WHEN b.score<=100 ANDb.score>85 THEN 1 ELSE 0 END)/COUNT(1) AS '[100-85]%'

       ,SUM(CASE WHEN b.score<=85 ANDb.score>70 THEN 1 ELSE 0 END)/COUNT(1) AS '[85-70]%'

       ,SUM(CASE WHEN b.score<=70 ANDb.score>60 THEN 1 ELSE 0 END)/COUNT(1) AS '[70-60]%'

       ,SUM(CASE WHEN b.score<=60 ANDb.score>0 THEN 1 ELSE 0 END)/COUNT(1) AS '[60-0]%'

FROM course a

INNER JOIN sc b

ON a.c=b.c

GROUP BY 1,2

--24、查询学生平均成绩及其名次 

SELECT a.*

       ,COUNT(b.s)+1

FROM (

       SELECT a.*,AVG(CASE WHEN b.score IS NULL THEN 0 ELSE b.scoreEND) AS ascore

       FROM student a

       LEFT JOIN sc b

       ON a.s=b.s

       GROUP BY 1,2,3,4

      )a

LEFT JOIN(

       SELECT a.*,AVG(CASE WHEN b.score IS NULL THEN 0 ELSE b.scoreEND) AS ascore

       FROM student a

       LEFT JOIN sc b

       ON a.s=b.s

       GROUP BY 1,2,3,4

      )b

ON a.ascore<b.ascore

GROUP BY 1,2,3,4,5

--25、查询各科成绩前三名的记录

SELECT a.*,COUNT(b.c)+1 ASascore

FROM sc a

LEFT JOIN sc b

ON a.c=b.c ANDa.score<b.score

GROUP BY 1,2,3

HAVING ascore<=3

ORDER BY a.c,ascore

--26、查询每门课程被选修的学生数 

SELECT a.*

       ,COUNT(b.s)

FROM course a

LEFT JOIN sc b

ON a.c=b.c

GROUP BY 1,2,3

--27、查询出只有两门课程的全部学生的学号和姓名  

SELECT a.*

       ,COUNT(b.c)

FROM student a

LEFT JOIN sc b

ON a.s=b.s

GROUP BY 1,2,3,4

HAVING COUNT(b.c)=2

--28、查询男生、女生人数 

--29、查询名字中含有"风"字的学生信息

--30、查询同名同性学生名单，并统计同名人数

 SELECT sname

       ,ssex

       ,COUNT(1)

FROM student

GROUP BY 1,2

HAVING COUNT(1)>1

--31、查询1990年出生的学生名单(注：Student表中Sage列的类型是datetime) 

SELECT * FROM student WHEREYEAR(sage)=1990

--32、查询每门课程的平均成绩，结果按平均成绩降序排列，平均成绩相同时，按课程编号

SELECT a.*

       ,AVG(b.score) ascore

FROM course a

LEFT JOIN sc b

ON a.c=b.c

GROUP BY 1,2,3

ORDER BYascore DESC,a.c

--33、查询平均成绩大于等于85的所有学生的学号、姓名和平均成绩 

SELECT a.*

       ,AVG(b.score) ascore

FROM student a

LEFT JOIN sc b

ON a.s=b.s

GROUP BY 1,2,3,4

HAVING ascore>=85

--34、查询课程名称为"数学"，且分数低于60的学生姓名和分数 

SELECT c.*

FROM course a

LEFT JOIN sc b

ON a.c=b.c

LEFT JOIN student c

ON b.s=c.s

WHERE a.cname='数学'

AND b.score<60

--35、查询所有学生的课程及分数情况； 

SELECT *

FROM sc a

INNER JOIN student b

ON a.s=b.s

INNER JOIN course c

ON a.c=c.c

--36、查询任何一门课程成绩在70分以上的姓名、课程名称和分数； 

SELECT b.sname

       ,c.cname

       ,a.score

FROM sc a

INNER JOIN student b

ON a.s=b.s

INNER JOIN course c

ON a.c=c.c

WHERE a.score>70

--37、查询不及格的课程

--38、查询课程编号为01且课程成绩在80分以上的学生的学号和姓名； 

SELECT a.*

FROM student a

INNER JOIN sc b

ON a.s=b.s

WHERE b.c='01' AND b.score>80

--39、求每门课程的学生人数 

--40、查询选修"张三"老师所授课程的学生中，成绩最高的学生信息及其成绩

SELECT a.*,b.score

FROM student a

INNER JOIN sc b

ON a.s=b.s

INNER JOIN(

       SELECT c.c

              ,MAX(c.score) ASmaxscore

       FROM teacher a

       INNER JOIN course b

       ON a.t=b.t

       INNER JOIN sc c

       ON b.c=c.c

       WHERE a.tname='张三'

       GROUP BY c)c

ON b.c=c.c ANDb.score=c.maxscore

--41、查询不同课程成绩相同的学生的学生编号、课程编号、学生成绩 

SELECT a.s

       ,a.c

       ,a.score

FROM sc a

INNER JOIN (

       SELECT a.score

              ,b.s

              ,COUNT(1)

       FROM sc a

       INNER JOIN student b

       ON a.s=b.s

       GROUP BY a.score,b.s

       HAVING COUNT(1)>1

)b

ON a.s=b.s AND a.score=b.score

 

方法二

SELECT a.*

FROM sc a

LEFT JOIN sc b

ON a.s=b.s AND a.score=b.scoreAND a.c<>b.c

GROUP BY 1,2,3

HAVING COUNT(b.s)>0

--42、查询每门功成绩最好的前两名 

--43、统计每门课程的学生选修人数（超过5人的课程才统计）。要求输出课程号和选修人数，查询结果按人数降序排列，若人数相同，按课程号升序排列  

SELECT a.c

       ,COUNT(1) AS pnum

FROM sc a

GROUP BY 1

HAVING pnum>5

ORDER BY pnum DESC,a.c

--44、检索至少选修两门课程的学生学号 

--45、查询选修了全部课程的学生信息 

--46、查询各学生的年龄

SELECT a.*,YEAR(CURDATE())-YEAR(a.sage)

FROM student a

--47、查询本周过生日的学生

SELECT a.*

FROM student a

WHERECONCAT(MONTH(a.sage),DAY(a.sage))>=CONCAT(MONTH(SUBDATE(CURDATE(),WEEKDAY(CURDATE()))),DAY(SUBDATE(CURDATE(),WEEKDAY(CURDATE()))))

AND CONCAT(MONTH(a.sage),DAY(a.sage))<=CONCAT(MONTH(SUBDATE(CURDATE(),WEEKDAY(CURDATE())-6)),DAY(SUBDATE(CURDATE(),WEEKDAY(CURDATE())-6)))

--48、查询下周过生日的学生

--49、查询本月过生日的学生

SELECT a.* FROM student a WHEREMONTH(a.sage)=MONTH(CURDATE())

--50、查询下月过生日的学生

SELECT a.*FROM student a WHERE MONTH(a.sage)=MONTH(CURDATE())+1

--51

select count(*) from sometable where datetimecolumn>=UNIX_TIMESTAMP('2010-03-01 00:00:00') and datetimecolumn<UNIX_TIMESTAMP('2010-03-02 00:00:00')
