+++
title = "大型网站架构技术-架构模式"
date = "2018-02-03T16:39:27+08:00"
categories = ["服务器"]
tags = ["后台开发", "大型网站技术", "架构"]
description = ""
+++

## 大型网站架构技术-架构模式
模式的关键在于模式的可重复性。
<!--more-->
> 每一个模式描述了一个在我们周围不断变化重复发生的问题及该问题解决方案的核心。这样就能一次次的使用该方案而不必做重复的工作。

这是经过很多个实践，被很多网站重复使用而逐渐形成大型网站架构模式：
### 分层
将系统再横向维度上切成几个部分，每个部分负责一部分相对单一的职责。就好比平时一份工作比较多的时候，团队中大家各自负责自己擅长的那一部分。大型网站中一般分为三层：
* 应用层：负责具体业务和视图展示。
* 服务层：为应用层提供服务支持。
* 数据层：提供数据存储访问服务。如数据库、缓存、文件、搜索引擎等。
需要注意的是：这个分层是逻辑的，并不一定要部署在不同的服务器上，可能会根据业务调整。  

### 分割
对业务进行横向切分。比如应用层：分为购物、论坛、搜索等。  

### 分布式
一台服务器解决不了的时候，就采用分布式解决一下。
分为：分布式应用和服务，分布式静态资源，分布式数据和存储，分布式计算。  

### 集群
使用分布式已经将分层和分割后的模块独立部署，但是对于用户集中访问的模块，可能还需要将独立部署的服务器集群化（多台服务器部署相同的应用构成一个集群），再通过一个负载均衡服务器对外提供服务。  

### 缓存
缓存是改善软件性能的第一手段。
* CDN：讲内容部署在离用户最近的网络服务商，用户请求的时候，可以直接访问网络服务商缓存的静态资源，所以会很快。
* 反向代理：用户请求到网站的数据中心时，最先访问的是反向代理服务器，这里会缓存网站的静态资源。
* 本地缓存：应用服务器本地缓存的热点数据，可以在本机内存中直接访问，不需要访问数据库。
* 分布式缓存：数据量非常庞大时，需要的内存不是单机能承受的。因此还需要分布式缓存    

### 异步
业务之间的消息传递不是同步调用，而是将一个业务操作分成多个阶段，每个阶段之间通过共享数据的方式异步进行协作。
在单一服务器内部：采用**多线程共享队列**的方式实现异步。在分布式系统中：多个服务器集群通过分布式消息队列实现异步，分布式消息队列可以看做内存的分布式部署。

分布式消息队列的特性：网站扩展新功能便利，提高系统可用性，加快网站响应速度，消除并发访问高峰。  

### 冗余
备份嘛，较少的机器可能坏的时间不长，但是小概率时间试验的次数过多的话就基本是必然事件了。

### 自动化
主要集中在运维方面，包括：发布过程自动化、自动化代码管理、自动化测试、自动化安全监测、自动化部署。对于运行中：自动化监控、自动化报警、自动化失效转移、自动化失效恢复、自动化降级、自动化分配资源。

### 安全
密码和手机验证码；加密；网站验证码。