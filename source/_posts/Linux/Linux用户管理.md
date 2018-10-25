---
title: Linux用户管理
date: 2018-01-23 21:04:16
categories: Linux
tags: [Linux,后台开发]
---
### Linux账户管理
#### 新建账户（ubuntu）
新建账户比较简单
```
useradd mianhk1  #mianhk1为账户名
```
之后可以在三个文件夹看到新账户的信息：
![](https://github.com/mianhk/image-save/blob/master/Linux/002/001.jpg?raw=true)
此时可以看到，shadow文件中，第二个存密码的位置是一个!,此时新建的账户还没有密码，当然也可以看到home目录下没有mianhk1的文件夹，此时需要先改密码。

```
passwd mianhk1 #修改密码
```
![](https://github.com/mianhk/image-save/blob/master/Linux/002/002.jpg?raw=true)
这时候就能看到shadow文件中保存的密码了，同时，也能在home目录下看到miahk1的文件夹了。但是此时切换到mianhk1账户时，看到的仍然是：
```
mianhk1@VM-95-58-ubuntu:/home$ ls
mianhk  mianhk1
bash: history: /home/mianhk1/.bash_history: cannot create: Permission denied
bash: history: /home/mianhk1/.bash_history: cannot create: Permission denied
bash: history: /home/mianhk1/.bash_history: cannot create: Permission denied
```
这个原因其实是无法建立bash的一些文件，原因在上图中可以看到，因为我们没有指定系统的默认bash。通过修改之后，添加默认的bash还是出现了下列的问题：
```

[sudo] password for mianhk1:
mianhk1 is not in the sudoers file.  This incident will be reported.
bash: history: /home/mianhk1/.bash_history: cannot create: Permission denied
bash: history: /home/mianhk1/.bash_history: cannot create: Permission denied
bash: history: /home/mianhk1/.bash_history: cannot create: Permission denied
bash: history: /home/mianhk1/.bash_history: cannot create: Permission denied
bash: history: /home/mianhk1/.bash_history: cannot create: Permission denied

```

原因还没有权限，用root用户看了一下，发现原来mianhk1的所有者原来是root用户，直接修改拥有者和用户权限吧：
```
chown mianhk1 mianhk1  #修改拥有者用户
chgrp mianhk1 mianhk1  #修改拥有组
chmod +040 mianhk1     #修改文件夹权限
```
之后可以通过命令查看生成的账户的信息了：
```
root@VM-95-58-ubuntu:/home# useradd -D
GROUP=100           #用户组
HOME=/home          #用户家目录的位置
INACTIVE=-1         #密码失效日，在 shadow 内的第 7 栏
EXPIRE=             #账号失效日，在 shadow 内的第 8 栏
SHELL=/bin/sh       #预设的shell
SKEL=/etc/skel      #用户家目录的内容数据参考目录
CREATE_MAIL_SPOOL=no#是否主动帮使用者建立邮件信箱(mailbox)

```
之后看了一下centos的，发现根本直接新建就好使了啊，__^_^__尴尬

中间还出了个很尴尬的事情，一不小心删了/etc/passwd 文件。。
没事，想想这么重要的文件肯定会有备份的，果然是：
```
cp /etc/passwd- /etc/passwd
```


#### 删除账户
```
deluser mianhk1  #mianhk1 为账户的名字
```
