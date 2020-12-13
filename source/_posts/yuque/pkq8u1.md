---
title: go语言学习-极客时间
urlname: pkq8u1
date: 2019-04-28 21:34:33 +0800
tags: []
categories: []
---
# 第一个 go 程序

- go 语言主函数没有返回值，需要使用 os 包， `os.exit()` ，也不能直接函数传参。

# 变量、常量和其他语言的区别

- 赋值可以自动类型推断： `a:=1` ，怎么方便怎么来就行
- 快速连续赋值

```
const (
	Monday=itoa+1
  Tuesday
  Wednesday
)

const(
	Open=1<<itoa
  Close
  Pending
)
```

# 运算符

- 算数运算符：没有前置的++、--
- 比较运算符：用 `==`  比较时，相同维数的数组可以比较
- 逻辑运算符
- 位运算符： `&^` ：按位清零

```
1 &^ 0 --1
1&^ 1 --0
0&^1 --0
0&^0 --0
```

# 条件和循环

- 循环：只支持 `for` ，并且没有括号，while 条件的写法为

```go
for n<5{
	n++
  fmt.Println(n)
}
```

- 条件：条件一定要是个布尔值或表达式。支持在 if 语句中对变量赋值
- switch 条件：条件表达式不限制为常量或者整数；单个 case 中，可以出现多个结果选项，使用逗号分隔；不需要 break；可以不设定 switch 之后的条件表达式

# 数组和切片

## 数组

- 数组的声明：声明同时初始化：`arr3:=[...]int{1,3,4,5} `
- 数组的遍历
- 数组截取：a[index_begin(包含),index_end(不包含)]

## 切片

- 切片的声明方式：与数组的声明有点相似

```go
var s0 []int
s1:=[]int{}
s2:=[]int{1,2,3}
s2:=make([]int,2,4)  //([]type,len,cap)  len个元素会被初始化为零值，
                       cap中其它未初始化的元素不能访问
```

- 切片的增长方式：类似于 c++的 vector。
- 切片共享存储结构：切片截取后，计算 cap 得到的结果。其实切片截取，指向的是内部共享的切片存储空间。所以修改截取的切片的数据，其他截取的相同区域也会发生改变。这是一个容易出错的问题。

## 切片和数组的区别

- 容量是否可伸缩
- 是否可以进行比较

# Map 基础

- Map 声明方式

```go
m:=map[string]int{"one":1,"two":2,"three":3}
m1:=map[string]int{}
m1["one"]=1
m2:=make(map[string]int,10)  //10表示初始化的cap,不需要初始化len
```

- 元素访问：当访问的 key 不存在时，仍然会返回零值，编程时需要根据 nil 来判断元素是否存在

# Map 与工厂模式

- Map 的 value 可以是一个方法
- 与 Go 的 Dock type 接口方式一起，可以方便的实现单一方法对象的工厂模式
- Go 内置集合中没有 Set，可以通过 map 实现`mySet:=**map**[int]bool{}`

# 字符串

- string 是数据类型，不是引用或指针类型。零值不是空，而是空字符串。
- string 是只读的 byte slice，不能重复赋值。len 函数可以表示它所包含的 byte 数
- string 的 byte 数组可以存放任何数据

## Unicode 和 UTF-8

- Unicode 是一种字符集（code point）
- UTF-8 是 Unicode 的存储实现（转换为）

![image.png](https://cdn.nlark.com/yuque/0/2019/png/187932/1556503870325-262231e2-8b69-42ab-8711-83d68d74069e.png#align=left&display=inline&height=270&name=image.png&originHeight=398&originWidth=671&size=46907&status=done&width=456)

# Go 语言的函数

- 函数可以返回多个值
- 所有参数都是值传递：slice，map，channel 会有传引用的错觉
- 函数可以作为变量的值
- 函数可以作为参数和返回值

# 可变参数及 defer

- 延迟执行函数：defer。类似于其他语言中的 finally，主要作用是最后关闭一些资源或者关闭一些锁

# 行为的定义和实现

## 封装数据和行为

```go
type Employee struct{
	Id string
  Name string
  Age int
}
实例的创建和初始化
e:=Employee{"0","Bob",20}
e1:=Employee{Name:"Mike",Age:30}
e2:=new(Employee)  //这里返回的是实例的指针
e2.Id="2"  //通过实例的指针访问指针不需要“->”
```

## 行为（方法）定义

```go
func (e Employee)String1() string{
	return fmt.Sprintf("ID:%s-Name:%s-Age:%d",e.Id,e.Name,e.Age)
}

//推荐使用的方式，类似于c++的引用
func (e *Employee)String() string{
	return fmt.Sprintf("ID:%s-Name:%s-Age:%d",e.Id,e.Name,e.Age)
}
```

# Go 语言的相关接口

## Duck Type

方法签名是一样的，就认为是这样的

- 接口是非入侵性的，实现不依赖于接口定义
- 接口的定义可以包含在接口使用者包内

## 接口变量

![image.png](https://cdn.nlark.com/yuque/0/2019/png/187932/1556508509894-85f1967f-80e0-4a9e-9db7-a2b01ba96f30.png#align=left&display=inline&height=338&name=image.png&originHeight=338&originWidth=701&size=40266&status=done&width=701)

## 自定义类型

```go
type IntConv func (op int) int
```

# 扩展与复用

# 不一样的接口类型，一样的多态

## 空接口与断言

- 空接口可以表示任何类型
- 通过断言来将空接口转换为制定类型 `v,ok:=p.(int) //ok=true时为转换成功`

## Go 接口最佳实践

- 倾向于使用小的接口定义，很多接口只包含一个方法。实现的负担较小。

```go
Type Reader interface{
	Read(p []byte)(n int,err error)
}
Type Writer interface{
	Write(p []byte)(n int,err error)
}
```

- 较大的接口定义，可以由多个小接口定义组合而成。

```go
Type ReadWrite interface{
	Reader
  Writer
}
```

- 只依赖于必要功能的最小接口，方法才能更多的被复用

```go
func StoreData(reader Reader) error{}
```

# 编写好的错误处理

- 没有异常机制
- error 类型实现了 error 接口
- 可以通过 errors.New 来快速创建错误实例

# panic 和 recover

## panic

- panic 用于不可恢复的错误
- panic 退出前会执行 defer 指定的内容

## panic vs os.Exit

- os.Exit 退出时不会调用 defer 指定的函数
- os.Exit 退出时不会输出当前调用栈信息

## recover

```
defer func(){
	if err:=recover();err!=nil{
  	//恢复错误
  }
}()
```

- 不要强制恢复错误，有的时候“Let it crash”可能更好，让程序重启来恢复。

# 构建可复用的模块（包）

## package

- 基本复用模块单元：以**首字母大写**来表名可被包外代码访问
- 代码在 package 可以和所在的目录了不一致（相对于 Java 而言）
- 同一目录里的 Go 代码的 package 要保持一致

## init 方法

- 在 main 被执行前，所有依赖的 package 的 init 方法都会被执行
- 不同包的 init 函数按照包导入的依赖关系决定执行顺序
- 每个包可以有多个 init 函数
- 包的每个源文件也可以有多个 init 函数，比较特殊

## go get

- 通过 go get 来获取远程依赖

```
go get -u 强制从网络更新远程依赖
```

- 注意代码在 Github 上的组织形式，以适应 go get：直接以代码路径开始，不要有 src

# 依赖管理

## Go 未解决的依赖问题

- 同一环境下，不同项目使用同一包的不同版本
- 无法管理对包的特定版本的依赖

## vendor 路径

Go1.5 release 版本，vendor 目录被添加到除了 GOPATH 和 GOROOT 以外的依赖目录查找方案。查找依赖包路径的解决方案：

1. 当前包下的 vendor 目录
1. 向上级目录查找，直到找到 src 下的 vendor 目录
1. 在 GOPATH 下面查找依赖包
1. 在 GOROOT 目录下查找

其他第三方依赖管理工具：godep，glide，**dep**
\*\*

# 协程机制

## 线程 vs 协程

- 创建时默认的 stack 大小：JAVA 1M vs Goroutine 2K
- 和 KSE（Kernel Space Entity）：java Thread 是 1:1；GO M:N

![image.png](https://cdn.nlark.com/yuque/0/2019/png/187932/1556704202218-7913c997-6b91-48e2-9dc6-49b057a39342.png#align=left&display=inline&height=432&name=image.png&originHeight=432&originWidth=618&size=110172&status=done&width=618)

# 共享内存并发机制

## Lock

## WaitGroup

相当于 Java 的 join

# CSP 并发机制

## CSP vs Actor

- 和 Actor 的直接通讯不同，CSP 模式是通过 Channel 进行通讯的，更松耦合一些
- Go 中 Channel 是有容量限制并且独立于处理 Goroutine，而如 Erlang，Actor 模式中的 mailbox 容量是无限的，接收进程也总是被动地处理消息。

## Channel

![image.png](https://cdn.nlark.com/yuque/0/2019/png/187932/1556705599268-5d3769a6-8c93-4827-a9c2-525810d0cc3a.png#align=left&display=inline&height=910&name=image.png&originHeight=910&originWidth=1703&size=565338&status=done&width=1703)
两种情况：一种是一直等待，一种 Buffered Channel ，更松耦合的 Channel，消息发送方可以在容量没满的时候一直放，满了之后需要等待。对于接收方来说，只要 Channel 内有消息就可以一直接收。

# 多路选择和超时

## select

![image.png](https://cdn.nlark.com/yuque/0/2019/png/187932/1556712290363-e32d5fa7-eb01-4d32-8fed-14ae04a0042d.png#align=left&display=inline&height=301&name=image.png&originHeight=301&originWidth=861&size=79632&status=done&width=861)
运行到 select 时，当任一个事件准备好了，就可以对应响应。当不想一直等待某事件时，可以进行超时控制。

# channel 的关闭和广播

解决怎么知道 channel 数据完了的问题

## channel 的关闭

- 向关闭的 channel 发送数据，会导致 panic
- v,ok<-ch；ok 为 bool 值，true 表示正常接收，false 表示通道关闭
- 所有的 channel 接收者都会在 channel 关闭时，立即从阻塞等待中返回且上述 ok 值为 false。这个广播机制常被利用，进行向多个订阅者发送信号，如：退出信号。

# 任务的取消

# Context 与任务取消

![image.png](https://cdn.nlark.com/yuque/0/2019/png/187932/1557062963366-c9338325-f390-4dce-ae1d-f0874f9612ba.png#align=left&display=inline&height=372&name=image.png&originHeight=298&originWidth=786&size=58395&status=done&width=982.4999853596094)

## Context

- 根 Context：通过 context.Background()创建
- 子 Context：context.WithCancel(parentContext)创建
- ctx,cancel：context.WithCancel(context.Background())
- 当前 Context 被取消时，基于他的子 context 也会被取消
- 接收取消通知<-ctx.Done()

还有一些其他的方法

# 典型并发任务

## 只运行一次（常见的并发任务）

在常见的多任务环境下，只执行一次。单例模式（懒汉式，线程安全）

```go
type Singleton struct {

}

var singleInstance *Singleton
var once sync.Once

func GetSingletonObj() *Singleton{
	once.Do(func() {    //传入创建方法
		fmt.Println("Create Obj")
		singleInstance=new(Singleton)
	})
	return singleInstance
}

```

## 所需任意任务完成

## 所有任务完成

## 对象池

数据库连接，网络连接，经常将这些对象池化，避免重复创建。

## sync.pool 对象缓存

从名字来看，像是 go 语言提供的池。其实是对象的缓存
![image.png](https://cdn.nlark.com/yuque/0/2019/png/187932/1557066107461-3144bf63-f63c-4522-b25d-af4bd721daab.png#align=left&display=inline&height=517&name=image.png&originHeight=414&originWidth=846&size=118933&status=done&width=1057.4999842420223)

- 如果私有对象不存在则保存为私有对象
- 如果私有对象存在，就放入当前 Processor 子池的共享池中

使用：
![image.png](https://cdn.nlark.com/yuque/0/2019/png/187932/1557066277648-e57411da-71d5-4673-93bc-a82e0315284b.png#align=left&display=inline&height=341&name=image.png&originHeight=273&originWidth=497&size=37422&status=done&width=621.2499907426537)

**sync.pool 对象的生命周期---**sync.pool 不能作为对象池的原因

- GC 会清除 sync.pool 缓存的对象
- sync.pool 对象的缓存有效期为下一次 GC 之前

总结：

- 适合于通过复用，降低复杂对象的创建和 GC 代价
- 协程安全，会有锁的开销
- 声明周期受 GC 影响，不适合于做连接池等，需自己管理生命周期资源的池化
- 所以具体要看锁的开销大，还是初始化的开销大

# 测试

## 单元测试

表格测试

### 内置单元测试框架

- Fail，Error：该测试失败，该测试继续，其他测试继续执行
- FailNow，Fatal：该测试失败，该测试中止，其他测试继续执行

代码覆盖率

## Benchmark

![image.png](https://cdn.nlark.com/yuque/0/2019/png/187932/1557067837101-3bdadb6b-821f-4dbd-9b3a-c9efe304bc7a.png#align=left&display=inline&height=491&name=image.png&originHeight=393&originWidth=679&size=77590&status=done&width=848.7499873526397)
以 Benchmark 开头，参数类型稍有不同。
通过 ResetTimer 和 StopTimer 将测试代码隔开

命令行下运行：

## BBD

Behavior Driven Development
常用框架：goconvey

## 反射编程

![image.png](https://cdn.nlark.com/yuque/0/2019/png/187932/1557107233067-f50d5086-e384-46cc-bd5e-0a2446ec3d8f.png#align=left&display=inline&height=390&name=image.png&originHeight=312&originWidth=820&size=64732&status=done&width=1024.99998472631)

![image.png](https://cdn.nlark.com/yuque/0/2019/png/187932/1557107389241-fb6b5237-7e73-48e9-83a9-e6c6ae45f6aa.png#align=left&display=inline&height=356&name=image.png&originHeight=285&originWidth=755&size=35453&status=done&width=943.7499859370294)

## 万能程序

DeepEqual
比较切片和 map
与配置相关的，要求灵活性和复用性时，可以
反射的

## 不安全编程

unsafe，一般涉及到库的交互，与 c 语言交互。
“不安全”行为危险性：Go 语言中不支持强制类型转换。下列操作看似可以，实际不能转换，而且实际使用起来很危险。

```
i:=10
f:=*(*floa64)(unsafe.Pointer(&i))
```

场景 2：用到内置的 Atomic 操作，指针原子操作，并发读写

# 架构模式

## Pipe-Filter 架构

![image.png](https://cdn.nlark.com/yuque/0/2019/png/187932/1557108759332-46d3b8e2-5573-419b-80b6-63cfbf5feaa1.png#align=left&display=inline&height=510&name=image.png&originHeight=408&originWidth=782&size=86362&status=done&width=977.4999854341152)

- 非常适合与数据处理及数据分析系统![image.png](https://cdn.nlark.com/yuque/0/2019/png/187932/1557108843135-278143cd-9e6a-4b4f-ae49-b800e98a261c.png#align=left&display=inline&height=474&name=image.png&originHeight=379&originWidth=690&size=86777&status=done&width=862.4999871477487)

## micro kernel

特点：易于拓展，错误隔离，保持架构一致性
要点：

- 内核包含公共流程或通用逻辑
- 将可变成或可扩展部分规划为扩展点
- 抽象扩展点行为，定义接口
- 利用插件进行扩展

生产过程任务的开发

## 内置 json 解析

远程过程调用等过程中，会用 json，以及在配置文件中，很多使用 json

## easyjson

go 内置的，一般适用于配置文件解析，对于 qps 较高，运用了反射，效率较低。尽量使用高性能的 json 解析

## HTTP 服务

![image.png](https://cdn.nlark.com/yuque/0/2019/png/187932/1557111353880-2f261975-45c5-4dcd-9281-44ac48f2fbcb.png#align=left&display=inline&height=442&name=image.png&originHeight=354&originWidth=862&size=103367&status=done&width=1077.499983943999)
![image.png](https://cdn.nlark.com/yuque/0/2019/png/187932/1557111366213-f5138ca3-fd5f-4da1-992a-f68e1681d3ff.png#align=left&display=inline&height=445&name=image.png&originHeight=356&originWidth=771&size=101595&status=done&width=963.7499856390061)

## 构建 Restful 服务

更好的 router，httprouter
面向资源的架构（Resource Oriented Architecture）

## 性能分析工具

学习函数式编程：《计算机程序的构造和解释》functional programming
《Restful Web Service》
《Go 程序设计语言》
《面向模式的软件架构》1,2,3 本
