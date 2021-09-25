---
title: 【MySQL】MySQL学习基础(1)
urlname: olb7zi
date: 2019-01-14 21:18:27
tags: []
categories: []
---

# 数据库和 SQL

SQL(Structured
Query Language)：结构化查询语言。包括 DDL（Data Definition Language 数据定义语言）、DML（Data Management Language 数据管理语言）、DCL（Data Control Language 数据库控制语言）。其中 DML 包括：DQL（Data Query Language 数据查询语言）和 DML（Data Management Language 数据管理语言），一般来说，数据查询和管理都称为数据管理语言。



# [安装]()

# 基础

## DML

### 数据库操作

```sql
# 数据库创建
CREATE database db_name;   # 创建数据库
CREATE database db_name if not exits;

# 数据库查询
SHOW databases;   # 查看当前存在的数据库
SHOW CREATE DATABASE db_name;  # 查看数据库创建的语言，显示结果为

# 选择数据库
USE database;  # 操作表时会使用默认的数据库，所以需要先使用USE表示使用的是哪一个数据库

# 查看数据库中表
SHOW TABLES [like 'pattern_%']; # 可以使用通配符匹配

# 数据库删除
DROP database db_name;   #还有其他的两种，记得区分结果

# 数据库修改
ALTER database db_name;

# 数据库权限修改
GRANT ALL ON db_name.* TO 'your_mysql_name'@'your_client_host'; #
```

### 表操作

```sql
# 表创建
CREATE TABLE tbl_name (列结构)[表选项]
CREATE TABLE pet (name VARCHAR(20), owner VARCHAR(20),
                   species VARCHAR(20), sex CHAR(1), birth DATE, death DATE);





# 从外部导入数据到表
LOAD DATA LOCAL INFILE '/path/pet.txt' INTO TABLE pet
       LINES TERMINATED BY '\r\n';  # 从本地导入，分隔符为"\r\n"

# 插入数据到表
INSERT INTO pet
       VALUES ('Puffball','Diane','hamster','f','1999-03-30',NULL); # 如果设置了NOT NULL，则需要
       在插入数据的时候该项有值

 # 修改列定义
 ALTER TABLE tbl_name[ADD|DROP|CHANGE|MODIFY] #添加|删除|重命名|修改

 # 修改表选项
 ALTER TABLE tbl_name 新的表选型
 ALTER TABLE pet CHARACTER SET UTF8;
```

### 数据操作

```sql
# 创建数据
INSERT INTO tbl_name (field_list) VALUES (values); #
# 获取数据
SELECT field_list FROM tbl_name conditions;
SELECT field_list FROM tbl_name WHERE conditions LIKE 'a%'; # %为通配符
SELECT field_list FROM tbl_name WHERE REGEXP_LIKE(field_name,regex); # 使用正则表达式匹配
# 删除数据
DELETE FROM tbl_name conditions;
# 修改数据
UPDATE tbl_name SET field=new_value, conditions;
```

## Mysql 数据类型

### 整型:默认有符号，无符号要指定 unsigned

TINYINT:1 字节 无符号：-128---127  有符号： 0---255
SMALLINT:2 字节 无符号：-32768---32767 有符号：0-65536
MEDIUMINT：3 字节
INT：4 字节
BIGINT:8 字节
可以听过类似 INT(2)表示显示的宽度，显示宽度不影响数值的范围，只是为了表示

### 小数

**浮点数： **  可以通过**TYPE(M,D)**控制数值位数，M 为所有的数值位数，D 为小数位数
float：单精度浮点数，默认精度位数为 6 左右
double：双精度浮点数，默认精度 16 左右
** 定点数： DECIMAL(M,D) **同样的 M 为所有的数值位数，D 为小数位数，M 默认为 10，D 默认为 0

### 日期和时间

| DATATIME  |  8  | YYYY-MM-DD HH:MM:SS  |                  |
| :-------: | :-: | :------------------: | :--------------: |
| TIMESTAMP |  4  | YYYY-MM-DD HH:MM:SS  |  从 1970 年开始  |
|   DATE    |  3  |      YYYY-MM-DD      |                  |
|   TIME    |  3  |       HH:MM:SS       |                  |
|   YEAR    |  1  |         YYYY         | 范围为 1901-2155 |

### 字符串

**CHAR(M) :**表示固定长度。M 表示允许的字符串长度,限制了字符串的长度
**VARCHAR(M): **可变长度 。M 表示允许的最大长度，在内存中表示，需要多一个字节保存字符串的总长度，因此如果有时候不是很需要改变长度的话，尽量用固定长度的 CHAR

## 列属性

### 主键

可以唯一标识某条记录的字段或字段的集合。通常的做法是，设计每个表存在一个可以唯一标识的主键字段，最好利用与实体信息不相关的属性，作为唯一标识，与业务逻辑不发生关系，只用来记录标识，例如 ID。
设置方式：在字段上设置或者定义完字段后再定义

```sql
# 在字段上设置
CREATE TABLE pet (
  id INT PRIMARY KEY,NAME VARCHAR (5));
# 定义完字段后再设置
CREATE TABLE pet1 (
	id INT,NAME VARCHAR (5),PRIMARY KEY (id));
```

### 自动增长

为每条记录提供唯一的标识，每次插入记录时，某个字段的值都自动加 1，使用 auto_increment 标识。要求需要整型和索引。在插入数据的时候，可以选择插入 null 也可以不插入。  
自动增长的初始值默认是 1，也可以通过 auto_increment n 重新设置从 n 开始增长。
也可以手动插入自动增长的值，但是如果是主键的话，不能重复。

# 注意事项

- 数据库语言关键字一般用大写，虽然大小写都可以，但是为了区分。
- 数据库名的大小写取决于系统，所以操作的时候尽量有自己的规范，进行大小写区分。
- NULL 是区别于 0 或者' '的
