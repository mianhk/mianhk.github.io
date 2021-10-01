+++
title = "服务器-Nginx安装和基本配置"
date = "2018-01-23T22:25:21+08:00"
categories = ["服务器"]
tags = ["后台开发", "Linux", "Nginx"]
description = ""
+++

### 服务器-Nginx安装和基本配置
#### Nginx的安装
没有看书上，直接在ubuntu输了一个nginx，大概是ubuntu的支持比较好，直接提醒可以安装，于是就毫不客气的装了一下就启动了：
```
sudo apt-get install nginx
sudo /etc/init.d/nginx start
```
接下来直接在浏览器里面打开，就能看到hello,Nginx这样欣慰 的界面了。

之后能够在文件夹`/etc`中看到我们的配置的文件：
![](https://blog-1252063226.cosbj.myqcloud.com/server/001001.jpg?raw=true)
在`var/www/html`文件夹中能看到`index.html`文件，即是我们的主页文件。
**这里没有采用源码的方式安装，其实是觉得没有必要了。 **

#### Nginx的启停
刚刚已经直接开启了Nginx了，其实关就更简单了。
```
sudo /etc/init.d/nginx stop  #停止nginx
sudo /etc/init.d/nginx restart # 重启nginx
```
这里需要注意的是nginx的平滑重启：Nginx服务进程接受到信号后，首先读取新的Nginx的配置文件，如果新的配置文件语法正确，则启动新的Nginx服务，然后平缓的关闭旧的服务进程。否则，仍然使用旧的Nginx进程提供服务。

#### Nginx服务器的升级
平滑升级：Nginx服务接收到USR2信号后，首先将旧的nginx.pid文件（如果配置文件中更改过名字，也是相同的过程）添加后缀`.oldbin`，变为nginx.pid.oldbin文件；之后执行新版本Nginx服务器的二进制文件启动服务。如果新的服务启动成功，系统中将有新旧两个Nginx服务共同提供Web服务。之后，需要像旧的Nginx服务进程发送WINCH信号，使旧的Nginx服务平滑停止，并删除nginx.pid.oldbin文件。在发送WINCH信号之前，可以随时停止新的Nginx服务。
