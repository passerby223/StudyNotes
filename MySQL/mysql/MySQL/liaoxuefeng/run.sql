-- 查询数据-基本查询
-- 查询出students表的所有数据
select *
from students;
-- 查询出classes表的所有数据
SELECT *
FROM classes;
-- 下述查询会直接计算出表达式的结果。虽然SELECT可以用作计算，但它并不是SQL的强项。
-- 但是，不带FROM子句的SELECT语句有一个有用的用途，就是用来判断当前到数据库的连接是否有效。
-- 许多检测工具会执行一条SELECT 1;来测试数据库连接。
SELECT 100 + 200;
select 1;
-- 小结
-- 使用SELECT查询的基本语句SELECT * FROM <表名>可以查询一个表的所有行和所有列的数据。
-- SELECT查询的结果是一个二维表。

-- 查询数据-条件查询
-- 查询分数在85分(包含85)以上的学生记录
select *
from students
where score >= 85;
-- 查询分数在85分(包含85)以上的男生
select *
from students
where score >= 85
  and gender = 'M';
-- 查询分数在85分(包含85)或性别是男生的学生信息
select *
from students
where score >= 85
   or gender = 'M';
-- 查询不是2班学生的学生信息
select *
from students
where not class_id = 2;
-- 上述NOT条件`NOT class_id = 2`其实等价于`class_id <> 2`，因此，NOT查询不是很常用。
select *
from students
where class_id <> 2;
-- 查询分数在80以下或者90以上，并且是男生的学生信息
select *
from students
where (score < 80 or score > 90)
  and gender = 'M';
-- 如果不加括号，条件运算按照NOT、AND、OR的优先级进行，即NOT优先级最高，其次是AND，最后是OR。加上括号可以改变优先级。
-- 常用的条件表达式
-- 条件	                表达式举例1	        表达式举例2	            说明
-- 使用=判断相等	        score = 80	        name = 'abc'	    字符串需要用单引号括起来
-- 使用>判断大于	        score > 80	        name > 'abc'	    字符串比较根据ASCII码，中文字符比较根据数据库设置
-- 使用>=判断大于或相等	score >= 80	        name >= 'abc'
-- 使用<判断小于	        score < 80	        name <= 'abc'
-- 使用<=判断小于或相等	score <= 80	        name <= 'abc'
-- 使用<>判断不相等	    score <> 80	        name <> 'abc'
-- 使用LIKE判断相似	    name LIKE 'ab%'	    name LIKE '%bc%'	%表示任意字符，例如'ab%'将匹配'ab'，'abc'，'abcd'
-- 小结
-- 通过WHERE条件查询，可以筛选出符合指定条件的记录，而不是整个表的所有记录。

-- 查询数据-投影查询
-- 使用SELECT * FROM <表名> WHERE <条件>可以选出表中的若干条记录。我们注意到返回的二维表结构和原表是相同的，即结果集的所有列与原表的所有列都一一对应。
-- 如果我们只希望返回某些列的数据，而不是所有列的数据，我们可以用SELECT 列1, 列2, 列3 FROM ...，让结果集仅包含指定列。这种操作称为投影查询。
-- 例如，从students表中返回id、score和name这三列
select id, score, name
from students;
-- 给查询列名取别名
select id as i, score as p, name as n
from students;
-- 投影查询进行条件查询
select id as i, score as p, name as n
from students
where score >= 80;
-- 小结
-- 使用SELECT *表示查询表的所有列，使用SELECT 列1, 列2, 列3则可以仅返回指定列，这种操作称为投影。
-- SELECT语句可以对结果集的列进行重命名。

-- 查询数据-排序
-- 使用SELECT查询时，查询结果集通常是按照id排序的，也就是根据主键排序。可以加上ORDER BY子句按照其他列名进行排序。
-- 按score从低到高
-- 默认的排序规则是ASC：“升序”，即从小到大。ASC可以省略，即ORDER BY score ASC和ORDER BY score效果一样。
select id, name, gender, score
from students
order by score;
-- 按score从高到低
select id, name, gender, score
from students
order by score desc;
-- 如果score列有相同的数据，要进一步排序，可以继续添加列名。例如，使用ORDER BY score DESC, gender表示先按score列倒序，如果有相同分数的，再按gender列排序
select id, name, gender, score
from students
order by score desc, gender;
-- 如果有WHERE子句，那么ORDER BY子句要放到WHERE子句后面。例如，查询一班的学生成绩，并按照倒序排序
select id, name, class_id, gender, score
from students
where class_id = 1
order by score desc;
-- 小结
-- 使用ORDER BY可以对结果集进行排序；
-- 可以对多列进行升序、倒序排序。

-- 查询数据-分页查询
-- 使用SELECT查询时，如果结果集数据量很大，比如几万行数据，放在一个页面显示的话数据量太大，不如分页显示，每次显示100条。
-- 分页实际上就是从结果集中“截取”出第M~N条记录。这个查询可以通过LIMIT <M> OFFSET <N>子句实现。
-- 按score从高到低
SELECT id, name, gender, score
FROM students
ORDER BY score DESC
limit 3 offset 0;
SELECT id, name, gender, score
FROM students
ORDER BY score DESC
limit 0, 3;
-- 上述查询LIMIT 3 OFFSET 0表示，对结果集从0号记录开始，最多取3条。注意SQL记录集的索引从0开始。
-- 如果要查询第2页，那么我们只需要“跳过”头3条记录，也就是对结果集从3号记录开始查询，把OFFSET设定为3
SELECT id, name, gender, score
FROM students
ORDER BY score DESC
limit 3 offset 3;
SELECT id, name, gender, score
FROM students
ORDER BY score DESC
limit 3, 3;
-- 类似的，查询第3页的时候，OFFSET应该设定为6
SELECT id, name, gender, score
FROM students
ORDER BY score DESC
limit 3 offset 6;
SELECT id, name, gender, score
FROM students
ORDER BY score DESC
limit 6, 3;
-- 查询第4页的时候，OFFSET应该设定为9
SELECT id, name, gender, score
FROM students
ORDER BY score DESC
limit 3 offset 9;
-- 由于第4页只有1条记录，因此最终结果集按实际数量1显示。LIMIT 3表示的意思是“最多3条记录”。
-- 分页查询的关键在于，首先要确定每页需要显示的结果数量pageSize（这里是3），然后根据当前页的索引pageIndex（从1开始），确定LIMIT和OFFSET应该设定的值
-- LIMIT总是设定为pageSize；
-- OFFSET计算公式为pageSize * (pageIndex - 1)。
-- 这样就能正确查询出第N页的记录集。
-- OFFSET设定为20
SELECT id, name, gender, score
FROM students
ORDER BY score DESC
LIMIT 3 OFFSET 20;
-- OFFSET超过了查询的最大数量并不会报错，而是得到一个空的结果集。
-- 注意
-- OFFSET是可选的，如果只写LIMIT 15，那么相当于LIMIT 15 OFFSET 0
-- 在MySQL中，`LIMIT 15 OFFSET 30`还可以简写成LIMIT 30, 15
-- 使用LIMIT <M> OFFSET <N>分页时，随着N越来越大，查询效率也会越来越低。
-- 小结
-- 使用LIMIT <M> OFFSET <N>可以对结果集进行分页，每次查询返回结果集的一部分；
-- 分页查询需要先确定每页的数量和当前页数，然后确定LIMIT和OFFSET的值。

-- 查询数据-聚合查询
-- 对于统计总数、平均数这类计算，SQL提供了专门的聚合函数，使用聚合函数进行查询，就是聚合查询，它可以快速获得结果。
select count(*)
from students;
-- -- 使用聚合查询并设置结果集的列名为num
select count(*) as nums_total
from students;
-- 使用聚合查询并设置WHERE条件
-- 统计学生表中男生人数
select count(*) as boys
from students
where gender = 'M';
-- 统计学生表中女生人数
select count(*) as girls
from students
where gender = 'F';
-- 统计学生表中分数>80的人数
select count(*) as score_more_than_80
from students
where score > 80;
-- 除了COUNT()函数外，SQL还提供了如下聚合函数
-- 函数	        说明
-- SUM	    计算某一列的合计值，该列必须为数值类型
-- AVG	    计算某一列的平均值，该列必须为数值类型
-- MAX	    计算某一列的最大值
-- MIN	    计算某一列的最小值
-- MAX()和MIN()函数并不限于数值类型。如果是字符类型，MAX()和MIN()会返回排序最后和排序最前的字符。
-- 使用聚合查询计算男生平均成绩
select avg(score) as average
from students
where gender = 'M';
-- 特别注意：如果聚合查询的WHERE条件没有匹配到任何行，COUNT()会返回0，而SUM()、AVG()、MAX()和MIN()会返回NULL
-- 返回null
select avg(score) as average
from students
where gender = 'M1';
-- 返回0
select count(*) as score_more_than_80
from students
where score > 150;
-- 每页3条记录，通过聚合查询获得总页数:CEILING(num)对num想上取整
SELECT CEILING(COUNT(*) / 3) as total_page
FROM students;
-- 分组聚合
-- 按class_id分组
select class_id, count(*) as nums
from students
group by class_id;
-- 执行上边查询语句，COUNT()的结果不再是一个，而是3个，这是因为，GROUP BY子句指定了按class_id分组。
-- 因此，执行该SELECT语句时，会把class_id相同的列先分组，再分别计算，因此，得到了3行结果。
-- 按class_id, gender分组:统计各班的男生和女生人数
select class_id, gender, count(*) as num
from students
group by class_id, gender;
-- 查询查出每个班级的平均分
select class_id, avg(score)
from students
group by class_id;
-- 查出每个班级男生和女生的平均分
select class_id, gender, avg(score)
from students
group by class_id, gender;
-- 小结
-- 使用SQL提供的聚合查询，我们可以方便地计算总数、合计值、平均值、最大值和最小值；
-- 聚合查询也可以添加WHERE条件。

-- 查询数据-多表查询
-- FROM students, classes
select *
from students,
     classes;
-- 上边查询的是两个表的数据，查询的结果也是一个二维表，它是students表和classes表的“乘积”，即students表的每一行与classes表的每一行都两两拼在一起返回。
-- 结果集的列数是students表和classes表的列数之和，行数是students表和classes表的行数之积。
-- 这种多表查询又称笛卡尔查询，使用笛卡尔查询时要非常小心，由于结果集是目标表的行数乘积，对两个各自有100行记录的表进行笛卡尔查询将返回1万条记录，
-- 对两个各自有1万行记录的表进行笛卡尔查询将返回1亿条记录。
-- set alias为列名设置别名
SELECT students.id as sid,
       students.name  sname,
       students.gender,
       students.score,
       classes.id  as cid,
       classes.name   cname
FROM students,
     classes;
-- 注意，多表查询时，要使用表名.列名这样的方式来引用列和设置别名，这样就避免了结果集的列名重复问题。
-- 但是，用表名.列名这种方式列举两个表的所有列实在是很麻烦，所以SQL还允许给表设置一个别名.
-- 给表和字段设置别名
SELECT s.id as sid,
       s.name  sname,
       s.gender,
       s.score,
       c.id as cid,
       c.name  cname
FROM students as s,
     classes as c;
-- 多表查询也是可以添加WHERE条件
select s.id as sid, s.name as sname, s.gender, s.score, c.id as cid, c.name as cname
from students as s,
     classes as c
where s.gender = 'M'
  and c.id = 1;
-- 小结
-- 使用多表查询可以获取M x N行记录；
-- 多表查询的结果集可能非常巨大，要小心使用。
-- 一般使用主键或外键进行多表关联查询，笛卡尔乘积没太多意义，而且很容易查询量爆炸，不建议使用

-- 查询数据-连接查询
-- 连接查询是另一种类型的多表查询。连接查询对多个表进行JOIN运算。
-- 简单地说，就是先确定一个主表作为结果集，然后，把其他表的行有选择性地“连接”在主表结果集上。
-- 内连接——INNER JOIN
-- 查询学生表中所有学生所在的班级名称
select s.name as student_name, c.name as class_name
from students as s
         inner join classes as c on s.class_id = c.id;
-- INNER JOIN查询的写法
-- 先确定主表，仍然使用FROM <表1>的语法；
-- 再确定需要连接的表，使用INNER JOIN <表2>的语法；
-- 然后确定连接条件，使用ON <条件...>，这里的条件是s.class_id = c.id，表示students表的class_id列与classes表的id列相同的行需要连接；
-- 可选：加上WHERE子句、ORDER BY等子句。
-- 查询学生表中所有男生所在的班级名称
select s.name as student_name, c.name as class_name
from students as s
         inner join classes as c on s.class_id = c.id
where s.gender = 'M';
-- 查询学生表中一班所有男生的平均成绩
select avg(s.score) as avg_score
from students as s
         inner join classes as c on s.class_id = c.id
where s.class_id = 1
  and s.gender = 'M';
-- 查询学生表中一班的平均成绩
select avg(s.score) as avg_score
from students as s
         inner join classes as c on s.class_id = c.id
where s.class_id = 1;
-- OUTER JOIN外连接
-- RIGHT OUTER JOIN
select s.name as student_name, c.name as class_name
from students as s
         right outer join classes as c on s.class_id = c.id;
-- 执行上述RIGHT OUTER JOIN可以看到，和INNER JOIN相比，RIGHT OUTER JOIN多了一行，多出来的一行是“四班”，但是，学生相关的列如name、gender、score都为NULL。
-- 这也容易理解，因为根据ON条件s.class_id = c.id，classes表的id=4的行正是“四班”，但是，students表中并不存在class_id=4的行。
-- INNER JOIN、RIGHT OUTER JOIN、LEFT OUTER JOIN和FULL OUTER JOIN的区别：
-- INNER JOIN只返回同时存在于两张表的行数据，由于students表的class_id包含1，2，3，classes表的id包含1，2，3，4，所以，INNER JOIN根据条件s.class_id = c.id返回的结果集仅包含1，2，3。
-- RIGHT OUTER JOIN返回右表都存在的行。如果某一行仅在右表存在，那么结果集就会以NULL填充剩下的字段。
-- LEFT OUTER JOIN则返回左表都存在的行。
-- FULL OUTER JOIN会把两张表的所有记录全部选择出来，并且，自动把对方不存在的列填充为NULL。
-- 小结
-- JOIN查询需要先确定主表，然后把另一个表的数据“附加”到结果集上；
-- INNER JOIN是最常用的一种JOIN查询，它的语法是SELECT ... FROM <表1> INNER JOIN <表2> ON <条件...>；
-- JOIN查询仍然可以使用WHERE条件和ORDER BY排序。

-- 修改数据
-- 关系数据库的基本操作就是增删改查，即CRUD：Create、Retrieve、Update、Delete。
-- 对于增、删、改，对应的SQL语句分别是：
-- INSERT：插入新记录；
-- UPDATE：更新已有记录；
-- DELETE：删除已有记录。
-- 修改数据-insert插入数据
-- INSERT语句的基本语法：INSERT INTO <表名> (字段1, 字段2, ...) VALUES (值1, 值2, ...);
-- 向students表插入一条新记录
insert into students (class_id, name, gender, score)
values (2, '小花花', 'F', 93);
-- 查看是否插入数据成功
SELECT *
FROM students;
-- 这里我们并没有列出id字段，也没有列出id字段对应的值，这是因为id字段是一个自增主键，它的值可以由数据库自己推算出来。此外，如果一个字段有默认值，那么在INSERT语句中也可以不出现。
-- 要注意，字段顺序不必和数据库表的字段顺序一致，但值的顺序必须和字段顺序一致。也就是说，可以写INSERT INTO students (score, gender, name, class_id) ...，但是对应的VALUES就得变成(80, 'M', '大牛', 2)。
-- 一次性插入多条数据
insert into students (class_id, name, gender, score)
values (1, '熊大', 'M', 86),
       (3, '熊二', 'M', 79),
       (2, '翠花', 'F', 83);
-- 查看是否插入数据成功
SELECT *
FROM students;
-- 小结
-- 使用INSERT，我们就可以一次向一个表中插入一条或多条记录。

-- 修改数据-update更新数据
-- UPDATE语句的基本语法：UPDATE <表名> SET 字段1=值1, 字段2=值2, ... WHERE ...;
-- 更新students表id=1的记录的name和score这两个字段，先写出UPDATE students SET name='大牛', score=66，然后在WHERE子句中写出需要更新的行的筛选条件id=1
update students
set name='啦啦啦',
    score=65
where id = 1;
-- 查看更新数据是否成功
SELECT *
FROM students
WHERE id = 1;
-- 更新id=5,6,7的记录
update students
set name='小牛',
    score=65
where id >= 5
  and id <= 7;
-- 查询并观察更新结果:
SELECT *
FROM students;
-- 在UPDATE语句中，更新字段时可以使用表达式。例如，把所有80分以下的同学的成绩加10分
update students
set score=score + 10
where score < 70;
-- 如果WHERE条件没有匹配到任何记录，UPDATE语句不会报错，也不会有任何记录被更新。
-- 更新id=999的记录
UPDATE students
SET score=100
WHERE id = 999;
-- 查询并观察结果:
SELECT *
FROM students;
-- 更新整表中某个字段的值
UPDATE students
SET score=60;
-- 小结
-- 使用UPDATE，我们就可以一次更新表中的一条或多条记录。

-- 修改数据-delete删除数据
-- DELETE语句的基本语法：DELETE FROM <表名> WHERE ...;
-- 删除id=1的记录
delete
from students
where id = 1;
-- 查询并观察结果:
SELECT *
FROM students;
-- 删除id=5,6,7的记录
DELETE
FROM students
WHERE id >= 5
  AND id <= 7;
-- 查询并观察结果:
SELECT *
FROM students;
-- 如果WHERE条件没有匹配到任何记录，DELETE语句不会报错，也不会有任何记录被删除。
-- 删除id=999的记录
DELETE
FROM students
WHERE id = 999;
-- 查询并观察结果:
SELECT *
FROM students;
-- 不带WHERE条件的DELETE语句会删除整个表的数据
DELETE
FROM students;
-- 小结
-- 使用DELETE，我们就可以一次删除表中的一条或多条记录。

-- MySQL
-- MySQL Client的可执行程序是mysql，MySQL Server的可执行程序是mysqld
-- 小结
-- 命令行程序mysql实际上是MySQL客户端，真正的MySQL服务器程序是mysqld，在后台运行。

-- MySQL-管理MySQL
-- 列出所有数据库
SHOW DATABASES;
-- 其中，information_schema、mysql、performance_schema和sys是系统库，不要去改动它们。其他的是用户创建的数据库。
-- 创建数据库
create database mytest CHARACTER SET utf8mb4;
-- 查看创建库的SQL语句
show create database mytest;
-- 删除数据库:注意,删除一个数据库将导致该数据库的所有表全部被删除。
drop database mytest;
-- 对一个数据库进行操作时，要首先将其切换为当前数据库
use test;
-- 列出当前数据库的所有表
show tables;
-- 查看一个表的结构
desc students;
-- 查看创建表的SQL语句
show create table students;
-- 删除表使用DROP TABLE语句
drop table students;
-- 修改表
-- 给students表新增一列birth
alter table students
    add column birth varchar(20) not null;
-- 修改birth列，把列名改为birthday，类型改为VARCHAR(30)
alter table students
    change column birth birthday varchar(30) not null;
-- 删除列
alter table students
    drop column birthday;

-- MySQL-实用sql语句
-- 插入或替换
-- 如果我们希望插入一条新记录（INSERT），但如果记录已经存在，就先删除原记录，再插入新记录。此时，可以使用REPLACE语句，这样就不必先查询，再决定是否先删除再插入：
REPLACE INTO students (id, class_id, name, gender, score)
VALUES (1, 1, '小明', 'F', 99);
-- 若id=1的记录不存在，REPLACE语句将插入新记录，否则，当前id=1的记录将被删除，然后再插入新记录。

-- 插入或更新
-- 如果我们希望插入一条新记录（INSERT），但如果记录已经存在，就更新该记录，此时，可以使用INSERT INTO ... ON DUPLICATE KEY UPDATE ...语句：
INSERT INTO students (id, class_id, name, gender, score)
VALUES (1, 1, '小明', 'F', 99)
ON DUPLICATE KEY UPDATE name='小明',
                        gender='F',
                        score=99;
-- 若id=1的记录不存在，INSERT语句将插入新记录，否则，当前id=1的记录将被更新，更新的字段由UPDATE指定。

-- 插入或忽略
-- 如果我们希望插入一条新记录（INSERT），但如果记录已经存在，就啥事也不干直接忽略，此时，可以使用INSERT IGNORE INTO ...语句：
-- INSERT IGNORE INTO students (id, class_id, name, gender, score) VALUES (1, 1, '小明', 'F', 99);
-- 若id=1的记录不存在，INSERT语句将插入新记录，否则，不执行任何操作。

-- 快照
-- 如果想要对一个表进行快照，即复制一份当前表的数据到一个新表，可以结合CREATE TABLE和SELECT：
-- 对class_id=1的记录进行快照，并存储为新表students_of_class1:
CREATE TABLE students_of_class1
SELECT *
FROM students
WHERE class_id = 1;
-- 查询操作是否成功
select *
from students_of_class1;
-- 新创建的表结构和SELECT使用的表结构完全一致。

-- 写入查询结果集
-- 如果查询结果集需要写入到表中，可以结合INSERT和SELECT，将SELECT语句的结果集直接插入到指定表中。
-- 例如，创建一个统计成绩的表score_statistics，记录各班的平均成绩
CREATE TABLE score_statistics
(
    id       BIGINT NOT NULL AUTO_INCREMENT,
    class_id BIGINT NOT NULL,
    average  DOUBLE NOT NULL,
    PRIMARY KEY (id)
) engine = InnoDB
  default charset = utf8mb4;
-- 然后，我们就可以用一条语句写入各班的平均成绩
INSERT INTO score_statistics (class_id, average)
SELECT class_id, AVG(score)
FROM students
GROUP BY class_id;
-- 确保INSERT语句的列和SELECT语句的列能一一对应，就可以在statistics表中直接保存查询的结果
SELECT *
FROM score_statistics;

-- 强制使用指定索引
-- 在查询的时候，数据库系统会自动分析查询语句，并选择一个最合适的索引。但是很多时候，数据库系统的查询优化器并不一定总是能使用最优索引。
-- 如果我们知道如何选择索引，可以使用FORCE INDEX强制查询使用指定的索引。例如：
SELECT *
FROM students FORCE INDEX (idx_class_id)
WHERE class_id = 1
ORDER BY id DESC;
-- 指定索引的前提是索引idx_class_id必须存在。

-- 事务
-- 数据准备
-- 建表
create table t_students
(
    id   bigint      not null auto_increment,
    name varchar(20) not null,
    primary key (id)
) engine = InnoDB
  default charset = utf8mb4;
-- 插入一条数据
insert into t_students (name)
values ('小哈哈');
-- 分别开启两个MySQL客户端连接，按顺序依次执行事务A和事务B
-- 时刻	                    事务A	                                                事务B
--  1	    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;	        SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
--  2	    BEGIN;	                                                    BEGIN;
--  3	    UPDATE students SET name = 'Bob' WHERE id = 1;
--  4		                                                        SELECT * FROM students WHERE id = 1;
--  5	    ROLLBACK;
--  6		                                                        SELECT * FROM students WHERE id = 1;
--  7		                                                        COMMIT;
-- 按照上述列表编号依次执行事务A和事务B
-- 事务A
-- Read Uncommitted
-- Read Uncommitted是隔离级别最低的一种事务级别。
-- 在这种隔离级别下，一个事务会读到另一个事务更新后但未提交的数据，如果另一个事务回滚，那么当前事务读到的数据就是脏数据，这就是脏读（Dirty Read）。
-- 设置事务隔离级别
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
-- 事务开始
BEGIN;
-- 执行sql
UPDATE t_students
SET name = 'Bob'
WHERE id = 1;
-- 回滚
ROLLBACK;
-- 事务B
-- 设置事务隔离级别
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
-- 事务开始
BEGIN;
-- 执行sql
SELECT *
FROM students
WHERE id = 1;
-- 执行sql
SELECT *
FROM students
WHERE id = 1;
-- 提交事务
COMMIT;
-- 当事务A执行完第3步时，它更新了id=1的记录，但并未提交，而事务B在第4步读取到的数据就是未提交的数据。
-- 随后，事务A在第5步进行了回滚，事务B再次读取id=1的记录，发现和上一次读取到的数据不一致，这就是脏读。
-- 可见，在Read Uncommitted隔离级别下，一个事务可能读取到另一个事务更新但未提交的数据，这个数据有可能是脏数据。

-- Read Committed
-- 在Read Committed隔离级别下，一个事务可能会遇到不可重复读（Non Repeatable Read）的问题。
-- 不可重复读是指，在一个事务内，多次读同一数据，在这个事务还没有结束时，如果另一个事务恰好修改了这个数据，那么，在第一个事务中，两次读取的数据就可能不一致。
-- 分别开启两个MySQL客户端连接，按顺序依次执行事务A和事务B
-- 时刻	                    事务A	                                                事务B
--  1	        SET TRANSACTION ISOLATION LEVEL READ COMMITTED;	        SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
--  2	        BEGIN;	                                                BEGIN;
--  3		                                                            SELECT * FROM students WHERE id = 1;
--  4	        UPDATE students SET name = 'Bob' WHERE id = 1;
--  5	        COMMIT;
--  6		                                                            SELECT * FROM students WHERE id = 1;
--  7		                                                            COMMIT;
-- 复现步骤与上一个Read Uncommitted操作步骤一致
-- 当事务B第一次执行第3步的查询时，得到的结果是Alice，随后，由于事务A在第4步更新了这条记录并提交。
-- 所以，事务B在第6步再次执行同样的查询时，得到的结果就变成了Bob。
-- 因此，在Read Committed隔离级别下，事务不可重复读同一条记录，因为很可能读到的结果不一致。

-- Repeatable Read
-- 在Repeatable Read隔离级别下，一个事务可能会遇到幻读（Phantom Read）的问题。
-- 幻读是指，在一个事务中，第一次查询某条记录，发现没有，但是，当试图更新这条不存在的记录时，竟然能成功，并且，再次读取同一条记录，它就神奇地出现了。
-- 分别开启两个MySQL客户端连接，按顺序依次执行事务A和事务B
-- 时刻	                    事务A	                                            事务B
--  1	        SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;	SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
--  2	        BEGIN;	                                            BEGIN;
--  3		                                                        SELECT * FROM students WHERE id = 99;
--  4	        INSERT INTO students (id, name) VALUES (99, 'Bob');
--  5	        COMMIT;
--  6		                                                        SELECT * FROM students WHERE id = 99;
--  7		                                                        UPDATE students SET name = 'Alice' WHERE id = 99;
--  8		                                                        SELECT * FROM students WHERE id = 99;
--  9		                                                        COMMIT;
-- 事务B在第3步第一次读取id=99的记录时，读到的记录为空，说明不存在id=99的记录。
-- 随后，事务A在第4步插入了一条id=99的记录并提交。事务B在第6步再次读取id=99的记录时，读到的记录仍然为空。
-- 但是，事务B在第7步试图更新这条不存在的记录时，竟然成功了，并且，事务B在第8步再次读取id=99的记录时，记录出现了。
-- 可见，幻读就是没有读到的记录，以为不存在，但其实是可以更新成功的，并且，更新成功后，再次读取，就出现了。

-- Serializable
-- Serializable是最严格的隔离级别。在Serializable隔离级别下，所有事务按照次序依次执行，因此，脏读、不可重复读、幻读都不会出现。
-- 虽然Serializable隔离级别下的事务具有最高的安全性，但是，由于事务是串行执行，所以效率会大大下降，应用程序的性能会急剧降低。如果没有特别重要的情景，一般都不会使用Serializable隔离级别。
-- 默认隔离级别
-- 如果没有指定隔离级别，数据库就会使用默认的隔离级别。在MySQL中，如果使用InnoDB，默认的隔离级别是Repeatable Read。