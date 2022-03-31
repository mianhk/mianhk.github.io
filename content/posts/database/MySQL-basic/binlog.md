+++
title = "【MySQL】Binlog详解"
urlname = "xzxhct"
date = "2020-11-05T20:04:46+08:00"
update = "Mon Nov 05 2018 20:04:50 GMT+0800 (中国标准时间)"
categories = ["MySQL"]
tags = ["MySQL"]
description = ""
+++


Binlog作为MySQL重要的灵魂之一，在MySQL的主从同步、问题定位、数据恢复、增量备份等都发挥着重要的作用。也是MySQL多年来被大家信任的原因之一，同时Binlog也随着MySQL的流行被大家熟知，不过对于很多人来说，只是知道Binlog记录MySQL操作的功能，以及做过简单的解析查看操作SQL，却并没有深入。最近与Binlog交流比较多，就正好梳理下。

<!--more-->  



# 什么是Binlog

Binlog是MySQL server层的日志，记录MySQL的数据更新或潜在更新的SQL语句。Binlog是与innodb引擎中的undo log和redo log不一样的

## Binlog作用

binlog的作用主要包括：

- 主从同步：在一个MySQL集群中，从库通过拉取主库的Binlog，在本地进行回放执行，从而同步主库的数据更新，达到主从同步的目的。主从同步也是一般生产环境MySQL服务高可用的必要保障。
- 数据恢复：作为一个数据存储工具，可能存在写错数据的情况，需要回滚到某一时间点，可以通过解析Binlog，通过binlog2sql等工具，来闪回到指定的时间点。
- 增量备份：一般生产环境都会对MySQL数据进行定期的备份，以应对MySQL集群的快速扩容、版本升级等需求，全量备份耗时较长，且占用空间较多，因此一般采用全量备份+增量备份的方式对集群数据进行备份，其中增量备份备份的就是Binlog。
- 问题定位：由于所有的数据更新都会记录在Binlog中，所以Binlog也是解决问题的一把好手，通过分析Binlog，有时是快速解决问题的途径。

## Binlog格式

Binlog格式分为三种：statement、row、mixed

- statement：记录数据更新的SQL。意思是binlog记录数据更新的语句，优点是节省binlog日志量，减少磁盘占用（只是在部分时候）。这种方式很简单，但是会存在问题，比如SQL中出现了now()等函数，还需要保存语句执行时候的一些信息，才能使语句在回放的时候不至于数据不一致。但是仍然有一些函数无法被复制。
- row：记录数据变更的行记录。记录每一行被更改的记录，这样就能保证函数的执行也能被完全的记录，问题是，如果某条语句更新的行数较多（如变更表结构），会产生较多的Binlog，日志量增长很大。
- mixed：是statement和row格式的一种折中，结合了两者的优点。会自动切换采用row还是statement格式，但是还是会存在数据不一致的问题。级联复制在特殊情况下会binlog丢失。

在实际生产环境中，为了保证数据完全一致，还是会采用row格式的binlog，毕竟作为底层软件，首先应该保证正确，其次才是节省。

## Binlog何时写入

Binlog在事务commit前才会写入（由于innodb的两阶段提交，会先写Binlog再写redo log）。

同时binlog的写入会通过参数`sync_binlog` 控制，如果设置为0，则表示不会主动控制Binlog的刷新，由文件系统控制缓存的刷新，设为0安全，当MySQL异常重启会丢失缓存中的事务。一般生产环境主库会设置为1，保证每次事务都能被写到磁盘。       

## 与其他日志的区别



# 使用Binlog



## MySQL配置

Binlog的配置有一下几个参数

```
log_bin = on   # 开启binlog
binlog_format = row  # binlog格式为row 
log_bin = /home/work/mysql/log/mysql-bin.log # binlog 位置
expire_logs_days = 7  # binlog清理周期7天
max_binlog_size = 1G  # binlog文件大小
sync_binlog = 1   # binlog刷盘控制，为1表示每次事务都会刷盘
max_binlog_cache_size = 2147483648  # 最大binlog缓存大小，如果一个事务的binlog超过此大小，会报错
binlog_rows_query_log_events = on  # 展示SQL
```



## 查看Binlog

### 查看Binlog信息



```
# 查看现有的binlog文件
mysql> show binary logs;
+------------------+-----------+
| Log_name         | File_size |
+------------------+-----------+
| mysql-bin.000001 | 142554153 |
+------------------+-----------+

# 查看当前binlog位点
mysql> show master status\G
*************************** 1. row ***************************
             File: mysql-bin.000001
         Position: 142556517
     Binlog_Do_DB:
 Binlog_Ignore_DB:
Executed_Gtid_Set: 727332c9-1a67-11eb-8021-fa163e7d3507:1-841889,
73841e3c-ec47-11ea-9d43-fa163e263d6f:1-150

# 清理binlog
PURGE BINARY LOGS TO 'mysql-bin.000001'; # 清理到
PURGE BINARY LOGS BEFORE '2014-04-28 23:59:59';

# 查看binlog事件
show binlog events in 'mysql-bin.000001'; 
```



### 远程查看

```
mysqlbinlog -R -hhostname -uroot -p123456 mysql-bin.000001 > binlog.sql
```

### 本地查看

```
mysqlbinlog --base64-output=DECODE-ROWS --start-position=start_position --end-position=end_position --start-time=start_time --end-time=end_time -v -v mysql-bin.000776 | less
```

# Binlog内容

## Binlog基本格式

如官方文档所说:

- binlog文件以一个值为0Xfe62696e的魔数开头，这个魔数对应0xfe 'b''i''n'。  
- binlog由一系列的binlog event构成。每个binlog event包含header和data两部分。

​          `header`部分提供的是event的公共的类型信息，包括event的创建时间，服务器等

​          `data`部分提供的是针对该event的具体信息，如具体数据的修改

- 最后一个`rotate event`用于说明下一个binlog文件
- binlog索引文件是一个文本文件，其中内容为当前的binlog文件列表。比如下面就是一个mysql-bin.index文件的内容

以执行一个insert语句为例，会产生如下几个binlog event。

```

```



## Binlog事件解析





# 注意

## 事务的写入顺序

Reference：

[官方Binlog解析](https://dev.mysql.com/doc/internals/en/binary-log.html) 

https://www.cnblogs.com/igoodful/p/11920740.html