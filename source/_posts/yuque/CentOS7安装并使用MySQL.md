---
title:  CentOS7安装并使用MySQL
urlname: afzlb7
date: 2018-12-07 17:41:58
categories: [MySQL]
tags: [MySQL,学习]
---

> MySQL 在 CentOS 上的安装和使用

<!--more-->  

# yum 安装

date: 2018-12-9 21:57:59
update: 2018-12-9 21:57:59 1.首先找到官网 yum 的地址：[https://dev.mysql.com/downloads/repo/yum/](https://dev.mysql.com/downloads/repo/yum/)，找到 redhat 的版本**Red Hat Enterprise Linux 7 / Oracle Linux 7 (Architecture Independent), RPM Package**,并复制 download 的地址，然后下载下来：

```bash
wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
```

2.进行 rpm 解包并安装 mysql-server

```bash
rpm -ivh mysql-community-release-el7-5.noarch.rpm
yum update
yum install mysql-server
```

3.修改权限

```bash
chown mysql:mysql -R /var/lib/mysql
```

4.然后就可以启动 mysql 了。。

```bash
systemctl start mysqld
```

# 问题记录

当然，看着上面好像很爽，很快的样子，但是没想到接下来坑还是很多的。都有点怀疑自己了，到现在装个 mysql 还这么多问题。关键是，网上的解决办法，都是什么乱七八糟的。

## 1.状态查看-灰色

```powershell
➜  ~ systemctl status mysqld
● mysqld.service - MySQL Server
   Loaded: loaded (/usr/lib/systemd/system/mysqld.service; enabled; vendor preset: disabled)
   Active: inactive (dead)
     Docs: man:mysqld(8)
           http://dev.mysql.com/doc/refman/en/using-systemd.html

➜  ~ ps ajx | grep mysql
 1768  1784  1784  1784 ?           -1 Ssl    999   0:19 mysqld
```

1.看了一下版本号，没错是 8.0：

```bash
➜  ~ mysqladmin --version
mysqladmin  Ver 8.0.13 for Linux on x86_64 (MySQL Community Server - GPL)
```

2.然后 mysql 连一波，出问题，连不上：

```bash
➜  ~ mysql
ERROR 2002 (HY000): Can't connect to local MySQL server through socket '/var/lib/mysql/mysql.sock' (2)
```

看样子是没有这个 socket，应该是位置不对，于是`sudo find / -name mysql.sock `赶紧搜一下，什么都没有，没有办法，重启一下试试吧。 3.重启

```bash
➜  ~ sudo systemctl restart mysqld
Job for mysqld.service failed because the control process exited with error code. See "systemctl status mysqld.service" and "journalctl -xe" for details.
```

不行，换种方式重启看看：

```bash
➜  ~ service mysqld start
Redirecting to /bin/systemctl start mysqld.service
==== AUTHENTICATING FOR org.freedesktop.systemd1.manage-units ===
Authentication is required to manage system services or units.
Authenticating as: root
Password:
polkit-agent-helper-1: pam_authenticate failed: Authentication failure
==== AUTHENTICATION FAILED ===
Failed to start mysqld.service: Access denied
See system logs and 'systemctl status mysqld.service' for details.
```

## 2.错误：2002

错误详情：
ERROR 2002 (HY000): Can't connect to local MySQL server through socket '/var/lib/mysql/mysql.sock' (2)

这个错误网上找了一下，有看起来还可以的处理:[http://blog.51cto.com/pengjc/1861088](http://blog.51cto.com/pengjc/1861088) 。但是实际上我打开都没有这个文件，搜也没有搜到，于是放弃，这个问题应该不算个问题，先放着解决别的。

## 3.错误：service failed

错误详情：
Job for mysqld.service failed because the control process exited with error code. See "systemctl status mysqld.service" and "journalctl -xe" for details.
看了一下网上的解决办法，说是由于权限的问题：[https://www.cnblogs.com/ivictor/p/5146247.html](https://www.cnblogs.com/ivictor/p/5146247.html) ，通过命令`chown mysql.mysql /var/run/mysqld/`，但是问题还是没有解决。  
看了一下[stackoverflow](https://stackoverflow.com/questions/42317139/job-for-mysqld-service-failed-see-systemctl-status-mysqld-service)上面的说法，先通过`tail -f /var/log/mysqld.log`查看一下,，但是我的这个问题不是因为没有权限，

```bash
➜  ~  tail /var/log/mysqld.log
2018-12-07T09:13:21.651467Z 0 [ERROR] [MY-010119] [Server] Aborting
2018-12-07T09:13:21.655750Z 0 [System] [MY-010910] [Server] /usr/sbin/mysqld: Shutdown complete (mysqld 8.0.13)  MySQL Community Server - GPL.
2018-12-07T09:15:40.466437Z 0 [System] [MY-010116] [Server] /usr/sbin/mysqld (mysqld 8.0.13) starting as process 12759
2018-12-07T09:15:40.965670Z 0 [ERROR] [MY-012681] [InnoDB] mmap(137428992 bytes) failed; errno 12
2018-12-07T09:15:40.965740Z 1 [ERROR] [MY-012956] [InnoDB] Cannot allocate memory for the buffer pool
2018-12-07T09:15:40.965766Z 1 [ERROR] [MY-012930] [InnoDB] Plugin initialization aborted with error Generic error.
2018-12-07T09:15:40.965794Z 1 [ERROR] [MY-010334] [Server] Failed to initialize DD Storage Engine
2018-12-07T09:15:40.965949Z 0 [ERROR] [MY-010020] [Server] Data Dictionary initialization failed.
2018-12-07T09:15:40.965977Z 0 [ERROR] [MY-010119] [Server] Aborting
2018-12-07T09:15:40.966835Z 0 [System] [MY-010910] [Server] /usr/sbin/mysqld: Shutdown complete (mysqld 8.0.13)  MySQL Community Server - GPL.
```

搜了一下这个问题：
`[ERROR] [MY-012681] [InnoDB] mmap(137428992 bytes) failed; errno 12`
看样子是内存映射出错，再通过命令`journalctl -xe`看一下,同时也找到了原因：原来是**swap 分区是 0(https://blog.csdn.net/sxyandapp/article/details/77091007),于是一阵操作：**

```bash
➜  ~ free -m
/dev/vda1            /                    ext4       noatime,acl,user_xattr 1 1
              total        used        free      shared  buff/cache   available
Mem:            992         516         304           0         171         321
Swap:             0           0           0

➜  ~ dd if=/dev/zero of=/swap bs=1M count=512
dd: failed to open ‘/swap’: Permission denied

➜  ~ sudo dd if=/dev/zero of=/swap bs=1M count=512
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 4.01658 s, 134 MB/s

➜  ~ sudo mkswap /swap
Setting up swapspace version 1, size = 524284 KiB
no label, UUID=9bbac588-e6ee-4b1c-a398-4ac460ad476a

➜  ~ sudo swapon /swap
swapon: /swap: insecure permissions 0644, 0600 suggested.

➜  ~ free -m
              total        used        free      shared  buff/cache   available
Mem:            992         516          64           0         410         317
Swap:           511           0         511


vi /etc/fstab
#在其中添加如下一行,保证下次系统启动后，此swap分区被自动加载，需要修改系统的fstab文件
/swap swap swap defaults 0 0
```

之后再重启就好了。

## 4.错误：登录问题

错误详情：
error: 'Access denied for user 'root'@'localhost' (using password: NO)'

这个其实是密码的问题，没有设置密码的时候，mysql 会生成一个临时的密码，通过命令：

```bash
➜  ~ sudo grep 'temporary password' /var/log/mysqld.log
2018-12-07T09:08:22.908621Z 5 [Note] [MY-010454] [Server] A temporary password is generated for root@localhost: TdqPeZ-n;4Ah
```

可以看到生成的临时密码，然后用临时密码登录即可。

## 5.修改密码

可能因为 8.0 的版本，修改的密码不能过于简单，并且命令好像也有些不一样了，用的是``

```bash
ALTER USER 'root'@'localhost' IDENTIFIED BY 'MyNewPass';
```

看到一个别人的回答：
![](https://cdn.nlark.com/yuque/0/2018/png/187932/1544177770052-39cd9fe0-1c11-4059-be21-08de2d19446b.png#align=left&display=inline&height=148&originHeight=148&originWidth=695&status=done&width=695)
应该是后面才改的？

# 6.外网连接 mysql

由于两台服务器的版本有点不一样，修改外网连接也有点不一样。

## [MySQL5.7](https://blog.csdn.net/w20228396/article/details/70143500)

1.修改配置文件

```bash
#修改配置文件
sudo vi /etc/mysql/mysql.conf.d/mysqld.cnf   # bind-address=127.0.0.1 修改成 bind-address=0.0.0.0

# 重启服务
service mysql restart

# 添加远程连接mysql的账号
> grant all on *.* to root@'%' identified by '123456';
> flush privileges;
#
*.*          第一个*表示库，第二个*表示表; *.*对全部数据库的全部表授权，so.ok 表示只对so这个库中的ok表授权
root        表示要给哪个用户授权，这个用户可以是存在的用户，也可以是不存在的
'%'          表示允许远程连接的IP地址，%代表允许所有IP连接
```

## [MySQL8.0](https://stackoverflow.com/questions/50177216/how-to-grant-all-privileges-to-root-user-in-mysql-8-0)

8.0 的版本总结的对权限的管理严格很多，毕竟数据很重要，只有安全才能放心。尝试过上述方式，但是连接不上。最终在 Stack Overflow 上找到了办法。

```bash
CREATE USER 'root'@'%' IDENTIFIED BY 'root';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
```

但是修改之后还是会有问题，出现了 2059 错误：  
![](https://cdn.nlark.com/yuque/0/2018/png/187932/1544449883818-59e9985f-7a74-47f5-954e-4e8aa80ced7c.png#align=left&display=inline&height=129&originHeight=129&originWidth=586&status=done&width=586)
解决方式可以采用修改密码为简单密码：

```bash
SET GLOBAL validate_password.policy=0;
ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY '12345678';
```

# 使用过程问题

## 1.导入数据出错

错误代码：

```
mysql> LOAD DATA LOCAL INFILE '/home/mianhk/pet.txt' INTO TABLE pet;
ERROR 1148 (42000): The used command is not allowed with this MySQL version

mysql> LOAD DATA INFILE '/home/mianhk/pet.txt' INTO TABLE pet;
ERROR 1290 (HY000): The MySQL server is running with the --secure-file-priv option so it ca
nnot execute this statement

mysql> LOAD DATA INFILE '/home/mianhk/pet.txt' INTO TABLE pet LINES TERMINATED BY '\r\n';
ERROR 1290 (HY000): The MySQL server is running with the --secure-file-priv option so it ca
nnot execute this statement
```

原因：
secure_file_priv 设置了指定目录，需要在指定的目录下进行数据导出。

```
mysql> show variables like '%secure%';
+--------------------------+-----------------------+
| Variable_name            | Value                 |
+--------------------------+-----------------------+
| require_secure_transport | OFF                   |
| secure_file_priv         | /var/lib/mysql-files/ |+--------------------------+-----------------------+
2 rows in set (0.01 sec)
```

数据导入需要注意的:

- 空值要用 `\N`  代替，而不能直接使用空
- 分隔符一般用 `tab`
- 注意换行符

# 总结

总之，感觉之前 windows 和 ubuntu 下都没有这么麻烦，这里总结一下吧，感觉以后会用的很多，不想踩坑了。

# 参考：

[MySQL8.0.11 连接错误 2059 解决方法](https://juejin.im/entry/5af5d2786fb9a07aaf3547cc)
[How to grant all privileges to root user in MySQL 8.0](https://stackoverflow.com/questions/50177216/how-to-grant-all-privileges-to-root-user-in-mysql-8-0)
[centos mysql 初探 -- 配置、基本操作及问题](https://www.cnblogs.com/echo-coding/p/9172636.html)
