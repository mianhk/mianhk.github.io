---
title: day5(面向对象2)
date: 2017-03-09 12:55:17
categories: Java
tags: java
---
# 集合类

----------
## 集合框架（体系概述）
为什么出现集合类？
数组是固定长度的，集合是可变长度的。
为什么出现这么多的容器？
因为每一个容器对数据的存储方式都有不同。这个存储方式称之为：数据结构。
##集合框架（共性方法）
## 迭代器
什么是迭代器？
其实就是集合中元素的取出方式。
把取出方式定义在集合的内部，这样取出方式就可以直接访问集合内容的元素。那么取出方式就被定义成了内部类。而每一个容器的结构数据不同，所以取出的动作细节也不一样。但是都有共性内容：判断和取出。那么可以将这些共性抽取。
## List
### List集合共性方法
List：元素是有序的，元素可以重复，因为该集合体系有索引。
Set：元素是无序的，不能重复。
List：特有方法：凡是可以操作角标的方法都是该体系特有的方法。
增：add addAll
删： remove
改：set
查：get subList listIterator
### ListIterator
在迭代器时，只能用迭代器的方法操作元素，可是Iterator方法是有限的，只能对元素进行判断，取出，删除的操作，如果想要其他的操作如添加，修改等，就需要使用其子接口，ListIterator。
该接口只能通过List集合的ListIterator方法获取。
### List集合具体对象的特点
List：
ArrayList：底层的数据结构使用的是数组，查找很快，但是增删稍慢 （可变长度的）
Linkedlist：底层使用的是链表数据结构。特点是增删速度很快，查询稍慢
Vector：底层是数组数据结构。线程同步，被ArrayList替代了 ，现在一般不用了。枚举是Vector特有的取出方式。发现枚举和迭代器很像。其实枚举和迭代是一样的。因为枚举的名称以及方法的名称都过长。所以被迭代器取代了。
### LinkedList
LinkedList特有方法：addFirst(),addLast(),getFirst(),getLast(),removeFirst(),removeLast()
JDK1.6出现了替代方法。
offerFriest  peekFirst poolFirst
堆栈：先进后出
队列： 先进先出 FIFO
List集合判断元素是否相同，依据的是元素的equals方法。
##set
set：元素是无序（存入和取出的顺序不一定一致）
set集合的功能和collection是一致的。
HashSet：底层数据结构是哈希表。HashSet是如何保证元素的唯一性的呢？是通过元素的两个方法。hashCode和equals来完成。如果元素的HashCode值相同，才会判断equals是否为true，如果元素的hashCode不同，不会判断equals。
注意：对于判断元素是否存在，以及删除等操作，依赖的方法是元素的hashcode和equals方法。
