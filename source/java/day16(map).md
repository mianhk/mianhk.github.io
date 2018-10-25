---
title: day5(面向对象2)
date: 2017-03-09 12:55:17
categories: Java
tags: java
---
# 集合(MAP)
## Map集合：该集合存储键值对。一对一对往里存。而且要保证键的唯一性。
1. 添加。
2. 删除。clear()
3. 判断。
4. 获取。
Map：Hashtable：底层是哈希表数据结构，不能存入null键null值，是线程同步的。
  HashMap:底层是哈希表数据结构，允许使用null键null值，该集合是不同步的。
 TreeMap：底层是二叉树数据结构。线程不同步。可以用于给map集合中的键进行排序。--和Set很像，其实Set底层就是使用了Map集合。
## Map子类对象的特点
## Map共性方法
## Map-keySet
map集合的两种取出方式：
1. keySet：将map中所有的键存入到set集合。因为set具备迭代器。所有可以迭代方式取出所有的键，在根据get方法。获取每一个键对应的值。
2. entrySet
Set<Map.Entry<K,V>> entrySet:将Map集合中的映射关系存入了set集合中，而这个关系的数据类型就是：Map.entry。其实Entry也是一个借口，它是Map接口中的一个内部接口。
## Map练习
当发现有映射关系时，可以选择map集合。因为map集合中存放的就是映射关系。
什么时候使用map集合？当数据之间存在映射关系时，就要先想map集合
##map扩展知识
map集合被使用是因为具备映射关系。
