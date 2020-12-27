# python相关问题

## range和xrange的区别

## lambda表达式

##GIL全局锁
决定了Python的多线程问题
### 为什么说python的线程是伪线程？
在python的原始解释器CPython中存在着GIL（Global Interpreter Lock，全局解释器锁），因此在解释执行python代码时，会产生互斥锁来限制线程对共享资源的访问，直到解释器遇到I/O操作或者操作次数达到一定数目时才会释放GIL。

所以，虽然CPython的线程库直接封装了系统的原生线程，但CPython整体作为一个进程，同一时间只会有一个线程在跑，其他线程则处于等待状态。这就造成了即使在多核CPU中，多线程也只是做着分时切换而已。
## Python函数式编程

## 浅拷贝与深拷贝

## 装饰器

## Python2和Python3的区别

## 迭代器和生成器
生成器：例子
```

```
[yeild的用法](https://taizilongxu.gitbooks.io/stackoverflow-about-python/content/1/README.html)

## append和extend的区别
extend()接受一个列表参数，把参数列表的元素添加到列表的尾部，append()接受一个对象参数，把对象添加到列表的尾部。
