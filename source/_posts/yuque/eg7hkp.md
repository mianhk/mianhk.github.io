
title: 使用语雀编辑器写静态博客
date: 2018-11-14 22:27:10 +0800
tags: [Hexo,折腾,语雀]
categories: 工具
---
> 本来以为已经是最后一次折腾了，但是总是生活不停，折腾不止，觉得本地文件管起来还是有点麻烦，看到语雀markdown又做的这么好，前几天还准备拿它当云笔记用，但是据说底层存的都是md格式，有的时候又还是不太方便，不过做编辑器来说确实很爽了，自带图床，还有github上开源的一个接口。   

<!--more-->

# <a name="s7pfan"></a>准备工作
## <a name="p3r4ex"></a>更新node.js和npm
刚刚来就是坑，不过还是准备从正常的步骤开始说吧，就是博客基于的是nodejs，很多包的安装都是采用npm统一管理的，因为有些插件需要使用新的版本，所以需要先更新一下，这里只说一下windows下面的操作。
### <a name="p7w2ix"></a>更新node.js
window下并没有网上说的乱七八糟的命令行更新方式，直接在[官网](http://nodejs.cn/)下载最新的安装包就可以。然后安装在之前的位置进行覆盖就可以更新了。更新之后通过命令:
```git
$node -v
v10.13.0
```
### <a name="85nlcu"></a>更新npm
通过命令：
```git
$npm install -g npm

#更新后的版本可以看到
$npm -v
6.4.1
```
### <a name="wng1dw"></a>更新包
可以使用命令查看可以更新的包:
```git
$npm outdated         #查看需要更新的包：
Package                 Current  Wanted  Latest  Location
hexo-helper-live2d      MISSING   3.1.0   3.1.0  hexo-site
hexo                      3.3.9   3.8.0   3.8.0  hexo-site
hexo-douban              0.2.14  0.2.16   1.0.6  hexo-site
hexo-generator-archive    0.1.4   0.1.5   0.1.5  hexo-site
hexo-generator-search     2.2.5   2.3.0   2.3.0  hexo-site
hexo-renderer-ejs         0.2.0   0.2.0   0.3.1  hexo-site
hexo-renderer-marked     0.2.11  0.2.11   0.3.2  hexo-site
hexo-server               0.2.2   0.2.2   0.3.3  hexo-site
$npm install --save  #
```
之后修改`package.json`文件，修改到对应的版本。然后执行命令，进行更新：
```plain
$npm install --save 
```
## <a name="安装语雀文章下载插件"></a>安装语雀文章下载插件
首先这里鸣谢开源的插件：[[yuque-hexo](https://github.com/x-cold/yuque-hexo)](https://github.com/x-cold/yuque-hexo)，通过工具可以将语雀知识库中的文件同步到本地，大部分功能和步骤在仓库中都有些，但是自己做的时候还是踩了坑，这里就还是写一下吧。
### <a name="z8p4qn"></a>1.创建语雀知识库
打开[语雀](https://www.yuque.com/) 创建自己的博客知识库，并且要__设置成公开的。可以在设置中看到链接如下：__


![image.png | center | 375x247](https://cdn.nlark.com/yuque/0/2018/png/187932/1542204775155-271c9311-4643-4ccd-8692-24ab7351e0cb.png "")

同时打开[blog知识库](https://www.yuque.com/mianhk/gaqqwc):[https://www.yuque.com/mianhk/gaqqwc](https://www.yuque.com/mianhk/gaqqwc)可以打开知识库。
### <a name="p1gbwg"></a>2.在本地安装<span data-type="color" style="color:rgb(74, 74, 74)"><span data-type="background" style="background-color:rgb(255, 255, 255)">yuque-hexo</span></span>
```git
npm i -g yuque-hexo
```
### <a name="2nybfh"></a>3.配置package.json
```plain
  "scripts": {
    "clean": "npm run clean:yuque && hexo clean",
    "clean:yuque": "DEBUG=yuque-hexo.* yuque-hexo clean",
    "deploy": "hexo deploy",
    "publish": "npm run clean && npm run deploy",
    "dev": "hexo s",
    "sync": "DEBUG=yuque-hexo.* yuque-hexo sync",
    "reset": "npm run clean:yuque && npm run sync"
  },   
  "yuqueConfig": {
    "baseUrl": "https://www.yuque.com/api/v2",    #这是语雀的永久链接，直接复制就可以
    "login": "mianhk",                      #用户名，上个链接的第一个下划线
    "repo": "gaqqwc",                      #知识库链接，第二个下划线
    "mdNameFormat": "slug",               #导出本地的文件名为随机的数字，比直接的中文title要好看，
                                                可以直接用了
    "postPath": "source/_posts/yuque"     #存在本地文件夹的位置
  }
```

### <a name="0rl2so"></a>4.删除和同步文章
```plain
#删除文章
$yuque-clean
[INFO] yuque-hexo clean start.
[INFO] remove yuque posts: F:\blog\mianhk.github.io\source\_posts\yuque\
[INFO] remove yuque local file: F:\blog\mianhk.github.io\yuque.json
[INFO] yuque-hexo clean finished.

#同步文章
$yuque-hexo sync
[INFO] yuque-hexo sync start.
[INFO] remove yuque posts: F:\blog\mianhk.github.io\source\_posts\yuque\
[INFO] loading config: F:\blog\mianhk.github.io\package.json
[INFO] downloading articles: {"baseUrl":"https://www.yuque.com/api/v2","login":"mianhk","repo":"gaqqwc","mdNameFormat":"slug","postPath":"source/_posts/yuque"}
[INFO] reading from local file: F:\blog\mianhk.github.io\yuque.json
[INFO] download article body: 11月生活小结
[INFO] download articls done!
[INFO] writing to local file: F:\blog\mianhk.github.io\yuque.json
[INFO] create posts director (if it not exists): F:\blog\mianhk.github.io\source\_posts\yuque
[INFO] generate post file: F:\blog\mianhk.github.io\source\_posts\yuque\xzxhcv.md
[INFO] yuque-hexo sync finished.

```

### <a name="enltgy"></a>5.修改文章的title和tag等
还是跟之前的格式直接写即可。
```makedown
title:  
date: 
update: 
categories: 
tags: []
```

### <a name="974chn"></a>6.部署博客

# <a name="mzmxge"></a>记录一些坑

* 知识库一定要是公开的
* windows下更新nodejs不能用n，即使强制使用了也还是无法更新
* 新版本的npm。<span data-type="color" style="color:rgb(26, 26, 26)"><span data-type="background" style="background-color:rgb(255, 255, 255)">如果改了package.json，且package.json和lock文件不同，那么执行`npm i`时npm会根据package中的版本号以及语义含义去下载最新的包，并更新至lock。</span></span>


## <a name="vpz7ep"></a>Reference:
* [https://github.com/x-cold/yuque-hexo](https://github.com/x-cold/yuque-hexo)
* [https://luan.ma/post/yuque2blog/](https://luan.ma/post/yuque2blog/)
* [https://www.zhihu.com/question/62331583](https://www.zhihu.com/question/62331583)
* [将 Hexo 升级到 v3.5.0](https://tommy.net.cn/2018/02/26/upgrade-hexo-to-v3-5-0/) 
* [Demo Json](https://github.com/x-cold/blog/blob/master/package.json#L26) 


