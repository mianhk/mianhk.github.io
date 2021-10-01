+++
title = "使用gitpage+Hexo搭建自己的博客"
date = "2017-05-31T08:55:29+08:00"
categories = ["工具"]
toc = true
description = ""
+++

----------
## 如今，各种博客网站都可以让我们随意的写作，但是很多的选择也让我们有时候不知道该怎么选择，而且作为喜欢折腾的程序员来说，自己搭建属于自己的博客当然是一个很好的选择了。可以将文件保存在本地，随时换自己的风格，备份，做一些diy的调整。
<!-- more -->
**摘自：https://xuanwo.org/2015/03/26/hexo-intor/ **写的很详细了，就不仔细写一遍了，就当个记录吧，以后出问题了好解决一点。

## 一、准备工作，准备需要准备好以下软件：
```
   Node.js环境
   Git
```
### 1.Windows配置Node.js环境下载Node.js安装文件：
```
    Windows Installer 32-bit
    Windows Installer 64-bit
```
- 根据自己的Windows版本选择相应的安装文件。
![](https://xuanwo.org/imgs/opinion/Nodejs-install.png)

- 保持默认设置即可，一路Next，安装很快就结束了。 然后我们检查一下是不是要求的组件都安装好了，同时按下Win和R，打开运行窗口：
![](http://upload-images.jianshu.io/upload_images/6054281-bc2e6deb5f394f93.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
- 在新打开的窗口中输入cmd，敲击回车，打开命令行界面。（下文将直接用打开命令行来表示以上操作，记住哦~） 在打开的命令行界面中，输入
```
node -v
npm -v
```

如果结果如下图所示，则说明安装正确，可以进行下一步了，如果不正确，则需要回头检查自己的安装过程。
(https://xuanwo.org/imgs/opinion/Nodejs-test.png)

### 2.配置Git环境下载Git安装文件：
[Git-2.6.3-64-bit.exe](https://github.com/git-for-windows/git/releases/download/v2.6.3.windows.1/Git-2.6.3-64-bit.exe)

然后就进入了Git的安装界面，如图：
![](https://xuanwo.org/imgs/opinion/Git-install.png)
和Node.js一样，大部分设置都只需要保持默认，但是出于我们操作方便考虑，建议PATH选项按照下图选择：
![](https://xuanwo.org/imgs/opinion/Git-path-setting.png)
> 这是对上图的解释，不需要了解请直接跳过 Git的默认设置下，出于安全考虑，只有在Git Bash中才能进行Git的相关操作。按照上图进行的选择，将会使得Git安装程序在系统PATH中加入Git的相关路径，使得你可以在CMD界面下调用Git，不用打开Git Bash了。

一样的，我们来检查一下Git是不是安装正确了，打开命令行，输入：
```
    git --version
```
如果结果如下图所示，则说明安装正确，可以进行下一步了，如果不正确，则需要回头检查自己的安装过程。
![](https://xuanwo.org/imgs/opinion/Git-test.png)

## 二、新建仓库
### 1.打开https://github.com/，在下图的框中，分别输入自己的用户名，邮箱，密码。

### 2.创建代码库登陆之后，点击页面右上角的加号，选择New repository：
进入代码库创建页面：
在Repository name下填写yourname.github.io，Description (optional)下填写一些简单的描述（不写也没有关系），如图所示：
![](https://xuanwo.org/imgs/opinion/Github-new-repo-setting.png)
正确创建之后，你将会看到如下界面：
![](https://xuanwo.org/imgs/opinion/Github-new-repo-look-like.png)
开启gh-pages功能点击界面右侧的Settings，你将会打开这个库的setting页面，向下拖动，直到看见GitHub Pages，如图：
![](https://xuanwo.org/imgs/opinion/Github-pages.png)
点击Automatic page generator，Github将会自动替你创建出一个gh-pages的页面。 如果你的配置没有问题，那么大约15分钟之后，yourname.github.io这个网址就可以正常访问了~ 如果yourname.github.io已经可以正常访问了，那么Github一侧的配置已经全部结束了。
配置Hexo安装Hexo在自己认为合适的地方创建一个文件夹，然后在文件夹空白处按住Shift+鼠标右键，然后点击在此处打开命令行窗口。（同样要记住啦，下文中会使用在当前目录打开命令行来代指上述的操作）
在命令行中输入：
`
npm install hexo-cli -g
`
然后你将会看到:
![](https://xuanwo.org/imgs/opinion/npm-install-hexo-cli.png)
可能你会看到一个WARN，但是不用担心，这不会影响你的正常使用。 然后输入
`npm install hexo --save`

然后你会看到命令行窗口刷了一大堆白字，下面我们来看一看Hexo是不是已经安装好了。 在命令行中输入：
`hexo -v`

如果你看到了如图文字，则说明已经安装成功了。
![](https://xuanwo.org/imgs/opinion/hexo-v.png)
初始化Hexo接着上面的操作，输入：
`hexo init`

如图：
![](https://xuanwo.org/imgs/opinion/hexo-init.png)
然后输入：
`npm install`


之后npm将会自动安装你需要的组件，只需要等待npm操作即可。

## 首次体验Hexo
继续操作，同样是在命令行中，输入：
`hexo g`

如图：
![](https://xuanwo.org/imgs/opinion/hexo-g.png)
然后输入：
`hexo s`

然后会提示：
`INFO  Hexo is running at http://0.0.0.0:4000/. Press Ctrl+C to stop.`

在浏览器中打开`http://localhost:4000/`，你将会看到：
![](https://xuanwo.org/imgs/opinion/hexo-first-time.png)
到目前为止，Hexo在本地的配置已经全都结束了。

## 使用Hexo
> 在配置过程中请使用yamllint来保证自己的yaml语法正确
修改全局配置文件此段落引用自[Hexo官方文档](https://hexo.io/zh-cn/docs/configuration.html)
您可以在 _config.yml 中修改大部份的配置。
### 网站
参数 | 描述
title | 网站标题
subtitle | 网站副标题
description | 网站描述
author | 您的名字
language | 网站使用的语言
timezone | 网站时区。Hexo 默认使用您电脑的时区。时区列表。比如说：America/New_York, Japan, 和 UTC 。
### 网址
参数 | 描述 | 默认值
--|--|--
url | 网址
root | 网站根目录 | permalink文章的 永久链接 格式:year/:month/:day/:title/permalink_default永久链接中各部分的默认值 如果您的网站存放在子目录中，例如 http://yoursite.com/blog，则请将您的 url 设为 http://yoursite.com/blog 并把 root 设为 /blog/。
目录参数描述默认值source_dir资源文件夹，这个文件夹用来存放内容。sourcepublic_dir公共文件夹，这个文件夹用于存放生成的站点文件。publictag_dir标签文件夹tagsarchive_dir归档文件夹archivescategory_dir分类文件夹categoriescode_dirInclude code 文件夹`downloads/codei18n_dir国际化（i18n）文件夹:langskip_render跳过指定文件的渲染，您可使用 glob 表达式来匹配路径。 文章参数描述默认值new_post_name新文章的文件名称:title.mddefault_layout预设布局postauto_spacing在中文和英文之间加入空格falsetitlecase把标题转换为 title casefalseexternal_link在新标签中打开链接truefilename_case把文件名称转换为 (1) 小写或 (2) 大写0render_drafts显示草稿falsepost_asset_folder启动 Asset 文件夹falserelative_link把链接改为与根目录的相对位址falsefuture显示未来的文章truehighlight代码块的设置 分类 & 标签参数描述默认值default_category默认分类uncategorizedcategory_map分类别名 tag_map标签别名 日期 / 时间格式Hexo 使用 Moment.js 来解析和显示时间。
参数描述默认值date_format日期格式MMM D YYYYtime_format时间格式H:mm:ss分页参数描述默认值per_page每页显示的文章量 (0 = 关闭分页功能)10pagination_dir分页目录page扩展参数描述theme当前主题名称。值为false时禁用主题deploy部署部分的设置配置Deployment首先，你需要为自己配置身份信息，打开命令行，然后输入：
```
git config --global user.name "yourname"
git config --global user.email "youremail"
```
同样在_config.yml文件中，找到Deployment，然后按照如下修改：
```
deploy:
  type: git
  repo: git@github.com:yourname/yourname.github.io.git
  branch: master
```
如果使用git方式进行部署，执行npm install hexo-deployer-git --save来安装所需的插件
然后在当前目录打开命令行，输入：
`hexo d`

随后按照提示，分别输入自己的Github账号用户名和密码，开始上传。 然后通过http://yourname.github.io/来访问自己刚刚上传的网站。
添加新文章打开Hexo目录下的source文件夹，所有的文章都会以md形式保存在_post文件夹中，只要在_post文件夹中新建md类型的文档，就能在执行hexo g的时候被渲染。 新建的文章头需要添加一些yml信息，如下所示：
```
title: hello-world   //在此处添加你的标题。
date: 2017-5-11 08:55:29   //在此处输入你编辑这篇文章的时间。
categories: Exercise   //在此处输入这篇文章的分类。
toc: true    //在此处设定是否开启目录，需要主题支持。
```

## 进阶
如果成功完成了上述的全部步骤，恭喜你，你已经搭建了一个最为简单且基础的博客。但是这个博客还非常简单， 没有个人的定制，操作也比较复杂，下面的进阶技巧将会让你获得对Hexo更为深入的了解。
更换主题可以在此处寻找自己喜欢的主题 下载所有的主题文件，保存到Hexo目录下的themes文件夹下。然后在_config.yml文件中修改：
### Extensions
#### Plugins: http://hexo.io/plugins/
#### Themes: http://hexo.io/themes/
theme: landscape //themes文件夹中对应文件夹的名称

然后先执行`hexo clean`，然后重新`hexo g`，并且`hexo d`，很快就能看到新主题的效果了~

~~更换域名首先，需要注册一个域名。在中国的话，.cn全都需要进行备案，如果不想备案的话，请注册别的顶级域名，可以使用godaddy或新网或万网中的任意一家，自己权衡价格即可。 然后，我们需要配置一下域名解析。推荐使用DNSPod的服务，比较稳定，解析速度比较快。在域名注册商出修改NS服务器地址为：~~
~~f1g1ns1.dnspod.net~~
~~f1g1ns2.dnspod.net~~

~~以新网为例，首先点击域名管理进入管理页面：~~

~~然后点击域名后面的管理：~~

~~进入域名管理的操作界面，点击域名管理，来到域名管理界面：~~

~~点击修改域名DNS，然后选择填写具体信息，在下面的空框中填入DNSPod的NS服务器：~~

~~然后我们进入DNSPod的界面，开始真正进入域名解析的配置= =。在DNSPod中，首先添加域名，然后分别添加如下条目：~~

~~最后，我们对Github进行一下配置。~~
~~在自己本地的hexo目录下的source文件夹中，新建一个CNAME文件（注意，没有后缀名。），内容为yourdomin.xxx。然后再执行一下hexo d -g，重新上传自己的博客。 在github中打开你自己的库，进入库的setting界面，如果看到了如下提示，说明配置成功了。~~

~~在这一系列的操作中，包括修改NS服务器，设置A解析等等，都需要一定的时间。短则10分钟，长则24小时，最长不会超过72小时。如果超过72小时，请检查自己的配置过程，或者修改自己本地的DNS服务器。~~

##绑定域名：
有一个简单的办法，当然只是现在作为拥有GitHub学生包才可以用的，打开[学生包](https://education.github.com/)，通过教育邮箱申请之后，可以在package中找到那么namecheap，注册通过GitHub进入，可以直接申请域名，会自动绑定到我们的gitpage，不过还需要一点点修改，就是把cname的www改成我们的gitpage页面，就可以了。。
