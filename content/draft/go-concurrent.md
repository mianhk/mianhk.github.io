+++
title = "【Golang】go并发编程"
urlname = "xzxhcv"
date = "2018-11-05T20:04:46+08:00"
update = "Mon Nov 05 2018 20:04:50 GMT+0800 (中国标准时间)"
categories = ["Golang"]
tags = ["Golang", "并发"]
description = ""
+++




> 并发是Go语言一直宣扬的优势之一，写起来很方便，但在实际的并发编程中，还是有很多需要注意的，学习了极客时间的《Go 并发编程实战课》，这里重新梳理总结一下

<!--more-->  



# 基本并发原语



## mutex

互斥锁提供两种方法`Lock`和`Unlock`，进入临界区前调用`Lock`，离开临界区是调用`Unlock`。

当一个 goroutine 通过调用 Lock 方法获得了这个锁的拥有权后， 其它请求锁的 goroutine 就会阻塞在 Lock 方法的调用上，直到锁被释放并且自己获取到了这个锁的拥有权。

### (1)嵌入在struct中使用

```
type Counter struct{
	mu sync.Mutex
	Count int
}
# 或采用直接嵌入字段
type Counter struct{
	sync.Mutex
	Count int
}
```

当初始化`Counter`时，可以不用初始化`Mutex`字段，而不会因为没有初始化出现空指针或者是无法获取到锁的情况。

### (2) 方法封装

```go
type Counter struct{
	name string
	
	mu sync.Mutex  //一般将Mutex放在要控制的字段上面，然后加空格（便于识别）
	count int
}

func (c *Counter) Incr(){
  c.mu.Lock()
  c.count++
  c.mu.Unlock()
}
```

这样可以对外不暴露加锁的逻辑（当然还需要写获取值等方法配合使用）

### 实现原理

![img](https://blog-1252063226.cos.ap-beijing.myqcloud.com/img/c28531b47ff7f220d5bc3c9650180835.jpg)



# channel



# 其他并发原语

当然最近很不喜欢用其他这个词，因为其他意味