---
title: Linux修改用户名和所属组
date: 2018-01-17 19:48:22
categories: Linux
tags: [Linux,后台开发]
---
### Linux修改用户名和所属组

腾讯云的云服务器的，初始的用户名和主机名都是分配的。主机名其实还好了，用户名总是一个ubuntu有点看的不爽，正好看到了用户管理，就在这准备改一下，mianhk显然是一个更好一点的选择是吧。__^ _ ^_

#### 更改用户名
##### 修改sudoers文件
因为之后的操作，直接进入root用户操作。
将要改的名字提前赋予较高的权限，防止修改下面文件的过程中出现权限不足的问题
```
vi /etc/sudoers
```
![](https://github.com/mianhk/image-save/blob/master/Linux/001/001.jpg?raw=true)

##### 修改shadow文件
shadow文件存储与登陆有关的内容，格式如下：
username: passwd: lastchg: min: max: warn: inactive: expire: flag
登录名:加密口令:最后一次修改时间:最小时间间隔:最大时间间隔:
警告时间:不活动时间:失效时间:标志
```
vi /etc/shadow
```
![](https://github.com/mianhk/image-save/blob/master/Linux/001/002.jpg?raw=true)

##### 修改开始目录
每个用户都有一个家目录，远程登录的时候就会进入家目录。包含用户相关配置信息,例如：![](https://github.com/mianhk/image-save/blob/master/Linux/001/003.jpg?raw=true)
现在直接将这个家目录修改就好了。
```
mv ubuntu mianhk  # ubuntu 原来的目录
```

##### 修改passwd文件
passwd的文件格式是：
用户名: 密码 : uid  : gid :用户描述：主目录：登陆shell
需要将用户描述和主目录都改成新的，不然无法读取
```
vi /etc/passwd
```
![](https://github.com/mianhk/image-save/blob/master/Linux/001/004.jpg?raw=true)

##### 修改所属组
其实这里的修改，只需要将所有原来的ubuntu所属的组替换为mianhk即可。
```
vi /etc/group
```
![](https://github.com/mianhk/image-save/blob/master/Linux/001/005.jpg?raw=true)

##### 删除ubuntu
再次进入/etc/sudoers 中，讲ubuntu删除
##### 重启
　

