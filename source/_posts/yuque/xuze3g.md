---
title: Python进阶
urlname: xuze3g
date: 2020-09-02 11:27:21 +0800
tags: [Python,学习]
categories: [学,习]
---

# 常见数据结构

## 集合

跟其他语言的 set 一样，集合是无重复元素的且无序的，显然底层是 hash 存储，对 set 中的元素增加和查找都是 O(1)。因此不要随便使用 pop()方法。

```python
a = {1,2,3} # 定义
a.add(4) # 增加元素
a.remove(2) # 删除元素
sorted(a) # 对set排序
```
