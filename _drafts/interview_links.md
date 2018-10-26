---
title: 面试总结-链接
date: 2018-06-24 22:03:23
categories: 面试经验 
tags: [面试,C++,工作]
---
## redis
https://blog.csdn.net/CCUTwangning/article/details/70153589  
[天下无难试之Redis面试题刁难大全](https://zhuanlan.zhihu.com/p/32540678)  https://blog.csdn.net/g0_hw/article/details/79360073

https://www.cnblogs.com/Survivalist/p/8119891.html

1. 使用redis有哪些好处？

(1) 速度快，因为数据存在内存中，类似于HashMap，HashMap的优势就是查找和操作的时间复杂度都是O(1)

(2) 支持丰富数据类型，支持string，list，set，sorted set，hash

(3) 支持事务，操作都是原子性，所谓的原子性就是对数据的更改要么全部执行，要么全部不执行

(4) 丰富的特性：可用于缓存，消息，按key设置过期时间，过期后将会自动删除



2. redis相比memcached有哪些优势？

(1) memcached所有的值均是简单的字符串，redis作为其替代者，支持更为丰富的数据类型

(2) redis的速度比memcached快很多

(3) redis可以持久化其数据



3. redis常见性能问题和解决方案：

(1) Master最好不要做任何持久化工作，如RDB内存快照和AOF日志文件

(2) 如果数据比较重要，某个Slave开启AOF备份数据，策略设置为每秒同步一次

(3) 为了主从复制的速度和连接的稳定性，Master和Slave最好在同一个局域网内

(4) 尽量避免在压力很大的主库上增加从库

(5) 主从复制不要用图状结构，用单向链表结构更为稳定，即：Master <- Slave1 <- Slave2 <- Slave3...

这样的结构方便解决单点故障问题，实现Slave对Master的替换。如果Master挂了，可以立刻启用Slave1做Master，其他不变。

4. redis事务和mysql事务的区别  
(1) 事务命令：开启事务的命令不同。  
redis:MULTI：标记事务的开始；EXEC：执行事务的commands队列；DISCARD：结束事务，并清除commands队列；  
mysql:BEGIN：显式地开启一个事务； COMMIT：提交事务，将对数据库进行的所有修改变成为永久性的； ROLLBACK：结束用户的事务，并撤销正在进行的所有未提交的修改；   

(2) 默认状态: 
Redis：Redis默认不会开启事务，即command会立即执行，而不会排队。并不支持Rollback  
MySQL：MySQL会默认开启一个事务，且缺省设置是自动提交，即，每成功执行一个SQL，一个事务就会马上 COMMIT。所以不能Rollback。  
https://blog.csdn.net/qq_32331073/article/details/79926307  

5. Memcache与Redis的区别都有哪些  
1)、存储方式
Memecache把数据全部存在内存之中，断电后会挂掉，数据不能超过内存大小。Redis有部份存在硬盘上，这样能保证数据的持久性。

2)、数据支持类型
Memcache对数据类型支持相对简单。Redis有复杂的数据类型,Redis不仅仅支持简单的k/v类型的数据，同时还提供list，set，zset，hash等数据结构的存储。

3)、使用底层模型不同
它们之间底层实现方式以及与客户端之间通信的应用协议不一样。Redis直接自己构建了VM 机制，因为一般的系统调用系统函数的话，会浪费一定的时间去移动和请求。

4）value大小
redis最大可以达到1GB，而memcache只有1MB

5) Redis支持数据的备份，即master-slave模式的数据备份。  

6)、查询速度，redis速度比memchached快


## 
