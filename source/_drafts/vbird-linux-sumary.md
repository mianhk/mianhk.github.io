---
title: Linux基础-鸟哥的私房菜总结
date: 2018-04-24 21:01:56
update: 2018-04-24 21:01:59
categories: Linux
tags: [Linux,后台开发]
---
update:
	2018-04-24 首次更新


# 基本命令
## 一般通用的参数选项
Linux中有很多通用的选项，意义较为熟悉，很多时候我们可以不用去记这么多东西，记得一些含义的时候，也可以都不用`man`就能直接想到。
* `-h`：大部分时候，可以把一些需要转化的数目转化为我们一眼可以看的，如M、K等。例如：
	```
	ls -h
	df -h
	```
* `-r`:大部分文件夹处理的时候，表示递归的意思，比如：
	```
	rm -r /test #非常危险
	cp -r test test1
	```  

* `-f`:(force)，强制执行
	```
	mv -f test
	cp -f
	```
* `-n`:显示行号
	```
	cat -n
	
	```
	
## 命令: ls, cp, rm, mv
### ls：查看目录和文件
- `-a`:列出所有文件  
- `-l`:列出详细属性,包括权限、所属的用户，所属用户组、文件大小
- `-i`:列出 inode号(在Linux文件系统中对应的inode节点)
### cp:复制
### rm：删除
### mv：移动
  
## 命令: cat/tac, nl, more/less，head/tail, od, touch
* cat/tac：第一行开始显示文件内容/从后往前显示  
* nl：带行号的显示文件，多了一些命令而已
* more/less：可以一页一页的显示/还可以往前翻 
* head/tail: 显示头几行/显示尾几行  
* od:以二进制的方式读取文件  
* touch:修改文件时间或创建新文件

# 文件系统
## 硬链接/软链接
https://www.cnblogs.com/crazylqy/p/5821105.html
# 用户管理
# vim相关
# shell
## 运行shell
* 切换到目录下运行或在绝对路径中运行：
```
#切换到目录
cd /data/shell
./hello.sh

绝对路径中运行

/data/shell/hello.sh
```  
* 直接使用bash 或sh 来执行bash shell脚本:
```
cd /data/shell
bash hello.sh
sh hello.sh
```  
* 在当前的shell环境中执行bash shell脚本：
```
cd /data/shell
./hello.sh

source hello.sh  #两者效果有点不一样
```

# IO模型
Linux IO模式及 select、poll、epoll详解https://segmentfault.com/a/1190000003063859
## 用户空间与内核空间
## 进程切换

