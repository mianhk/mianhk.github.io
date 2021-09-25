+++
title = "jupyter-notebook安装和问题解决"
date = "2018-04-26T11:36:57+08:00"
update = 2018-04-26T11:37:00Z
categories = "Linux"
tags = ["Linux", "工具", "jupyter", "笔记"]
description = ""
+++

> jupyter notebook折腾日记

<!--more-->
# 安装

## 1.采用直接pip安装   

`pip install jupyter `不过可能由于是版本自带的pip有问题，而且用的Python版本也还是2.7的，反正就出现了各种问题。中间解决的有：  
- 重新升级pip，但是发现直接pip还是有问题，于是找到问题原因，可能名字有点对不上，找到bin目录下还有一个pip2，在Python里面运行，发现果然是这个，有点心酸，还是换了这个。  
- 升级之后，会出现各种的权限问题，没事，给！  
- 之后运行，发现没有浏览器，于是又想起服务器上没有，又加上命令试了一下，而且每次都要复制一个长长的token吗？。。

## 2.采用Anaconda安装
正好晚上在床上看到一个链接，说这个更方便，反正也是折腾嘛，就试试了。过程稍微写一写哈

1. 在清华镜像站找到采用Anaconda相应版本下载：https://mirrors.tuna.tsinghua.edu.cn/anaconda/archive/  
	找到后复制链接：`wget 链接` 
2. 安装Anaconda:  
	`sh Anaconda3-5.1.0-Linux-x86_64.sh # 一路yes就装了`  
3. 服务器管理控制台开放8888端口（当然端口可以配置，也随便换了）  
4. 运行`jupyter notebook --generate-config` 生成默认的jupyter配置文件  
5. 编辑config文件：  
```
cd .jupyter
vim jupyter_notebook_config.py #编辑config文件
c.NotebookApp.ip = '*'  #允许所有的ip登录
c.NotebookApp.open_browser = False #打开浏览器：关闭，因为服务器没有浏览器
c.NotebookApp.port = 8888  #开放使用的端口
```
6. 保存退出。运行jupyter notebook，会得到一个带token的访问地址。复制地址，将其中的localhost替换成服务器的公网IP，访问，应该可以正常进入jupyter。  
7. 每次都tocken当然有点麻烦了。设置一个密码吧：  
	`jupyter-notebook password`
8. 之后就可以公网输入登录了。
	
## 3.安装主题和相关插件  
[jupyter_contrib_nbextensions](https://github.com/ipython-contrib/jupyter_contrib_nbextensions)  
直接使用`conda install -c conda-forge jupyter_contrib_nbextensions`
* 使用注意：
1.关于ubuntu的环境变量设置没有对，导致conda命令不能用的问题。当然知道应该是环境变量的问题，不过还是搞了很久。才发现是加在ubuntu的home目录下的`.bashrc`后面`export PATH=~/anaconda3/bin:$PATH`
2.由于我的conda版本没有更新，所以出现了插件也只有几个的情况，所以需要先更新。之后再重启jupyter notebook。
#### 参考
http://www.yaozihao.cn/2017/04/25/jupyter-%E6%9C%8D%E5%8A%A1%E5%99%A8%E9%83%A8%E7%BD%B2%E5%8F%8A%E5%90%8E%E5%8F%B0%E8%BF%90%E8%A1%8C/  
https://zhuanlan.zhihu.com/p/34289322  
https://zhuanlan.zhihu.com/p/20226040?utm_source=qq&utm_medium=social&utm_member=Y2E2MjI0YTdlMTI5YTMzOTA2NTlhZDRiMzY2MjFiNmQ%3D%0A
