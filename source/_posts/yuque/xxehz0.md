
title: MySQL相关概念总结
date: 2019-01-25 09:56:46 +0800
tags: []
categories: 
---

title: MySQL相关概念总结<br />date: 2019-1-20 11:27:21<br />categories: MySQL<br />tags: [MySQL,学习]

---

# 三大范式
**第一范式（1NF）：**无重复的列。<br />要求：表所有的属性不可再分。<br />如果不符合第一范式，则不符合关系模型的定义。<br />**第二范式（2NF）：**属性完全依赖于主键 [ 消除部分子函数依赖 ]。<br />要求：在满足1NF前提，每一行能够唯一标识，不存在非主键字段。<br />常用方法可以增加一个单字段的主键。<br />**第三范式（3NF）**：属性不依赖于其它非主属性 [ 消除传递依赖 ]。<br />要求：在满足2NF前提，不出现类似于A->B->C的情况，这样的传递依赖可以分为两个表，分别保存。

通用的原则：
* 每个实体都有一个表。
* 为每一个关系（二维表）增加一个逻辑主键作为标识。
* 出现二维表对应的关系，采用1:1, 1:N, M:n的形式将关联关系设计。


# MySQL日志类型
**错误日志**：记录启动、运行或停止mysqld时出现的问题<br />**查询日志**：记录建立的客户端连接和执行的所有语句（包括错误的）<br />**二进制日志**：记录所有更改数据的语句、还用于主从复制<br />**慢日志**：记录所有执行时间超过long_query_time秒的所有查询

# 索引
索引：对数据库表中一或多个列的值进行排序的结构，是帮助MySQL高效获取数据的数据结构，可以 加快检索表中的数据，而不必扫描整个数据库。<br />缺点是：需要占用额外的空间，并且需要定期维护，每条记录的INSERT,DELETE,UPDATE操作可能付出更多的磁盘IO。同时不必要的索引反而会使查询速度变慢。<br />索引查询的适用的情况：基于一个范围的检索，一般查询返回结果集小于表中记录数的30%。基于非唯一性索引的检索。<br />数据库几个基本的索引类型：普通索引、唯一索引、主键索引、全文索引<br /><br />
# 事务
事务：并发控制的基本单位，是一个操作序列，这些操作要么都执行，要么都不执行，是一个不可分割的工作单位。<br /><br />
## 事务的隔离级别
分为四个级别：  <br />未提交读:允许脏读，可能读到其他会话没有提交的数据。<br />已提交读:只能读到已经提交的数据。ORACAL等多数数据库的默认隔离级别。   <br />可重复读:可重复读，同一事务内的查询都是和事务开始时一致的，Innodb的默认隔离级别。  <br />串行读：完全串行化的读，每次读都需要获得表级共享锁，读写相互会阻塞。<br />  <br />对应：脏读、不可重复读、幻读情况为：<br />脏读：当一个事务正在访问数据，并且对数据进行了修改，这个修改还没提交到数据库。另一个事务也访问这个数据，使用了这个数据。  <br />不可重复读：一个事务内，多次读同一数据。这个事务还没结束时，另一个事务也访问这个数据，导致第一个事务两次访问的数据不一样。  <br />幻读：第一个事务对表中的每一行数据进行了修改，同时第二个事务也访问这个表中的数据，这种修改是向表中插入而来一行数据，那么以后就会发生操作第一个事物的用户表中发现表中还有没修改的数据行，像是产生了幻觉。<br />[MySQL 四种事务隔离级的说明](https://www.cnblogs.com/zhoujinyi/p/3437475.html)<br /><br />
# DROP、DELETE与TRUNCATE
DROP：不仅删除表的数据，还删除表的结构。<br />DELETE和TRUNCATE只删除表的数据不删除表的结构。<br />删除速度：DROP> DELETE>TRUNCATE<br />适用场景：当不需要一张表的时候，适用DROP；删除部分数据行的时候，用DELETE，并且使用where子句；保留表而删除所有数据的时候用TRUNCATE。

# 存储引擎
MySQL目前用的比较多的两种，是Innodb和Myisam

<br />