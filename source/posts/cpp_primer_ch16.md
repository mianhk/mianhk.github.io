+++
title = "《c++primer》ch16 模板与泛型编程"
date = "2017-09-19T12:47:04+08:00"
categories = "C++"
tags = ["C++"]
description = ""
+++

泛型编程与面向对象编程的区别是：面向对象编程能处理类型在程序运行之前都未知的情况；而在泛型编程中，在编译时就能获知类型了。
#### 16.1 定义模板
模板程序应该尽量减少对实参类型的要求。
模板的头文件通常包括声明和定义。
模板直到实例化时才生成代码。
泛型编程的一个目标就是另算法是“通用的”-适合于不同类型。所有标准库容器都定义了`==`和`!=`，但只有少数定义了`<`运算符。因此尽量使用`!=`而不是`<`。
** 类模板**用来生成类的蓝图，一个类模板的每个实例都形成一个独立的类。默认情况下，对于一个实例化了的类模板，其成员只有在使用时才被实例化。在类模板的作用域类，我们可以直接使用模板名而不必指定模板实参。
如果一个类模板包含一个非模板友元，则友元被授权可以访问所有模板实例。如果友元自身是模板，类可以授权给 所有友元模板实例，也可以只授权给特定实例。
当我们希望通知编译器一个名字表示类型时，必须使用关键字`typename`，而不能使用`class`。
** 成员模板**：一个类（不管是模板类还是普通类）可以包含本身是模板的成员函数。这些成员函数被称为成员模板。成员模板不能是虚函数。
控制实例化：
```
extern template class Blob<string>;  //声明，遇到extern模板声明时，编译器不会在本文件中生成实例化代码。，对于一个给定的实例化版本，可以有多个extern声明，但只能有一个定义。
template int compare(const int&,const int&); //定义
```
#### 16.2 模板实参推断
将实参传递给带模板类型的函数形参时，能够自动应用的类型转换只有const转换及数组或函数到指针的转换。
一个模板类型参数可以用作多个函数形参的类型。由于只允许有限的几种类型转换，因此传递给这些形参的实参必须具有相同的类型。
如果函数参数类型不是模板参数，则可以进行正常的类型转换。
** 显式模板实参**按由左至右的顺序与对应的模板参数匹配。
#### 16.3 重载与模板
#### 16.4 可变参数模板
#### 16.5 模板特例化