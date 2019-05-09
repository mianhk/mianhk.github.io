
title: go语言学习-极客时间
date: 2019-04-28 21:34:33 +0800
tags: []
categories: 
---
title: go语言学习-极客时间<br />date: 2019-05-07 11:25:46<br />categories: Go<br />tags: [Go,学习]

---

<a name="GHSXx"></a>
# 第一个go程序

- go语言主函数没有返回值，需要使用os包， `os.exit()` ，也不能直接函数传参。

<a name="ZC31x"></a>
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


<a name="0WEDs"></a>
# 运算符

- 算数运算符：没有前置的++、--
- 比较运算符：用 `==` 比较时，相同维数的数组可以比较
- 逻辑运算符
- 位运算符： `&^` ：按位清零

```
1 &^ 0 --1
1&^ 1 --0
0&^1 --0
0&^0 --0
```
<a name="SEhok"></a>
# 条件和循环

- 循环：只支持 `for` ，并且没有括号，while条件的写法为

```go
for n<5{
	n++
  fmt.Println(n)
}
```

- 条件：条件一定要是个布尔值或表达式。支持在if语句中对变量赋值
- switch条件：条件表达式不限制为常量或者整数；单个case中，可以出现多个结果选项，使用逗号分隔；不需要break；可以不设定switch之后的条件表达式
<a name="gwMfp"></a>
# 数组和切片
<a name="zr8tw"></a>
## 数组

- 数组的声明：声明同时初始化：`arr3:=[...]int{1,3,4,5} `  
-  数组的遍历
- 数组截取：a[index_begin(包含),index_end(不包含)]
<a name="49EoL"></a>
## 切片

- 切片的声明方式：与数组的声明有点相似
```go
var s0 []int
s1:=[]int{}
s2:=[]int{1,2,3}
s2:=make([]int,2,4)  //([]type,len,cap)  len个元素会被初始化为零值，
                       cap中其它未初始化的元素不能访问
```


- 切片的增长方式：类似于c++的vector。
- 切片共享存储结构：切片截取后，计算cap得到的结果。其实切片截取，指向的是内部共享的切片存储空间。所以修改截取的切片的数据，其他截取的相同区域也会发生改变。这是一个容易出错的问题。
<a name="1gHlK"></a>
## 切片和数组的区别

- 容量是否可伸缩
- 是否可以进行比较
<a name="on0MB"></a>
# Map基础

- Map声明方式

```go
m:=map[string]int{"one":1,"two":2,"three":3}
m1:=map[string]int{}
m1["one"]=1
m2:=make(map[string]int,10)  //10表示初始化的cap,不需要初始化len
```

- 元素访问：当访问的key不存在时，仍然会返回零值，编程时需要根据nil来判断元素是否存在
<a name="hmFCq"></a>
# Map与工厂模式

- Map的value可以是一个方法
- 与Go的Dock type接口方式一起，可以方便的实现单一方法对象的工厂模式
- Go内置集合中没有Set，可以通过map实现` mySet:=**map**[int]bool{} `   
<a name="3XQVx"></a>
# 字符串

- string是数据类型，不是引用或指针类型。零值不是空，而是空字符串。
- string是只读的byte slice，不能重复赋值。len函数可以表示它所包含的byte数
- string的byte数组可以存放任何数据
<a name="aSMYD"></a>
## Unicode和UTF-8

- Unicode是一种字符集（code point）
- UTF-8是Unicode的存储实现（转换为）

![image.png](https://cdn.nlark.com/yuque/0/2019/png/187932/1556503870325-262231e2-8b69-42ab-8711-83d68d74069e.png#align=left&display=inline&height=270&name=image.png&originHeight=398&originWidth=671&size=46907&status=done&width=456)

<a name="gy3wV"></a>
# Go语言的函数

- 函数可以返回多个值
- 所有参数都是值传递：slice，map，channel会有传引用的错觉
- 函数可以作为变量的值
- 函数可以作为参数和返回值

<a name="5TwaL"></a>
# 可变参数及defer

- 延迟执行函数：defer。类似于其他语言中的finally，主要作用是最后关闭一些资源或者关闭一些锁

<a name="QNCoJ"></a>
# 行为的定义和实现

<a name="8hlP5"></a>
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

<a name="0w95L"></a>
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

<a name="sTcmz"></a>
# Go语言的相关接口
<a name="VSi4q"></a>
## Duck Type
方法签名是一样的，就认为是这样的

- 接口是非入侵性的，实现不依赖于接口定义
- 接口的定义可以包含在接口使用者包内
<a name="8FFfL"></a>
## 接口变量
![image.png](https://cdn.nlark.com/yuque/0/2019/png/187932/1556508509894-85f1967f-80e0-4a9e-9db7-a2b01ba96f30.png#align=left&display=inline&height=338&name=image.png&originHeight=338&originWidth=701&size=40266&status=done&width=701)


<a name="cvQdN"></a>
## 自定义类型

```go
type IntConv func (op int) int
```

<a name="70UD5"></a>
# 扩展与复用

<a name="1sY91"></a>
# 不一样的接口类型，一样的多态

<a name="j94PF"></a>
## 空接口与断言

- 空接口可以表示任何类型
- 通过断言来将空接口转换为制定类型 `v,ok:=p.(int) //ok=true时为转换成功` 

<a name="xDFda"></a>
## Go接口最佳实践

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

<a name="KwICQ"></a>
# 编写好的错误处理

- 没有异常机制
- error类型实现了error接口
- 可以通过errors.New来快速创建错误实例
<a name="ZeszK"></a>
# panic和recover
<a name="W2cvc"></a>
## panic

- panic用于不可恢复的错误
- panic退出前会执行defer指定的内容
<a name="hUDIy"></a>
## panic vs os.Exit

- os.Exit退出时不会调用defer指定的函数
- os.Exit退出时不会输出当前调用栈信息
<a name="htxUf"></a>
## recover

```
defer func(){
	if err:=recover();err!=nil{
  	//恢复错误
  }
}()
```

- 不要强制恢复错误，有的时候“Let it crash”可能更好，让程序重启来恢复。

<a name="GXKen"></a>
# 构建可复用的模块（包）
<a name="Ps2yh"></a>
## package

- 基本复用模块单元：以**首字母大写**来表名可被包外代码访问
- 代码在package可以和所在的目录了不一致（相对于Java而言）
- 同一目录里的Go代码的package要保持一致
<a name="32DTD"></a>
## init方法

- 在main被执行前，所有依赖的package的init方法都会被执行
- 不同包的init函数按照包导入的依赖关系决定执行顺序
- 每个包可以有多个init函数
- 包的每个源文件也可以有多个init函数，比较特殊
<a name="CPKNr"></a>
## go get

- 通过go get来获取远程依赖

```
go get -u 强制从网络更新远程依赖
```

- 注意代码在Github上的组织形式，以适应go get：直接以代码路径开始，不要有src

<a name="uCTgI"></a>
# 依赖管理
<a name="na3Of"></a>
## Go未解决的依赖问题

- 同一环境下，不同项目使用同一包的不同版本
- 无法管理对包的特定版本的依赖
<a name="X32MI"></a>
## vendor路径
Go1.5 release版本，vendor目录被添加到除了GOPATH和GOROOT以外的依赖目录查找方案。查找依赖包路径的解决方案：

1. 当前包下的vendor目录
1. 向上级目录查找，直到找到src下的vendor目录
1. 在GOPATH下面查找依赖包
1. 在GOROOT目录下查找

其他第三方依赖管理工具：godep，glide，**dep**<br />**
<a name="L5ePp"></a>
# 协程机制
<a name="Ph7TU"></a>
## 线程vs协程

- 创建时默认的stack大小：JAVA 1M vs Goroutine 2K
- 和KSE（Kernel Space Entity）：java Thread是1:1；GO M:N

![image.png](https://cdn.nlark.com/yuque/0/2019/png/187932/1556704202218-7913c997-6b91-48e2-9dc6-49b057a39342.png#align=left&display=inline&height=432&name=image.png&originHeight=432&originWidth=618&size=110172&status=done&width=618)


<a name="30Cx3"></a>
# 共享内存并发机制
<a name="OFEOj"></a>
## Lock
<a name="OKldk"></a>
## WaitGroup
相当于Java的join
<a name="49kQI"></a>
# CSP并发机制
<a name="58HdC"></a>
## CSP vs Actor

- 和Actor的直接通讯不同，CSP模式是通过Channel进行通讯的，更松耦合一些
- Go中Channel是有容量限制并且独立于处理Goroutine，而如Erlang，Actor模式中的mailbox容量是无限的，接收进程也总是被动地处理消息。
<a name="xvZt3"></a>
## Channel
![image.png](https://cdn.nlark.com/yuque/0/2019/png/187932/1556705599268-5d3769a6-8c93-4827-a9c2-525810d0cc3a.png#align=left&display=inline&height=910&name=image.png&originHeight=910&originWidth=1703&size=565338&status=done&width=1703)<br />两种情况：一种是一直等待，一种Buffered Channel ，更松耦合的Channel，消息发送方可以在容量没满的时候一直放，满了之后需要等待。对于接收方来说，只要Channel内有消息就可以一直接收。

<a name="2SBcu"></a>
# 多路选择和超时
<a name="sLxEu"></a>
## select
![image.png](https://cdn.nlark.com/yuque/0/2019/png/187932/1556712290363-e32d5fa7-eb01-4d32-8fed-14ae04a0042d.png#align=left&display=inline&height=301&name=image.png&originHeight=301&originWidth=861&size=79632&status=done&width=861)<br />运行到select时，当任一个事件准备好了，就可以对应响应。当不想一直等待某事件时，可以进行超时控制。

<a name="SkpQa"></a>
# channel的关闭和广播
解决怎么知道channel数据完了的问题
<a name="qC5Nf"></a>
## channel的关闭

- 向关闭的channel发送数据，会导致panic
- v,ok<-ch；ok为bool值，true表示正常接收，false表示通道关闭
- 所有的channel接收者都会在channel关闭时，立即从阻塞等待中返回且上述ok值为false。这个广播机制常被利用，进行向多个订阅者发送信号，如：退出信号。

<a name="BOlOq"></a>
# 任务的取消

<a name="PIyuM"></a>
# Context与任务取消
![image.png](https://cdn.nlark.com/yuque/0/2019/png/187932/1557062963366-c9338325-f390-4dce-ae1d-f0874f9612ba.png#align=left&display=inline&height=372&name=image.png&originHeight=298&originWidth=786&size=58395&status=done&width=982.4999853596094)

<a name="444Se"></a>
## Context

- 根Context：通过context.Background()创建
- 子Context：context.WithCancel(parentContext)创建
- ctx,cancel：context.WithCancel(context.Background())
- 当前Context被取消时，基于他的子context也会被取消
- 接收取消通知<-ctx.Done()

还有一些其他的方法

<a name="jDWbp"></a>
# 典型并发任务
<a name="2KmYh"></a>
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

<a name="kGIsw"></a>
## 所需任意任务完成
<a name="YYXIC"></a>
## 所有任务完成
<a name="jgefL"></a>
## 对象池
数据库连接，网络连接，经常将这些对象池化，避免重复创建。
<a name="tAhWo"></a>
## sync.pool对象缓存
从名字来看，像是go语言提供的池。其实是对象的缓存<br />![image.png](https://cdn.nlark.com/yuque/0/2019/png/187932/1557066107461-3144bf63-f63c-4522-b25d-af4bd721daab.png#align=left&display=inline&height=517&name=image.png&originHeight=414&originWidth=846&size=118933&status=done&width=1057.4999842420223)

- 如果私有对象不存在则保存为私有对象
- 如果私有对象存在，就放入当前Processor子池的共享池中

使用：<br />![image.png](https://cdn.nlark.com/yuque/0/2019/png/187932/1557066277648-e57411da-71d5-4673-93bc-a82e0315284b.png#align=left&display=inline&height=341&name=image.png&originHeight=273&originWidth=497&size=37422&status=done&width=621.2499907426537)

**sync.pool对象的生命周期---**sync.pool不能作为对象池的原因

- GC会清除sync.pool缓存的对象
- sync.pool对象的缓存有效期为下一次GC之前

总结：

- 适合于通过复用，降低复杂对象的创建和GC代价
- 协程安全，会有锁的开销
- 声明周期受GC影响，不适合于做连接池等，需自己管理生命周期资源的池化
- 所以具体要看锁的开销大，还是初始化的开销大

<a name="UbsS7"></a>
# 测试
<a name="FECf9"></a>
## 单元测试
表格测试
<a name="cOhz8"></a>
### 内置单元测试框架

- Fail，Error：该测试失败，该测试继续，其他测试继续执行
- FailNow，Fatal：该测试失败，该测试中止，其他测试继续执行

代码覆盖率
<a name="Z0rO4"></a>
## Benchmark
![image.png](https://cdn.nlark.com/yuque/0/2019/png/187932/1557067837101-3bdadb6b-821f-4dbd-9b3a-c9efe304bc7a.png#align=left&display=inline&height=491&name=image.png&originHeight=393&originWidth=679&size=77590&status=done&width=848.7499873526397)<br />以Benchmark开头，参数类型稍有不同。<br />通过ResetTimer和StopTimer将测试代码隔开

命令行下运行：


<a name="o10fu"></a>
## BBD
Behavior Driven Development<br />常用框架：goconvey

<a name="1pJFI"></a>
## 反射编程


![image.png](https://cdn.nlark.com/yuque/0/2019/png/187932/1557107233067-f50d5086-e384-46cc-bd5e-0a2446ec3d8f.png#align=left&display=inline&height=390&name=image.png&originHeight=312&originWidth=820&size=64732&status=done&width=1024.99998472631)

![image.png](https://cdn.nlark.com/yuque/0/2019/png/187932/1557107389241-fb6b5237-7e73-48e9-83a9-e6c6ae45f6aa.png#align=left&display=inline&height=356&name=image.png&originHeight=285&originWidth=755&size=35453&status=done&width=943.7499859370294)




<a name="yvkPS"></a>
## 万能程序
DeepEqual<br />比较切片和map<br />与配置相关的，要求灵活性和复用性时，可以<br />反射的

<a name="KEsq1"></a>
## 不安全编程
unsafe，一般涉及到库的交互，与c语言交互。<br />“不安全”行为危险性：Go语言中不支持强制类型转换。下列操作看似可以，实际不能转换，而且实际使用起来很危险。

```
i:=10
f:=*(*floa64)(unsafe.Pointer(&i))
```

场景2：用到内置的Atomic操作，指针原子操作，并发读写

<a name="KmB4n"></a>
# 架构模式
<a name="dsFK1"></a>
## Pipe-Filter架构
![image.png](https://cdn.nlark.com/yuque/0/2019/png/187932/1557108759332-46d3b8e2-5573-419b-80b6-63cfbf5feaa1.png#align=left&display=inline&height=510&name=image.png&originHeight=408&originWidth=782&size=86362&status=done&width=977.4999854341152)

- 非常适合与数据处理及数据分析系统![image.png](https://cdn.nlark.com/yuque/0/2019/png/187932/1557108843135-278143cd-9e6a-4b4f-ae49-b800e98a261c.png#align=left&display=inline&height=474&name=image.png&originHeight=379&originWidth=690&size=86777&status=done&width=862.4999871477487)
<a name="UVtCE"></a>
## micro kernel
特点：易于拓展，错误隔离，保持架构一致性<br />要点：

- 内核包含公共流程或通用逻辑
- 将可变成或可扩展部分规划为扩展点
- 抽象扩展点行为，定义接口
- 利用插件进行扩展

生产过程任务的开发
<a name="N5rRp"></a>
## 内置json解析
远程过程调用等过程中，会用json，以及在配置文件中，很多使用json


<a name="RFIdh"></a>
## easyjson
go内置的，一般适用于配置文件解析，对于qps较高，运用了反射，效率较低。尽量使用高性能的json解析

<a name="wincH"></a>
## HTTP服务
![image.png](https://cdn.nlark.com/yuque/0/2019/png/187932/1557111353880-2f261975-45c5-4dcd-9281-44ac48f2fbcb.png#align=left&display=inline&height=442&name=image.png&originHeight=354&originWidth=862&size=103367&status=done&width=1077.499983943999)<br />![image.png](https://cdn.nlark.com/yuque/0/2019/png/187932/1557111366213-f5138ca3-fd5f-4da1-992a-f68e1681d3ff.png#align=left&display=inline&height=445&name=image.png&originHeight=356&originWidth=771&size=101595&status=done&width=963.7499856390061)


<a name="s0G6x"></a>
## 构建Restful服务
更好的router，httprouter<br />面向资源的架构（Resource Oriented Architecture）

<a name="TpHAz"></a>
## 性能分析工具






学习函数式编程：《计算机程序的构造和解释》functional programming<br />《Restful Web Service》<br />《Go程序设计语言》<br />《面向模式的软件架构》1,2,3本

