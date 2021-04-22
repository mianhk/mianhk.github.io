---
title: go语言基础学习(4)
urlname: qsp5o8
date: 2019-07-04 11:47:16 +0800
tags: []
categories: []
---

1. 类型别名
   type S string 与
   type S = string 区别？

type S string 是类型声明，S 是一种新的类型，给 S 定义的方法，接口等和 string 没有关系。
而 type S = string 只是一种别名，可以理解为，S 和 String 是完全一样的，只是换了一种叫法而已。类型别名和原类型方法是一样的。也不能在 Switch 中使用两者同时作为分支。

2. go 语言中没有按地址传递，可以深究一下如何传递 slice，再回复到邮件中

Go 语言中只有按值传递，通过源码可以看到，slice 是一个结构体。结构体中包括真正的数组和长度以及容量。

```
type slice struct {
	array unsafe.Pointer
	len   int
	cap   int
}
```

函数传递 slice 时，其实传递的 slice 结构体，其中包括 array 的首地址、len 和 cap。通过下面的代码可以有以下的结果:

```
func add_slice(a []int){
	a[0]=2
	a[1]=3
	return
}

func append_slice(a []int){
	a=append(a,5)
}

func modify_slice(a *[]int){
	*a=append(*a,6)
}

func main(){
	a:=[]int{1,2,3}

	add_slice(a)
	fmt.Println(a)  //输出[2 3 3]

	append_slice(a)
	fmt.Println(a)  //输出[2 3 3]

	modify_slice(&a)
	fmt.Println(a)   //输出[2 3 3 6]
}
```

只是改变 slice 内部的值时，看起来像是按引用传递，因为可以改变 slice 内的值，但是实际上是在参数传递的过程中，传递了 array 的首地址，而 slice 在内存中是一连串的地址，所以知道首地址就可以修改整个数组内部的值。
    但是由于是按值传递，所以不能在函数内对 slice 进行 append。如果需要改变 slice 的长度，可以通过传入 slice 的指针。
    由于 slice 传递的形式，需要在编程中多多注意，避免进坑。另外看到一个关于传递 slice 的操作，加深了一下对 slice 传参的理解。

```
func main() {
	a := []int{7,8,9}
	b:=[]int{}
	b=append(b,1,2,3)  //a,b初始化的方式不一样，导致两者的cap不一样

	fmt.Printf("a len: %d cap:%d data:%+v\n", len(a), cap(a), a)  //a len: 3 cap:3 data:[7 8 9]
	fmt.Printf("b len: %d cap:%d data:%+v\n", len(b), cap(b), b)  //b len: 3 cap:4 data:[1 2 3]

	append_slice(a)    //显然append是没有效果的
	fmt.Printf("a len: %d cap:%d data:%+v\n", len(a), cap(a), a)
	p := unsafe.Pointer(&a[2])  //根据slice在内存的连续性，拿到最后一位的指针地址
	q := uintptr(p)+8           //将指针往后移一位，因为是int，所以是8
	t := (*int)(unsafe.Pointer(q))
	fmt.Println(*t)             //输出0

	append_slice(b)
	fmt.Printf("b len: %d cap:%d data:%+v\n", len(b), cap(b), b)
	p1 := unsafe.Pointer(&b[2])
	q1 := uintptr(p1)+8
	t1 := (*int)(unsafe.Pointer(q1))
	fmt.Println(*t1)    //输出10
}

func append_slice(a []int) {
	a = append(a, 10)
}
```

可以看到，直接 append 到 slice 的值，如果 cap 够的话，是会 append 上的，但是由于 len 的值没有改变，所以看不到，可以通过 unsafe 指针观察到结果。但是如果 cap 不够，继续 append，会导致重新分配内存空间，append 在新的位置上，此时通过 unsafe 指针也拿不到 append 的值。

3. 关于函数的执行顺序：

```
func add1(x,y int) int{
	fmt.Println("in add1. sum1= ",x,y)
	return x+y
}
func add(x,y,z,t int) int{
	sum:=0
	sum=add1(x,y)+add1(z,t)
	fmt.Println("in add. sum=",sum)
	return sum
}

func main(){
	fmt.Println(add(1,2,3,4),add(2,3,4,5))
}

结果：
in add1. sum1=  1 2
in add1. sum1=  3 4
in add. sum= 10
in add1. sum1=  2 3
in add1. sum1=  4 5
in add. sum= 14
10 14
```

可以看到，add1 的结果是最先执行的，再执行 add，最后才执行 fmt.Println（）.是按后序遍历的顺序。

# go 语言学习

- 命名返回值:没有参数的  return  语句返回已命名的返回值
- println 的执行顺序。会先把函数计算结束之后，再按照顺序输出
- 没有条件的 switch 同  `switch true`  一样。
- defer 函数调用会被压入一个栈中，所以后 defer 的值会先输出
- 结构体指针的使用：修改结构体指针的值时，不需要带\*号。
- 数组定义的几种方式

# 关于切片

- 切片就像数组的引用，改变切片会改变底层的值

- 切片的默认行为，可以不写完全部的上下限，因为切片默认有上下限

- 只是截取切片是不会改变切片大小的

- 切片的长度就是它所包含的元素个数。

- 切片的容量是从它的第一个元素开始数，到其底层数组元素末尾的个数

- 切片的零值是  `nil`

- 函数的闭包

- 接收者的类型定义和方法声明必须在同一包内；不能为内建类型声明方法，可以定义别名，`**type **MyFloat float64`

# 关于方法和接口

- 指针参数的函数必须接受一个指针,而以指针为接收者的方法被调用时，接收者既能为值又能为指针
- 跟 C++中一样，使用指针接收者可以修改接收者指向的值；另外，可以避免每次在调用方法时复制该值。

  1.函数执行顺序是否是后序遍历的方式，可以再嵌套一层方法试试？ 画个调用树出来看看？
  我在网上没有找到相关的解释，就自己查看了 fmt.Println()函数的源码，会先调用 Fprintln 函数，而 Fprintln 会先执行传入的函数，存在 p 的 buf 中，之后转换成 string 再打印。

```
func Println(a ...interface{}) (n int, err error) {
	return Fprintln(os.Stdout, a...)
}
func Sprintln(a ...interface{}) string {
	p := newPrinter()
	p.doPrintln(a)
	s := string(p.buf)
	p.free()
	return s
}
```

同时也重新把打印语句加复杂了一下，结果与预期相符。

```
package main
import "fmt"
func add(x,y int) int{
	sum:=x+y
	fmt.Println(sum)
	return sum
}
func main(){
	fmt.Println(add(1,2),add(add(1,1),add(3,7)),add(4,5))
}
运行结果为：
3
2
10
12
9
3 12 9
```

2. 切片的增长为什么是 20，是否在大于 1024 或某个值时，有其他的增长方法？ 比如 增加 1.2 倍？ 可以贴源码作为论据
   查看了一下 slice 中的 growslice 函数，可以看到当容量小于 1024 时，是按照 2 倍进行增长的，当超过 1024 时，按照 1.25 倍进行增长，应该是从节省空间的角度考虑，毕竟对一个很长的数组，再插入同样长度的数的概率很小。

```
newcap := old.cap
	doublecap := newcap + newcap
	if cap > doublecap {
		newcap = cap
	} else {
		if old.len < 1024 {
			newcap = doublecap
		} else {
			// Check 0 < newcap to detect overflow
			// and prevent an infinite loop.
			for 0 < newcap && newcap < cap {
				newcap += newcap / 4
			}
			// Set newcap to the requested cap when
			// the newcap calculation overflowed.
			if newcap <= 0 {
				newcap = cap
			}
		}
	}
```

通过代码测试上述结果：

```
func main(){
	var a []int
	for i:=0;i<1500;i++{
		a=append(a,i)
		if i%100==0{
			fmt.Printf("len: %d , cap; %d\n",len(a),cap(a))
		}
	}
}
输出结果为：
len: 1 , cap; 1
len: 101 , cap; 128
len: 201 , cap; 256
len: 301 , cap; 512
len: 401 , cap; 512
len: 501 , cap; 512
len: 601 , cap; 1024
len: 701 , cap; 1024
len: 801 , cap; 1024
len: 901 , cap; 1024
len: 1001 , cap; 1024
len: 1101 , cap; 1280
len: 1201 , cap; 1280
len: 1301 , cap; 1696
len: 1401 , cap; 1696
```

如上符合源码结果，所以之前的分析有些问题，但是 append 多个值的时候，与之前的结果相同。再次查看源码，发现实际上还有内存对齐的考虑：

```
capmem = roundupsize(uintptr(newcap) * sys.PtrSize)
```

其中 capmem 会根据 roundupsize 函数进行内存对齐。其中 uintptr(newcap)表示新容量的大小，sys.PtrSize 表示一个元素的大小，int 时为 8。roundupsize 函数的实现如下

```
func roundupsize(size uintptr) uintptr {
	if size < _MaxSmallSize {
		if size <= smallSizeMax-8 {
			return uintptr(class_to_size[size_to_class8[(size+smallSizeDiv-1)/smallSizeDiv]])
		} else {
			return uintptr(class_to_size[size_to_class128[(size-smallSizeMax+largeSizeDiv-1)/largeSizeDiv]])
		}
	}
	if size+_PageSize < size {
		return size
	}
	return round(size, _PageSize)
}
```

其中：\_MaxSmallSize=32768,2 的 15 次方，是 32K。当需要分配的 size 大于 32K 时，需要 mchche 向 mcentral 申请；当 size 小于 32K 时，计算应该分配的 sizeclass，直接去 mchche 申请。（关于具体的内存申请方面，在后面的开发需要的时候再仔细研究）
当 size 小于 smallSizeMax-8=1024-8=1016 时，采用 size_to_class8 的分配方式，大于 1016 时采用 size_to_class128 的分配方式。

```
size_to_class8 = [smallSizeMax/smallSizeDiv + 1]uint8{0, 1, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 15, 15, 16, 16, 17, 17, 18, 18, 18, 18, 19, 19, 19, 19, 20, 20, 20, 20, 21, 21, 21, 21, 22, 22, 22, 22, 23, 23, 23, 23, 24, 24, 24, 24, 25, 25, 25, 25, 26, 26, 26, 26, 26, 26, 26, 26, 27, 27, 27, 27, 27, 27, 27, 27, 28, 28, 28, 28, 28, 28, 28, 28, 29, 29, 29, 29, 29, 29, 29, 29, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31}
size_to_class128 = [(_MaxSmallSize-smallSizeMax)/largeSizeDiv + 1]uint8{31, 32, 33, 34, 35, 36, 36, 37, 37, 38, 38, 39, 39, 39, 40, 40, 40, 41, 42, 42, 43, 43, 43, 43, 43, 44, 44, 44, 44, 44, 44, 45, 45, 45, 45, 46, 46, 46, 46, 46, 46, 47, 47, 47, 48, 48, 49, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 51, 51, 51, 51, 51, 51, 51, 51, 51, 51, 52, 52, 53, 53, 53, 53, 54, 54, 54, 54, 54, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 57, 57, 57, 57, 57, 57, 58, 58, 58, 58, 58, 58, 58, 58, 58, 58, 58, 58, 58, 58, 58, 58, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 60, 60, 60, 60, 60, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66}
class_to_size = [_NumSizeClasses]uint16{0, 8, 16, 32, 48, 64, 80, 96, 112, 128, 144, 160, 176, 192, 208, 224, 240, 256, 288, 320, 352, 384, 416, 448, 480, 512, 576, 640, 704, 768, 896, 1024, 1152, 1280, 1408, 1536, 1792, 2048, 2304, 2688, 3072, 3200, 3456, 4096, 4864, 5376, 6144, 6528, 6784, 6912, 8192, 9472, 9728, 10240, 10880, 12288, 13568, 14336, 16384, 18432, 19072, 20480, 21760, 24576, 27264, 28672, 32768}
```

可以看到两个数组值的不同，并且间隔的粒度也不同，当 size 较小时，间隔为 8，当 size 较大时，间隔为 128.
而为了内存优化考虑，class_to_size 会控制分配大小，间隔从 8-4096
以 int 为例

| 个数           | 1   | 2   | 3   | 4   | 5   | 6   | 7   | 8   | 9   |
| :------------- | :-- | :-- | :-- | :-- | :-- | :-- | :-- | :-- | :-- |
| 字节数         | 8   | 16  | 24  | 32  | 40  | 48  | 56  | 64  | 72  |
| 所占空间       | 8   | 16  | 32  | 32  | 48  | 48  | 64  | 64  | 80  |
| size_to_class8 | 1   | 2   | 3   | 3   | 4   | 4   | 5   | 5   | 6   |



## Tips

函数

```
var rmdirs []func()
for _, d := range tempDirs() {
  dir := d // NOTE: necessary!如果没有这一行会导致传入同样的dir
  os.MkdirAll(dir, 0755) // creates parent directories too
  rmdirs = append(rmdirs, func() {
  	os.RemoveAll(dir)
  })
}
// ...do some work…
for _, rmdir := range rmdirs {
	rmdir() // clean up
}
```

