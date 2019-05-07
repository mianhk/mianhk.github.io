
title: MySQL学习总结2-表连接
date: 2019-01-23 20:23:55 +0800
tags: []
categories: 
---

title: MySQL学习总结2-表连接<br />date: 2019-1-16 11:27:21<br />categories: MySQL<br />tags: [MySQL,学习]

---

> 在关系型数据库里面，每个实体有自己的一张表，所有属性都是这张表的字段，表与表之间根据关联字段"连接"在一起。   


# 什么是连接
**两张表根据关联字段，组合成一个数据集。当两张表的关联字段不匹配时，例如表A和表B，处理方式为：**
* 只返回两张表匹配的记录，内连接（inner join）。
* 返回匹配的记录，以及表 A 多余的记录，左连接（left join）。
* 返回匹配的记录，以及表 B 多余的记录，右连接（right join）。
* 返回匹配的记录，以及表 A 和表 B 各自的多余记录，全连接（full join）。

这里看到了阮一峰老师的一个总结，引用了图片：<br />             ![](https://cdn.nlark.com/yuque/0/2019/jpeg/187932/1548247519305-bff75e42-9992-499e-9c1b-d75b9e56fe13.jpeg#align=left&display=inline&height=295&linkTarget=_blank&originHeight=295&originWidth=602&size=0&width=602)

# 内连接（inner join）
* MySQL默认的连接就是内连接，可以省略inner。
* 有条件的内连接：

where：数据过滤，理解上，数据交叉连接完成后再进行过滤。<br />on：在连接时，就对数据进行判断。<br />using：要求负责连接的两个实体之间的字段名称一致。<br />     在有同名字段时，使用using，通用条件时，使用on，在数据过滤时（不是连接的过滤）时，使用where。
# 外连接（outer join）
连接的数据不真实存在。意思是外连接的两个表，存在单个表中没有的数据。
## 左连接（left join）
在连接时，出现了左边表连接不到右边表的情况，则左边表的数据会被保留，而右边表的数据连接不到左表的情况，会被抛弃。
## 右连接（right join）
在连接时，出现了左边表连接不到右边表的情况，则数据会被抛弃，而右边表的数据连接不到左表的情况，会被保留。
## 全连接（full join）
