

## 主从问题
### 主从延迟
```
降低安全性的前提下，修改 提高主从同步速度
innodb_flush_log_at_trx_commit=0;
sync_binlog=0;
set global sync_binlog=0;   # 原为1
set global innodb_flush_log_at_trx_commit=0;  # 原为1

set global sync_binlog=1000;   # 原为1
set global innodb_flush_log_at_trx_commit=2;  # 原为1
```