---
title: shell编程--总结
date: 2018-06-22 11:07:13
categories: Linux
tags: [Linux,后台开发,Redis,Nosql]
---
> shell脚本是Linux 下用的最多的了，由于服务器开发基本都是在Linux下，有的时候命令行敲的命令比较长，或者是需要讲命令保存下来之后执行的时候，或者定时做一些简单的处理，都可以采用shell脚本语言，作为脚本语言，当然也有很多的特性。我平时用的比较杂乱，就觉得需要总结一下。不过因为自己看的会出问题的或者记起来模糊的，就不记录一些乱七八糟的了。  
   
<!--more-->
## 变量
- 变量：一般要加{},定义变量的时候直接定义，取变量值的时候采用$符号。  
- 删除变量：unset para  没有$前缀   
- 变量类型：局部变量（仅对当前shell有效），环境变量，shell变量（由shell程序设置的特殊变量）。    
## 字符串
### 单引号和双引号
单引号：str='hello'  会原样输出，单引号中的变量是无效的。  
双引号：可以出现变量，转义字符。 
### 字符串操作
- 拼接：str="hello,$str1" 
- 获取长度：echo ${#str}  
- 提取子串：echo ${str:1:4}  
- 查找子串：  

## test命令 
### 数值测试
- -eq:等于   -ne:不等于
- -gt:大于   -lt:小于   
- -ge:大于等于 -le:小于等于   
### 字符串测试
- -z:字符串长度为0   -n:字符串长度不为0  
## 流程控制
eg：  
```  
if condition  
then
    command1
else
    command2
fi                 # 结束if标志，有点不同  
```
## awk使用
> awk平时用的很多，传说中的文本处理神器，但是很多细节的东西，总是记不住。     

[AWK 简明教程](https://coolshell.cn/articles/9070.html)

## sed使用
[sed命令](http://man.linuxde.net/sed)
## 注意

- 函数：参数 $1 $2 ，按照顺序，调用的时候格式为：func para1 para2 .. 


