+++
title = "MySQL-SQL Mode详解"
date = "2022-05-12T18:58:50+08:00"
update = "2022-05-12T18:58:50+08:00"
categories = ["MySQL"]
tags = ["MySQL"]
description = ""
+++
> SQL Modes 在使用的过程中一般不会有问题，因为写入一般都是在主库上。但是如果由于新部署的从库，默认设置与旧主库不一样，在发生主库切换后，业务可能就会有问题了。

> 以下仅分析 MySQL 5.7 版本。

# 什么是SQL Modes
MySQL server 可以工作在不同的 SQL 模式下，不同的模式对客户端可能有不同的表现。具体取决于系统变量 `sql_mode`.
```SQL
mysql> SHOW VARIABLES LIKE "sql_mode";
+---------------+-------+
| Variable_name | Value |
+---------------+-------+
| sql_mode      |       |
+---------------+-------+
```


# 设置SQL Modes


MySQL 5.7 有以下SQL modes：
1.   `ONLY_FULL_GROUP_BY`：对于 group by 聚合操作，如果在 select 中出现的列没有在 group by 中出现，那么这种 SQL 是不合法的。
```SQL
mysql> CREATE TABLE mytable (
	 id INT UNSIGNED NOT NULL PRIMARY KEY,
	 a VARCHAR(10),
	 b VARCHAR(10),
	 c INT);

mysql> set sql_mode="ONLY_FULL_GROUP_BY";
Query OK, 0 rows affected (0.03 sec)

mysql> select a,b,max(c) from mytable group by a;

ERROR 1055 (42000): Expression #2 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'ygc_test.mytable.b' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by

mysql> select a,b,max(c) from mytable group by a,b;
Empty set (0.02 sec)
```

- `STRICT_TRANS_TABLES`: Strict mode控制着 MySQL 在 update/insert 时候对于 invalid 或 missing 数据的处理。插入或更新的值 invalid 有多种原因，比如数据类型错误、值越界等；值缺失是因为向 NOT NULL 列插入数据的时候没有显示的指定 DEFAULT 语句。Strict mode 也会影响到 create table 语句。而对于 strict mode 下的 select 语句，只会生成一个 warning，不会报错。
- `NO_ZERO_IN_DATE`：在严格模式下,不允许日期和月份为零。（即将被废弃）
- `NO_ZERO_DATE`：不允许插入零日期。
- `ERROR_FOR_DIVISION_BY_ZERO`：在INSERT或UPDATE过程中,如果数据被零除,则产生错误而非警告。如 果未给出该模式,那么数据被零除时MySQL返回NULL。
- `NO_AUTO_CREATE_USER`：禁止GRANT创建密码为空的用户。
- `NO_ENGINE_SUBSTITUTION`：如果需要的存储引擎被禁用或未编译,那么抛出错误。不设置此值时,用默认的存储引擎替代,并抛出一个异常。
- `ANSI_QUOTES`：启用 ANSI_QUOTES 后，不能用双引号来引用字符串，因为它被解释为识别符。
- `PIPES_AS_CONCAT`：将 `||` 视为字符串的连接操作符而非 `或` 运算符，和Oracle数据库一样，也和字符串的拼接函数 CONCAT() 相类似。


值得说明的是，`sql_mode` 是一个系统变量，因此改完可以直接对新连接生效。在启动文件中也有默认的配置：
```bash
# my.cnf
sql_mode = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION'
```
# 几个小问题记录
- 设置了SQL Modes 后，会在新连接才生效。尤其是当 MySQL 前端有代理时，可能需要重启代理。
- 尤其现在使用 innodb 表的时候，还需要关注 `innodb_strict_mode` 系统变量，该变量会对 innodb 表进行额外的错误检查。


# 参考
- https://dev.mysql.com/doc/refman/5.7/en/sql-mode.html
- https://www.modb.pro/db/97536