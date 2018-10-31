---
title: Travis CI 自动部署博客
date: 2018-10-26 14:44:30
update: 2018-10-26 14:44:34
categories: 工具
tags: [博客,折腾]
---

> Hexo的又双叒一次折腾，以前觉得hexo部署博客还是很麻烦，除了每次操作完都得等待生成一下，还有的就是有时候很久一生成，都是看人品出错，以前也弄过那种自动的脚本，每天自己生成然后push，但是出错的时候就又是很麻烦。直到这次看到了Travis CI...   
   
   
<!--more-->
听到持续集成这个词还是最近逛github的时候，看到一些讨论才搜了一下这个，不过之前也是想过这个问题，毕竟有痛点就会想。之前折腾hexo博客的时候，试过在windows下面写个bat脚本，定时`hexo clean hexo g -d`一下，但是有时候文件太多搞乱了，就出问题了，一段时间没弄，就又得回来折腾。后面也试过就不在windows下面操作了，干脆只在博客文件夹弄，然后编辑器自动ftp到服务器上，再在服务器上自动生成，好像也没啥区别。直到看到Travis CI，才知道大佬们为啥都这么青睐hexo了。那就开整吧。   

# Travis思想

简单点就是，当我们的github公开仓库与Travis CI绑定后，在仓库中建立一个Travis CI`.travis.yml`文件，每当`.travis.yml`文件中监听的分支发现有变动时，会根据`.travis.yml`中的配置进行操作。   

# Github准备

首先是准备gitpages，仓库之前已经有了，这个是放生成的静态页面的，还有一个仓库，放的是博客的源码。之前的一般操作都是在源码博客中通过`hexo g -d`后push到gitpages目录中，所以大部分操作一般都是在这个源码中进行的，gitpages仓库是用来展示的，准确来说是gitpages仓库的master分支。  

由于Travis CI可以监听某个分支，所以这样一想，就不用弄两个仓库了，只需要弄两个分支即可：源码放在source分支，并又Travis CI监听，每次push后会自动push到master分支，完成博客的自动部署。  

Travis CI连接到仓库需要token才能操作，就相当于一把钥匙，可以在`Settings`->` Developer settings`->`Personal access tokens`->`Generate new token`,填写`Token description`，之后勾选`repo`，选择`generate token`。如图：
<div align="center"> <img src="http://blog-1252063226.cosbj.myqcloud.com/network/20181026151507.png" /> </div><br>

点击复制按钮复制`token`：
<div align="center"> <img src="http://blog-1252063226.cosbj.myqcloud.com/network/20181026151704.png" /> </div><br>

# Travis CI设置
## github账号登录
在[Travis CI网站](https://travis-ci.org/)通过github账号登录后，开启gitpages仓库的同步，然后点击`settings`进行设置。
<div align="center"> <img src="http://blog-1252063226.cosbj.myqcloud.com/network/20181026155513.png" /> </div><br>

## 通用设置和配置环境变量
之后开启设置，并设置环境变量(主要是为了travis的自动部署，但是token直接公开有风险，因此需要在这里设置):
<div align="center"> <img src="http://blog-1252063226.cosbj.myqcloud.com/network/20181026155627.png" /> </div><br>

# 在source分支创建`.travis.yml `文件
在gitpages仓库的source分支创建。这里涉及几个git的操作，真是坑踩多了，自然就会多用几个命令了。。   
   
## 拉取远程仓库并创建新分支
操作步骤为：
```
# 克隆项目到本地
> git clone git@github.com:mianhk/mianhk.github.io.git
# 创建并切换到source分支
> git checkout -b source
```
切换到source分支后，将本地除`.git`文件夹的其他文件删除，并将之前的源码文件拷贝到当前文件夹，然后提交到远程的source分支。
```
# 提交本地hexo分支到远程仓库的hexo分支
git push origin hexo:hexo
```

## 创建.travis.yml文件
当然这个文件网上一找一大堆，也不是我自己写的，参考：https://juejin.im/post/5a1fa30c6fb9a045263b5d2a  自己进行了一点修改：具体如下：
```
# 使用语言
language: node_js
# node版本
node_js: stable
# 设置只监听哪个分支
branches:
  only:
  - source
# 缓存，可以节省集成的时间，这里我用了yarn，如果不用可以删除
cache:
  apt: true
  directories:
    - node_modules
# tarvis生命周期执行顺序详见官网文档
before_install:
- export TZ='Asia/Shanghai' # 更改时区
- git config --global user.name "mianhk"
- git config --global user.email "gcyu@gmail.com"
# 由于使用了yarn，所以需要下载，如不用yarn这两行可以删除
#- curl -o- -L https://yarnpkg.com/install.sh | bash
#- export PATH=$HOME/.yarn/bin:$PATH
- npm install -g hexo-cli
install:
# 不用yarn的话这里改成 npm i 即可
#- yarn
- npm i
script:
- hexo clean
- hexo generate
after_success:
- cd ./public
- git init
- git add --all .
# commit 中间添加时间信息
- git commit -m "Travis CI Auto Builder at `date +"%Y-%m-%d %H:%M"`"  
# 这里的 REPO_TOKEN 即之前在 travis 项目的环境变量里添加的
- git push --quiet --force https://$REPO_TOKEN@github.com/mianhk/mianhk.github.io.git
  master

```

之后便可以通过在本地或者其他电脑上通过git在source分支上的操作实现自动部署了。  
<div align="center"> <img src="http://blog-1252063226.cosbj.myqcloud.com/network/20181026161116.png" /> </div><br> 

# 一些坑
一些拷贝文件产生的错误，导致中间出错了好几次，通过调整文件进行本地测试的时候，没有问题，但是自动构建就还是出问题。需要将原来的源码中的`config.yml`的push选项进行一下修改。

# Reference
[使用Travis CI自动部署Hexo博客](https://www.itfanr.cc/2017/08/09/using-travis-ci-automatic-deploy-hexo-blogs/)   
[Hexo遇上Travis-CI：可能是最通俗易懂的自动发布博客图文教程](https://juejin.im/post/5a1fa30c6fb9a045263b5d2a)  


