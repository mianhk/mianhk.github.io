+++
title = "[WIP]MySQL-参数和配置解析"
date = "2022-03-31T12:18:54+08:00"
update = "2022-03-31T12:19:03+08:00"
categories = ["MySQL"]
tags = ["MySQL"]
description = ""
+++

## 参数解析
### 性能相关

#### eq_range_index_dive_limit
> 当in（数据量较大时），将该参数配置成3，将会提高该语句的查询性能。



### 数据相关

#### lower_case_table_names

##### 说明
0： 区分大小写
1：不区分大小写

另外，MySQL在Linux中的大小写规则如下：
- 数据库名和表名是严格区分大小写的。这个很好理解，可以看到库名和表名在data目录中实际表现为文件夹名和文件名，而Linux本身也是区分大小写的。
- 表的别名是严格区分大小写的。
- 列名与列的别名默认不区分大小写。
- 变量名也是严格区分大小写的。

详见[官方解释](https://dev.mysql.com/doc/refman/8.0/en/identifier-case-sensitivity.html)：
- 0表示，表在文件系统存储的时候，对应的文件名是按建表时指定的大小写存的，MySQL 内部对表名的比较也是区分大小写的
-  1表示，表在文件系统存储的时候，对应的文件名都小写的，MySQL 内部对表名的比较是转成小写的，即不区分大小写；
-  2表示，表在文件系统存储的时候，对应的文件名是按建表时指定的大小写存的，但是 MySQL 内部对表名的比较是转成小写的，即不区分大小写。

0适用于区分大小写的系统，1都适用，2适用于不区分大小写的系统。

##### 举例

##### 最佳实践
- 最好是在一开始统一设置好此参数。操作过程中，不要修改此参数，如果真要改，要先检查下已有的表是否存在大小写问题。
- 业务方不要依赖MySQL 的大小转换机制，应用内SQL的表名应该跟MySQL中的一致。

#### max_allowed_packet

##### 说明
限制 MySQL Server接收数据包的大小，线上默认为 64M。

#### slave_max_allowed_packet
##### 说明
限制从库插入的数据包大小，默认设置为1G，太小可能会造成主从复制断开。

#### max_binlog_cache_size
##### 说明
最大推荐值为 4GB，因为MySQL当前无法处理大于4GB的的二进制文件。该值必须是 4096 的倍数。

#### max_binlog_size
如果对二进制日志的写入导致当前日志文件大小超过此变量的值，则服务器会轮换二进制日志（关闭当前文件并打开下一个文件）。最小值为 4096 字节。最大值和默认值为 1GB。加密的二进制日志文件有一个额外的 512 字节标头，包含在 [`max_binlog_size`](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_max_binlog_size).
#### sql_mode

### 存储引擎相关

### 超时相关
-   connect_timeout：默认为10S
-   wait_timeout：默认是8小时，即28800秒
-   interactive_timeout：默认是8小时，即28800秒
-   net_read_timeout：默认是30S
-   net_write_timeout：默认是60S
- https://www.cnblogs.com/igoodful/p/12470021.html
## 配置解析

```Bash

# 如果系统总内存为128G，如果设置为100G以上，则容易出现内存溢出，out of memory，导致mysqld被系统重启，日志在/var/log/message中;90G最佳，设置为70到80G，则更安全
innodb_buffer_pool_size = 90G  

# 这两个参数在主库设置双1，但从库设置为双0性能最佳，极为重要的性能参数
innodb_flush_log_at_trx_commit = 0 sync_binlog = 0 # 连接数限制
max_connections = 10240 max_user_connections = 4000 # 慢查询阈值，锁等待超时阈值
long_query_time = 0.5

lock_wait_timeout   = 120

# 从库开启基于LOGICAL_CLOCK的并行复制

stop slave sql_thread;

set global slave_parallel_type='LOGICAL_CLOCK';

set global slave_parallel_workers=16;

start slave sql_thread;
```

### skip-slave-start

```yaml
# 实例启动的时候跳过建立主从关系，即禁止启动io线程和sql线程。
# 添加此参数可以避免启动的时候破坏从库数据。
skip-slave-start
```