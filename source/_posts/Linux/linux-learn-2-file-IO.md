---
title: Linux学习-文件I/O
date: 2017-11-12 19:33:00
categories: Linux
tags: [Linux,后台开发]
---

### 文件系统
#### 文件描述符
一个进程默认打开三个文件描述符
```
STDIN_FILENO 0
STDOUT_FILENO 1
STDERR_FILENO 2
```
新打开文件返回文件描述符表中未使用的最小文件描述符。
**open函数 **
```
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
int open(const char *pathname, int flags);
int open(const char *pathname, int flags, mode_t mode);
返回值：成功返回新分配的文件描述符，出错返回-1并设置errno
```


