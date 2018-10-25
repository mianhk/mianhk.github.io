---
title: day5(面向对象2)
date: 2017-03-09 12:55:17
categories: Java
tags: java
---
# StringBuffer

----------
## StringBuffer 是字符串缓冲区。是一个容器，
1. 而且长度是可变化的。
2.  可以操作多个数据类型。
3.  最终会通过toString方法变成字符串
C（create）U（update）R（read）D（delete）
1.存储
 StringBuffer append（）：将指定的数据作为参数添加到到已有数据的结尾处
StringBuffer insert（index，数据）：可以将数据 插入到数据指定index位置
2.删除
String
3.获取
4.修改

## StringBuilder
java升级的三个因素：
1.提高效率
2.简化书写
3.安全性

## 基本数据类型对象包装类
byte   Byte
short  short
int Integer
long  Long
boolean Boolean
float Float
double  Double
char  Character
基本数据类型对象包装类的最常见作用：就是用于基本数据类型和字符串类型之间做转换。
基本数据类型转成字符串。  基本数据类型+“”或者 基本数据类型.toString(基本数据类型值)
字符串转基本类型。基本数据类型包装类 a=Xxx.parseXxx(String)

