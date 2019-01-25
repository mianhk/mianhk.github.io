
title: git同步含有git的文件夹及问题解决
date: 2018-12-29 11:27:21 +0800
tags: [git]
categories: 工具
---

同步含有git的文件夹真的有点烦，由于没有注意同步结果，只是一直在看travis构建结果，结果半天没有发现问题，后来发现了也不知道怎么解决，看远程仓库的代码是一个关联的文件夹形式，表示这是一个git的文件夹，但是点不开，本地的也没有上传。  
<!--more-->

# <a name="hqeqeb"></a>首先删除.git文件
# <a name="ot75aa"></a>删除git缓存
```bash
git rm --cached directory
git add directory
```
详细见[Stack Overflow](https://stackoverflow.com/questions/24472596/git-fatal-pathspec-is-in-submodule) 的解释，当然是要首先把文件夹删掉，然后重新add。  
# <a name="7ntczy"></a>小总结
已经不是第一次出现这种问题了，但是上次依然没有发现，还是记录一下吧。


