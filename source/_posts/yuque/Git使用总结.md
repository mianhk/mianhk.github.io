---
title: 【Git】Git使用总结
urlname: htwhzf
date: 2019-05-26 10:24:53
tags: []
categories: []
---

## 配置 user 信息

```
git config --global user.name 'your_name'
git config --global user.email 'your_email'

git config --local  #local只对某个仓库有效
git config --global  #global对当前用户的所有仓库有效
git config --system  #对系统所有登录用户有效，一般不用没什么意义

git config --global --list #显示配置项
```

local 比 global 优先级要高

# 给文件重命名

```git
#原来的使用：
mv readme readme.md
git add readme.md
git rm readme
#直接使用
git mv readme readme.md
```

# 查看 gitlog

```git
git log #只显示当前分支
git log --all --graph #可以看所有的分支
git log --oneline --all -n4 #一行显示所有分支最近的4个
```

# .git 目录

HEAD：整个仓库正在工作的分支
config：存放仓库本地的配置信息，记录 user 等信息
refs：
objects：包括文件夹和 pack

# commit、tree 和 blob 之间的关系

![image.png](https://cdn.nlark.com/yuque/0/2019/png/187932/1558841650988-46fcccb5-6359-4112-8808-e60284941018.png#align=left&display=inline&height=681&margin=%5Bobject%20Object%5D&name=image.png&originHeight=681&originWidth=1132&size=170368&status=done&style=none&width=1132)
一个 commit 对应一棵 tree，每个文件夹对应一个 tree

# 分离头指针

表示某个变更没有基于某个 branch，在切换分支的时候，这些变更很有可能会被 git 当做垃圾清理，所以如果认为这些变更有用的话，一定要与某个 branch 绑定才能得到保留。

# HEAD 和 branch

切换分支时，HEAD 指向会发生变化。

```git
git diff HEAD HEAD^  #与上一次HEAD比较
git diff HEAD HEAD^^ #与上上次进行比较
git diff HEAD HEAD^3 #与上上上次进行比较
```

# 常用场景

## 删除分支

```git
git branch -d '分支名'  #清除分支的命令
git branch -D '分支名'  #确信清除没有影响，采用D清除
```

## 修改 commit 的 message

在维护自己的分支的时候，还没有提交的时候

```git
git commit --amend   #修改最新的commit的message
git rebase -i 'commit id'  #修改更久的commit的message
  然后按照提示进行修改
```

## 整理多个 commit 为 1 个

```git
git rebase -i 'commit-id'  # commit-id为最久的想合并的
```

## 比较暂存区和 HEAD 所含文件的差异

```git
git diff --cached  #表示暂存区和HEAD的区别
```

## 比较工作区和暂存区的区别

```git
git diff #默认比较的是工作区和暂存区的区别
git diff --文件名 #比较文件
```

## 让暂存区恢复成和 HEAD 一样

```git
git reset HEAD #将暂存区所有的变更恢复成HEAD
```

## 工作区的文件恢复成暂存区一样

```git
git checkout -- '文件名'
```

## 取消暂存区部分文件的修改

```git
git reset HEAD --'文件名'  # 将暂存区某一文件恢复成HEAD
```

## 消除最近的几次提交

```git
git reset --hard 'commit-id' #慎用
```

## 看不同提交的指定文件的差异

```git
git diff 'branch1' 'branch2' -- '文件名'
git diff 'commit-id1' 'commit-id2' -- '文件名'
```

## 正确删除文件的方法

```git
git rm '文件名'
```

## 开发临时加塞紧急任务处理方式

```git
git stash
git stash apply
或者 git stach pop  #两者区别是会丢掉
```

## Git 的备份

- 哑协议：不显示进度条
- 智能协议：

# Tips
## 同步含有git的文件夹及问题解决
同步含有 git 的文件夹真的有点烦，由于没有注意同步结果，只是一直在看 travis 构建结果，结果半天没有发现问题，后来发现了也不知道怎么解决，看远程仓库的代码是一个关联的文件夹形式，表示这是一个 git 的文件夹，但是点不开，本地的也没有上传。