---
title: 我的hexo折腾笔记
date: 2017-09-10 00:24:59
updates: 2017-11-18 00:25:59
categories: 工具
tags: [工具,博客]
---

### 我的hexo折腾笔记--记录一下折腾的过程
> 没错，这几天又开始折腾一下博客了，最近的节奏天天白天待在实验室怼论文，晚上看C++，时间安排比较紧凑，就觉得更需要阶段性的总结吧，所以又来写博客了，github始终是一个好的选择，于是入了Hexo的坑。。折腾的过程心情总是有些复杂，在激动和mmp之间徘徊，虽然很多问题在wiki和issue里都有，但还是想总结一下自己亲自踩的坑。

<!--more-->
##### 图床修改
由于以前都是直接使用的github私人仓库做的图床，但是有时候就是访问不到，因为博客是采用双部署的，可能coding上的已经是外链了被屏蔽了，所以还是得想点别的办法了。  
看到网上说的各种，其实都还是有点问题，最终发现最近的腾讯对象存储，发现还真的可以。  
软件名：picgo  
链接：https://sspai.com/post/42310  
使用方法：https://github.com/Molunerfinn/PicGo/wiki/%E8%AF%A6%E7%BB%86%E7%AA%97%E5%8F%A3%E7%9A%84%E4%BD%BF%E7%94%A8#v5%E7%89%88%E6%9C%AC%E8%AF%B4%E6%98%8E  
##### Next主题个性化之自动更换背景图片
https://blog.csdn.net/mango_haoming/article/details/78473243
##### 修改主题：yilia（已取消）
https://github.com/litten/hexo-theme-yilia
##### 2018-4-22 加入畅言评论（已取消）
详见：https://blog.csdn.net/lcyaiym/article/details/76762074

##### 2018-4-10 加入豆瓣读书和电影
详细见：https://github.com/mythsman/hexo-douban

##### 页面中文无法显示的问题
这种中文问题，基本上都是编码的问题，但是开始各种都没找到原因，改了language里面的配置文件，最后发现是文件的编码，需要改成'无bom的utf-8的编码格式 '
##### 主界面无法显示categories和tags的问题
这个问题真的是搞的有点久，因为基本上都被人忽略了，也可能很多人都没遇到而我恰好遇到了吧，不懂前端的我只能对于这种玄学问题强行百度了。
解决办法：将categories和tags目录下的index文件分别改成：
```
categories:
type: "categories"
layout: "categories"
tags:
type: "tags"
layout: "tags"
```

折腾完又不早了，希望以后好好看书，好好编程吧，最近没有什么特别大的梦想，只想安静的学习。。。

##### 绑定gitpages到自己的域名
打开[学生包](https://education.github.com/)，通过教育邮箱申请之后，可以在package中找到那么namecheap，注册通过GitHub进入，可以直接申请域名，会自动绑定到我们的gitpage，不过还需要一点点修改，就是把cname的www改成我们的gitpage页面，就可以了。。
##### 采用coding和gitpages双部署
采用双部署的原因是国内访问github的速度有时候太感人了，有些人直接打不开，搞得有点尴尬，于是看到了网上所说的双部署，将默认的国内地址解析到coding的pages服务上，其他的绑定到gitpage上，这样国内的访问速度就快了。
具体的coding pages的搭建就不写了，在coding网站中建好仓库后，在我们本地的config文件后面的push repository 加上coding page仓库的地址就可以了。
具体的cname记录和A记录如下图：
[]()
** Reference: **
[Hexo文档](https://hexo.io/zh-cn/docs/)
[Next主题文档](http://theme-next.iissnan.com/getting-started.html)
[绑定到coding](http://blog.csdn.net/dengnanyi/article/details/53969684)
