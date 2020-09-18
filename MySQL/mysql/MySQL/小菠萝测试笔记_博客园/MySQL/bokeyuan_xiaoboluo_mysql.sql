-- 创建数据库
-- 语法格式
-- CREATE DATABASE [IF NOT EXISTS] <数据库名>
-- [[DEFAULT] CHARACTER SET <字符集名>]
-- [[DEFAULT] COLLATE <校对规则名>];
# 简单创建一个数据库
create database yytest;
# 添加条件判断，创建一个数据库
create database if not exists yytests;
# 指定数据库数据集，创建一个数据库
create database if not exists yytestss character set utf8mb4;
create database if not exists yytest character set utf8mb4;
# 指定字符串校验规则，创建一个数据库
create database if not exists yytestsss character set utf8mb4 collate utf8mb4_general_ci;
# 查看数据库创建的语句是什么
show create database yytestsss;

-- 查询数据库
-- 语法格式
-- SHOW DATABASES [LIKE '数据库名'];
# 查询所有数据库
show DATABASES;
# 模糊匹配
show databases like '%yytest%';
# 精确匹配
show databases like 'yytests';

-- 修改数据库
-- 语法格式
-- ALTER DATABASE [数据库名] {
-- [ DEFAULT ] CHARACTER SET <字符集名> |
-- [ DEFAULT ] COLLATE <校对规则名>}
# 修改默认数据库的字符集
use yytest;
alter database character set utf8;
# 修改指定数据库字符集和校验规则
alter database yytest character set utf8 collate utf8_general_ci;

-- 删除数据库
-- 语法格式
-- DROP DATABASE [ IF EXISTS ] <数据库名>
# 简单删除数据库语句
drop database yytest;
# 如果存在才删除
drop database if exists yytestsss;

-- 选择数据库
use yytest;

-- 创建数据表
-- 语法格式
-- CREATE TABLE <表名> ( [表定义选项] )[表选项][分区选项];
# 创建数据表
CREATE TABLE yytest
(
    id         BIGINT(10)  NOT NULL UNIQUE PRIMARY KEY,
    uname      VARCHAR(20) NOT NULL,
    sex        VARCHAR(4),
    birth      YEAR,
    department VARCHAR(20),
    address    VARCHAR(50),
    yypolo     VARCHAR(20)
);
# 指定数据库，创建数据表
CREATE TABLE yytest.polotest
(
    id       INT(10) NOT NULL UNIQUE PRIMARY KEY AUTO_INCREMENT,
    stu_id   INT(10) NOT NULL,
    c_name   VARCHAR(20),
    istester VARCHAR(50),
    grade    INT(10)
);

-- 查看数据表
desc yytest.yytest;

-- 查看数据表的创建语句
show create table yytest;

-- 复制数据表
# 仅复制表结构
create table yytest2 like yytest;
# 复制表结构和数据
create table yytest3 as
select *
from yytest;
# 仅复制表的指定字段结构
create table yytest4 as
select id, uname, sex
from yytest
where 1 <> 1;
# 复制表的指定字段结构和数据
create table yytest5 as
select id, uname, sex
from yytest;
# 查看表创建语句：没有包含主键和自增
show create table yytest5;
# 复制表不包含主键、索引、自增等
show create table yytest3;


-- 修改数据表
-- 语法格式
-- ALTER TABLE <表名> [修改操作];

-- 修改表名
-- ALTER TABLE <旧表名> RENAME [TO] <新表名>；
alter table yytest2 rename to yytest22;
alter table yytest22 rename yytest222;

-- 修改字段排列顺序
-- ALTER TABLE <表名> MODIFY <字段名> <数据类型> [FIRST|AFTER 已存在的字段名];
# 放在首位
alter table yytest222
    modify sex int(2) first;
# 放在birth字段后面
alter table yytest222
    modify sex int(2) after birth;

-- 修改字段数据类型
-- ALTER TABLE <表名> MODIFY <字段名> <数据类型>;
# 修改字段数据类型
alter table yytest222
    modify sex tinyint(1);
desc yytest222;

-- 修改字段名字
-- ALTER TABLE <表名> CHANGE <旧字段> <新字段> <数据类型>;
# 修改字段名
alter table yytest222
    change sex sexs int(2);
# 修改字段数据类型和字段名
alter table yytest222
    change sexs sex varchar(4);

-- 添加字段
-- ALTER TABLE <表名> ADD <字段名> <数据类型>  [约束条件] [FIRST|AFTER 已存在的字段名];
# 添加字段
alter table yytest222
    add phone varchar(11);
# 添加字段到首位
alter table yytest22
    add phone varchar(11) not null default 2 first;
# 添加字段到某个字段后面
alter table yytest22
    add phone varchar(11) after sex;

-- 删除字段
-- ALTER TABLE <表名> DROP <字段名>；
alter table yytest222
    drop sex;

-- 删除数据表
-- DROP TABLE [IF EXISTS] 表名1 [ ,表名2, 表名3 ...]
# 删除表如果存在
drop table if exists yytest,yytest222,yytest3;

-- select 语法格式
# SELECT
# {* | <字段列名>}
# [
# FROM <表 1>, <表 2>…
# [WHERE <表达式>
# [GROUP BY <group by definition>
# [HAVING <expression> [{<operator> <expression>}…]]
# [ORDER BY <order by definition>]
# [LIMIT[<offset>,] <row count>]
# ]

DROP TABLE IF EXISTS `emp`;
CREATE TABLE `emp`
(
    `id`        int(11)                                                 NOT NULL COMMENT '员工编号',
    `name`      varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '员工姓名',
    `dept_id`   int(11)                                                 NULL DEFAULT NULL COMMENT '部门编号',
    `leader`    int(11)                                                 NULL DEFAULT NULL COMMENT '直属领导id',
    `is_enable` int(11)                                                 NULL DEFAULT NULL COMMENT '是否在职 1在职 0离职',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci
  ROW_FORMAT = Compact;


INSERT INTO `emp`
VALUES (1, '张三丰', 1, 0, 1);
INSERT INTO `emp`
VALUES (2, '张无忌', 1, 1, 1);
INSERT INTO `emp`
VALUES (3, '小龙女', 1, 1, 1);
INSERT INTO `emp`
VALUES (4, '小白菜', 1, 3, 1);
INSERT INTO `emp`
VALUES (5, '韦小宝', 2, 0, 1);
INSERT INTO `emp`
VALUES (6, '令狐冲', 2, 0, 1);
INSERT INTO `emp`
VALUES (7, '东方不败', 0, 8, 1);
INSERT INTO `emp`
VALUES (8, '任我行', 3, 0, 1);
INSERT INTO `emp`
VALUES (9, '李寻欢', 0, 8, 1);


DROP TABLE IF EXISTS `dept`;
CREATE TABLE `dept`
(
    `id`   int(11)                                                 NOT NULL COMMENT '部门id',
    `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门名称',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci
  ROW_FORMAT = Compact;

INSERT INTO `dept`
VALUES (1, '销售部');
INSERT INTO `dept`
VALUES (2, '信息技术部');
INSERT INTO `dept`
VALUES (3, '财务部');
INSERT INTO `dept`
VALUES (4, '有关部门');

-- 查询每个员工的部门详细信息
select e.name as 员工姓名, d.name as 员工所属部门
from emp as e
         inner join dept as d on e.dept_id = d.id;
-- 查询有leader的员工以及leader信息
select e1.name as 员工姓名, e2.name as 员工leader
from emp as e1
         inner join emp as e2 on e1.leader = e2.id;

-- 查询部门是销售部的员工信息
select *
from emp
where emp.dept_id = (select dept.id from dept where dept.name = "销售部");
-- 查询部门不是销售部的员工信息
select *
from emp
where emp.dept_id <> (select dept.id from dept where dept.name = "销售部");

-- 从 dept 表查询部门名字为销售部or财务部的部门 id,然后从 emp 表查询 depte_id 在上面 id 结果集的记录
select *
from emp
where emp.dept_id in (select id from dept where dept.name = "销售部" or dept.name = "财务部");

-- 从 dept 表中查询 id = 1 的记录，若有，exists 表达式则返回True,外层查询语句接收到 True 之后，对 emp 表进行查询，返回所有记录
select *
from emp
where exists(select * from dept where id = 1);
-- 上边的sql等价于`select * from emp where true;`

select *
from emp
where exists(select * from dept where id = 1)
  and dept_id = 2