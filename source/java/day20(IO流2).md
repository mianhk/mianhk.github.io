---
title: day5(面向对象2)
date: 2017-03-09 12:55:17
categories: Java
tags: java
---
# IO流

----------
## File类
用来将文件或文件夹封装成对象。
方便对文件与文件夹的属性信息进行操作。
File对象可以作为参数传递给
## File类的常见方法
1.创建
boolean createNewFile()
boolean mkdir()
boolean mkdirs()

2.删除
 boolean delete()  删除失败返回false
void deleteOnExit()  在程序退出时删除文件

3.判断
boolean exists() 文件或目录是否存在。
记住在判断文件对象是否是文件或者目录时，必须要先判断该文件对象封装的内容是否存在，通过exists判断。
boolean isFile()
boolean isDirectory()

4.获取信息。
 String getName()
 String getParent()  该方法返回的是绝对路径中的父目录，如果获取的是相对路径，则返回null。
 String getPath()
 File getAbsoluteFile()
  long lastModified()
long length()
 ## 文件列表
static File[] listRoots()
 String[] list() 调用list方法的必须是封装的一个目录。该目录还必须存在。
## 列出目录下所有的内容
递归
递归要注意：
1.限定条件。
2.要注意递归的次数，尽量避免内存溢出。
## 删除一个带内容的目录
删除原理：
在Windows中，删除目录从里面往外删除的。既然是从里往外删除，就需要用到递归。
## 创建java文件列表
## properties
properties是hashtables的子类，也就是说它具备map集合的特点。而且它里面存储的键值对都是字符串。是集合中和IO技术相结合的集合容器。
该对象的特点：可以用于键值对形式的配置文件。
##IO包中的其他类
打印流：该流提供了打印方法，可以将各种数据类型的数据都原样打印。
字节打印流
PrintStream
构造函数可以接收的参数类型。
1. file对象。File
2. 字符串路径
3. 字节输出流
字符打印流
PrintWrite
1. file对象。File
2. 字符串路径
3. 字节输出流

## 合并流和切割文件

