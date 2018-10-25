---
title: ubuntu自动push到github脚本
date: 2018-05-24 20:20:43
updates: 2018-05-24 20:20:46
categories: 工具
tags: 工具
---
> 由于人比较懒，总是忘了自己提交到github上，也觉得博客好不容易写了还要打开文件夹，点一下交，这个体验有点差呀。于是就写了个Linux自动提交代码的和windows自动更新博客的。

<!--more-->

## Linux编写shell脚本
### 脚本代码
```
#!/bin/bash

path=~/github/

git_push(){
    echo "开始push"
    modify_time=`stat -c %Y ${1}`
    this_time=`date +%s`

    cd ${1}
    echo "-------切换目录------"
    echo `pwd`
    echo "---------------------"
    if [ $[ ${modify_time}-${this_time} ] -gt 86400 ];
    then
         echo "${1} 文件夹 有变化，正在准备push..."
        date=`date "+%Y-%m-%d %H:%M:%S"`
        git add .    
        git commit -m "automatic push @$(date)"
        echo "git fetch origin master"
        git fetch origin master

        echo "git merge origin/master"
        git merge origin/master

        echo "git push origin master:master"
        git push origin master:master
         
    fi
}

git_push ~/github/Linux_pro
git_push ~/github/miniweb

```


### 加入定时任务
### 编辑定时任务文件
(https://blog.csdn.net/xiyuan1999/article/details/8160998)
`crontab  -e`
在文件的末尾添加：
```
30 5 * * * /home/mianhk/shell/auto_push.sh  表示在每天的 5.30执行
```

### 启动服务
`/etc/init.d/cron start`

## Windows自动提交博客
其实windows的也差不多，写一个bat的脚本，然后加到系统的定时任务里面
### 代码如下
```

title 同步博客到远端——余国聪
color 16

echo;
echo;

echo 切换目录到blog
f:
cd \github\mianhk
cd .\blog
echo clean

hexo g -d

echo 切换到GitHub备份目录
cd ..

echo 开始提交代码到本地仓库
echo 当前目录是：%cd%

echo 开始添加变更
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
git add -A .
echo 执行结束！
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

echo;
echo 提交变更到本地仓库
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
set declation=%date:~0,4%%date:~5,2%%date:~8,2%
git commit -m "%declation%同步博客"
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

echo;
echo 将变更情况提交到远程git服务器
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
git push origin master
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

echo;
echo 批处理执行完毕！
echo;

pause
```

### 添加到自动任务
计算机->管理->任务计划程序->添加任务即可  


我的博客即将搬运同步至腾讯云+社区，邀请大家一同入驻：https://cloud.tencent.com/developer/support-plan?invite_code=174pin6hqb074
