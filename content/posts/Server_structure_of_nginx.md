+++
title = "服务器-Nginx模块化结构"
date = "2018-01-25T11:52:30+08:00"
categories = ["服务器"]
tags = ["后台开发", "Linux", "Nginx"]
description = ""
+++

### 服务器-Nginx模块化结构
习惯上将Nginx分为：核心模块、标准模块、可选HTTP模块、邮件服务模块和第三方模块五大类。
#### 核心模块
包含对两部分功能的支持：
* 主体功能：进程管理、权限控制、错误日志记录、配置解析等
* 用于响应请求必需的功能：事件驱动机制、正则表达式解析等    
     
#### 标准HTTP模块
对应基本的HTTP服务  

#### 可选HTTP模块
快速编译中默认不编译，需要使用的话需要自己加上--with-XXX的参数声明。

#### 邮件服务模块
Nginx的主要服务之一，快速编译时也不会编译

#### 第三方模块