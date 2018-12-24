---
title: 我的hexo折腾笔记
date: 2017-09-10 00:24:59
updates: 2018-10-30 22:02:24
categories: 工具
tags: [工具,博客]
---

# 我的hexo折腾笔记--记录一下折腾的过程
> 没错，这几天又开始折腾一下博客了，最近的节奏天天白天待在实验室怼论文，晚上看C++，时间安排比较紧凑，就觉得更需要阶段性的总结吧，所以又来写博客了，github始终是一个好的选择，于是入了Hexo的坑。。折腾的过程心情总是有些复杂，在激动和mmp之间徘徊，虽然很多问题在wiki和issue里都有，但还是想总结一下自己亲自踩的坑。

<!--more-->

## 2018-12-24 
### 添加背景图片
使用插件jquery-backstretch，编辑文件`/themes/next/layout/_layout.swig`,将下面的代码添加到最后面body的前面:
```
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-backstretch/2.0.4/jquery.backstretch.min.js"></script>;
  <script>
  $("body").backstretch("http://blog-1252063226.cosbj.myqcloud.com/network/20181224194730.png");
  </script>

</body>
```
但是好像没有效果，于是在文件`themes\next\source\css_custom\custom.styl`中添加了如下：
```
body {
    background:url(https://source.unsplash.com/random/1600x900);
    background-repeat: no-repeat;
    background-attachment:fixed;
    background-position:50% 50%;
}

//修改背景的不透明度
.main-inner { 
    margin-top: 60px;
    padding: 60px 60px 60px 60px;
    background: #fff;
    opacity: 0.8;
    min-height: 500px;
}
```
### 使用hexo-neat进行压缩以增加页面速度
采用`hexo-neat`进行压缩，插件地址为：https://github.com/rozbo/hexo-neat，使用步骤为：
```
#安装hexo-neat
$ npm install hexo-neat --save
```

添加配置到根目录下的`_config.yml`，在最后加上(这里跟别人的有一些改动，因为有一些配置出了问题，找了很久，但是还是没有解决，干脆就不折腾了):
```
# hexo-neat
# 博文压缩
neat_enable: true
# 压缩html
neat_html:
  enable: true
  exclude:
    - '**/*.html'
# 压缩css  
neat_css:
  enable: true
  exclude:
    - '**/*.min.css'
# 压缩js
neat_js:
  enable: true
  mangle: true
  output:
  compress:
  exclude:
    - '**/*.min.js'
    - '**/jquery.fancybox.pack.js'
    - '**/index.js'
```
不用再做其他的改动，压缩前后的对比为：
<div align="center"> <img src="http://blog-1252063226.cosbj.myqcloud.com/network/TIM%E5%9B%BE%E7%89%8720181224194312.png" /> </div><br>
<div align="center"> <img src="http://blog-1252063226.cosbj.myqcloud.com/network/TIM%E6%88%AA%E5%9B%BE20181224194410.jpg" /> </div><br>
## 2018-10-30 17:28:33

##### 主页文章添加阴影效果
##### 在网站底部加上访问量
##### 添加热度
##### 网站底部字数统计
##### 修改``代码块自定义样式
打开`\themes\next\source\css\_custom\custom.styl`,向里面加入：(颜色可以自己定义):
```
// Custom styles.
code {
    color: #ff7600;
    background: #fbf7f8;
    margin: 2px;
}
// 大代码块的自定义样式
.highlight, pre {
    margin: 5px 0;
    padding: 5px;
    border-radius: 3px;
}
.highlight, code, pre {
    border: 1px solid #d6d6d6;
}
```

##### 添加访问量
打开`\themes\next\layout\_partials\footer.swig`文件,搜索`<div class="copyright">`，在这个`div`标签前边加上如下代码:
```
<script async src="https://dn-lbstatics.qbox.me/busuanzi/2.3/busuanzi.pure.mini.js"></script>
```
然后再在合适的位置添加如下代码，放在footer.swig文件的末尾:  
```
<div class="powered-by">
<i class="fa fa-user-md"></i><span id="busuanzi_container_site_uv">
  本站访客数:<span id="busuanzi_value_site_uv"></span>
</span>
</div>
```
##### 设置博文内链接为蓝色
通过路径：`themes\next\source\css\_common\components\post\`,打开`post.styl`文件，在文件中添加，如下字段：
```
 .post-body p a{
      color: #0593d3;
      border-bottom: none;
      &:hover {
        color: #0477ab;
        text-decoration: underline;
      }
    }
```

##### 设置文章末尾”本文结束”标记

##### 显示每篇文章字数

##### 文章末尾添加版权说明
直接修改`主题配置文件`，定位到`post_copyright`，将`enable`由`false`改为`true`即可。
```
# Declare license on posts
post_copyright:
  enable: true
  license: CC BY-NC-SA 3.0
  license_url: https://creativecommons.org/licenses/by-nc-sa/3.0/
```

##### 实现fork me on github
在右上角或者左上角实现fork me on github。  
点击[这里](https://blog.github.com/2008-12-19-github-ribbons/)挑选自己喜欢的样式，并复制代码。 例如，我是复制如下代码：
```
<a href="https://github.com/you"><img style="position: absolute; top: 0; left: 0; border: 0;" src="https://s3.amazonaws.com/github/ribbons/forkme_left_darkblue_121621.png" alt="Fork me on GitHub"></a>
```
粘贴刚才复制的代码到`themes/next/layout/_layout.swig`文件中(放在`<div class="headband"></div>`的下面)，并把`href`标签改为github地址：

##### 修改文章底部的#号标签
修改模板`/themes/next/layout/_macro/post.swig`，搜索 `rel="tag">#`，将其中的 `# `换成`<i class="fa fa-tag"></i>`

##### 添加搜索功能
安装 `hexo-generator-searchdb`，在站点的根目录下执行以下命令：
```
npm install hexo-generator-searchdb --save
```
编辑 `站点配置文件` （站点根目录下），新增以下内容到任意位置：  
```
search:
  path: search.xml
  field: post
  format: html
  limit: 10000
```
编辑 `主题配置文件` （主题目录下），启用本地搜索功能：
```
# Local search
local_search:
  enable: true
```

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
[Hexo搭建的GitHub博客之优化大全](https://zhuanlan.zhihu.com/p/33616481)
[解决 Travis CI 总是更新旧博客的问题](https://wafer.li/Hexo/%E8%A7%A3%E5%86%B3%20Travis%20CI%20%E6%80%BB%E6%98%AF%E6%9B%B4%E6%96%B0%E6%97%A7%E5%8D%9A%E5%AE%A2%E7%9A%84%E9%97%AE%E9%A2%98/)
[修改背景图片](http://www.tianguolangzi.com/2018/01/17/hexo%E4%B8%BB%E9%A2%98%E9%85%8D%E7%BD%AE/)
