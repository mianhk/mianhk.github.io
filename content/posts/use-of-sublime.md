+++
title = "Sublime Text3使用总结"
date = "2018-04-24T20:43:43+08:00"
update = 2018-04-24T20:43:39Z
categories = "工具"
tags = ["工具", "折腾"]
description = ""
+++

   
update:
- 2018-04-24 首次更新:突然发现Sublime Text3也还是挺好用的，之前切出去光标总是乱跳，就有点烦，以为是这样的就没管，用了网易云，没想到发现只有我的是这样，赶紧找找问题，解决一下。顺便把很多重新折腾一下。

#用好sublime


### [为Sublime Text3添加插入当前时间的命令](https://www.cnblogs.com/jiafeimao-dabai/p/7238357.html)
1. 创建插件：

Tools → New Plugin:
```
import datetime
import sublime_plugin
class AddCurrentTimeCommand(sublime_plugin.TextCommand):
    def run(self, edit):
        self.view.run_command("insert_snippet", 
            {
                "contents": "%s" % datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S") 
            }
        )
```
保存为Sublime Text3\Packages\User\addCurrentTime.py

2. 创建快捷键：

Preference → Key Bindings - User:
```
[
    {
        "command": "add_current_time",
        "keys": [
            "ctrl+shift+."
        ]
    }
]
```
### [添加了一个主题]()https://packagecontrol.io/packages/Predawn：Predawn

### 其他链接
小土刀博客：http://wdxtub.com/2016/03/24/sublime-guide/

