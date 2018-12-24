---
title: 腾讯云服务器Linux挖比特币
date: 2018-01-19 22:56:59
categories: 工具
tags: 工具
---
### 腾讯云服务器Linux挖比特币
毕竟又是一个周五的下午，有点等着放假，就想起来现在的挖矿，虽然现在挖矿都是专门的矿机或者是显卡之类的。但是经过计算，好像自己挖的话连电费都不够，就想试试云服务器可不可以，虽然CPU做这种傻瓜的计算问题可能不如专门的器件是吧。
<!--more-->
这是我的ubuntu服务器的。
* 注册一个矿池账号，推荐https://www.f2pool.com/
* 通过ssh连接远程服务器
* 下载挖矿工具
这里别人推荐的地址可能有问题，或者我这个之后也会升级，所以可以直接去官网下载最新的推荐的版本就行。
```
wget http://downloads.sourceforge.net/project/cpuminer/pooler-cpuminer-2.5.0-linux-x86_64.tar.gz
```
* 解压
```
tar xvzf ooler-cpuminer-2.5.0-linux-x86_64.tar.gz
```
* nohup命令后台一直运行
注意：不同的端口对应不同的币，一个用户名可以在后面例如：mianhk.001，mianhk.002代表不同的矿机。userpass后面是账户名和密码
```
# 以下不同的地址对应的是不同的矿
nohup ./minerd -a scrypt -o stratum+tcp://stratum.f2pool.com:3333 --userpass=账号:密码 &

nohup ./minerd -a scrypt -o stratum+tcp://xmr.f2pool.com:13531 --userpass=账号:密码 &

nohup ./minerd -a scrypt -o stratum+tcp://zec.f2pool.com:3357 --userpass=账号:密码 &
```
之后，就可以打开日志文件看到在挖矿了。我们还需要在网站填上自己的比特币钱包地址。但是这个挖的数目确实有点小啊
  ![](https://blog-1252063226.cosbj.myqcloud.com/tools/001001.png?raw=true)

之后打开腾讯云服务器可以看到CPU已经跑满了啊。
![](https://blog-1252063226.cosbj.myqcloud.com/tools/001002.png?raw=true)


然后之后就看到网上说云服务器跑的太满的话，会被封的，那就把CPU限制一下吧。
步骤如下：
```
sudo apt-get install cpulimit
top  # 查看pid
cpulimit -p pid -l n  # n是限制的值


```
**下面是centos的，因为有两台服务器，但是centos放的是vpn，平时还没装过软件呢**
```
yum install epel-release
yum install cpulimit
top  # 查看pid
cpulimit -p pid -l n  # n是限制的值
```

限制之后，就能明显的看到CPU占用没有满了：
![](https://blog-1252063226.cosbj.myqcloud.com/tools/001003.jpg?raw=true)
![](https://blog-1252063226.cosbj.myqcloud.com/tools/001004.jpg?raw=true)


哈哈，就当玩玩吧，多了解一下区块链，总得跟上节奏吧，虽然已经有点晚了的样子
