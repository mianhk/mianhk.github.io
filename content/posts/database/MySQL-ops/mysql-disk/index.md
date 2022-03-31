+++
title = "MySQL-磁盘空间释放"
date = "2022-03-30T18:40:57+08:00"
update = "2022-03-30T18:40:57+08:00"
categories = ["MySQL"]
tags = ["MySQL"]
description = ""
+++
## MySQL磁盘占用分析
MySQL作为存储，很容易想到的磁盘占用主要分为以下几种：
- 日志文件
- 数据文件
- 临时文件


### 日志文件

众所周知，MySQL 的 binlog （二进制日志） 会记录数据库的操作，一般线上会存储至少7天。当线上业务增删改请求太频繁，或者修改的行数过多时（因为为了线上数据安全，默认会使用row格式的binlog），会导致binlog文件增长很快

## 磁盘清理方式

### 日志文件清理
- 清理 binlog 文件
```Bash
# 将binlog删除到mysql-bin.001174
mysql> purge binary logs to 'mysql-bin.001174';

# 删除 2021-06-06 22:46:26 之前的binlog
mysql> purge binary logs before '2021-06-06 22:46:26';

# 将binlog自动保存时间从7天改为3天
mysql> 
mysql> set global expire_logs_days=3;
```

### 数据文件清理
一般数据文件清理需要业务方的配合，毕竟是业务方的数据。这里需要注意的是，仅仅删除数据可能不会直接[释放空间](https://funnylog.gitee.io/mysql45/13%E8%AE%B2%E4%B8%BA%E4%BB%80%E4%B9%88%E8%A1%A8%E6%95%B0%E6%8D%AE%E5%88%A0%E6%8E%89%E4%B8%80%E5%8D%8A%EF%BC%8C%E8%A1%A8%E6%96%87%E4%BB%B6%E5%A4%A7%E5%B0%8F%E4%B8%8D%E5%8F%98.html)。此时有两种方案：
- 机器磁盘还有较大空间。此时仅仅删除数据即可，新写入的数据会填补未使用的页。
- 机器磁盘空间已经不足。需要执行重建表操作，具体操作步骤为：
```Bash
# 1. 从库停止复制
mysql> stop slave;
# 2. 从库重建表
mysql> alter table xx engine=innodb;
# 3. 执行主库切换操作
# 具体见切库流程
```

### 大表清理
为了减小删除大文件引起数据库服务器 IO 抖动，可以对大文件进行shrink，减小删除数据对IO的影响。

```Bash
# 待删除表：dest_table_del
# 1.创建硬链接
$ln dest_table_del.ibd /home/work/data_bak/dest_table_del.ibd.hdlk
# 2.删除表:
$drop table dest_table_del;
# 3.删除文件
# 从233 开始每次递减2
$for i in `seq 233 -2 2 `; do echo $i; sleep 2; /usr/bin/truncate -s ${i}G  /home/work/data_bak/dest_table_del.ibd.hdlk;done

```

## 临时文件清理

从临时文件的原理可以看到，一般是由大 `SQL` 引起，所以直接找到大 `SQL` ，与业务方沟通完后杀掉即可。

## 其他解决方式
### 1. 联系业务删除数据
- 可能是最快的方式。
- 甚至可以让业务写定时删除数据的脚本，但是注意一次不要删除大量的数据，避免引起主从延迟。
- 当业务删除完数据后，去掉从库业务流量，并在从库执行释放空间操作
```SQL
mysql> stop slave;
mysql> alter table xx engine=innodb;

```


> 此处不用 `optimize table`的原因，其实`optimize table`实际上是 recreate + analyze 的步骤。

### 2. 大库迁移
当某个库数据量很大，且 QPS 不低，足以作为单独的集群时，可以进行迁移操作。具体的迁移步骤：
- 扩容从库
- 该库读流量打入新的从库，同业务共同观察业务
- 与业务沟通时间并进行写流量迁移

### 3. 申请大磁盘空间机器替换
具体操作步骤：
- 替换从库机器
- 主库切换
- 下线旧机器

## 总结
其实数据库的磁盘空间在日常运维工作中就是应该持续关注的事情。可行的策略是：
- 在磁盘占用还不是太高的时候（60%-80%）：增加日常巡检处理提醒，此时可以开始关注，如有大表，需联系业务开始处理，不至于在后面的改表或者磁盘空间快满时陷入被动。
- 磁盘已经告警时：参考解决方法。

最重要的还是主动解决，避免被动。

## 参考
- 大表删除操作：http://blog.itpub.net/22664653/viewspace-750408/

