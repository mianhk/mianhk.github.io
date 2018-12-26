---
title: 《c++primer》ch15-面向对象程序设计
date: 2017-09-19 12:44:24
categories: C++
tags: C++
---

> 面向对象三个基本概念：数据抽象、继承和动态绑定（java里说的多态）。这章主要内容是继承和动态绑定。


#### 15.1 OOP：概述
#### 15.2 定义基类和派生类
基类希望派生类进行覆盖的函数，通常将其定义为** 虚函数**，另一种是基类希望派生类继承但不要改变的函数。
`protected`访问运算符：派生类可以访问，但是其他用户无法访问。
定义派生类：通过访问说明符控制派生类从基类继承而来的成员是否对派生类可见。
如果派生类没有覆盖其基类中的某个虚函数，则该虚函数的行为跟其他类一样，派生类会直接继承其在基类中的版本。
派生类到基类的转换。这可以让我们把派生类对象或者派生类对象的引用用在需要基类引用的地方，也可以把派生类指针用在需要基类指针的地方。但是，这里会出现一个问题，当我们使用基类的指针或者引用时，就不知道这个所绑定的对象到底是基类还是派生类了。
派生类构造函数。必须使用基类的构造函数初始化。（每个类控制自己的初始化过程。）
每个类定义各自的接口，派生类要遵循基类的接口。
如果基类中定义了静态成员，则在整个继承体系中只存在唯一的定义，不管定义了多少遍，都只存在唯一的实例。
对派生类的声明，不需要包含派生列表。
当我们不想让类被继承的时候，可以使用`final`关键字，跟在类名之后。
表达式的** 静态类型**在编译时是已知的，是变量声明时或者表达式生成式生成的类型。** 动态类型**则是变量或表达式表示的内存中的对象的类型。因此，基类的指针或引用的静态类型可能与动态类型不一致。
派生类向基类的自动类型转换只对指针和引用有效，在类型之间不存在这样的转换。当我们用一个派生类对象初始化或给一个基类对象赋值时，只有该派生类的对象中的基类部分会被拷贝、移动或赋值，派生类部分则会被忽略掉。
#### 15.3 虚函数
我们必须为每一个虚函数提供定义，因为连编译器也无法确定到底使用的是哪一个虚函数。
如果我们在派生类中覆盖了某个虚函数时，可以再次使用`virtual`指出该函数的性质，但实际上并不一定要这么做。因为某个函数被声明成虚函数，则在所有的派生类中都是虚函数。
#### 15.4 抽象基类
在函数体声明的语句的分号前使用`=0`可以将一个函数声明为纯虚函数。
含有纯虚函数的类是抽象基类。抽象基类负责定义接口，后续的其他类负责覆盖该接口。我们不能直接创建一个抽象基类的对象。GCC的编译器中可能前面还是要加上`virtual`
** 重构**：重构负责重新设计类的体系以便将操作和/或数据从一个类移动到另一个类中。
#### 15.5 访问控制与继承
protected:对于类的用户来说是不可访问的，对于派生类的成员和友元来说是可访问的。但是只能通过** 派生类对象**来访问，** 派生类**对于一个基类中受保护的成员是无法访问的。
派生类向基类的转换：只有当D公有的继承B时，** 用户代码**才能使用基类向派生类的转换。无论D以什么方式继承B，D的成员函数和友元都能使用派生类向基类的转换。如果D继承B的方式是公有的或受保护的，则D的派生类可以使用D向B的类型转换。
友元关系不能继承。基类的友元在访问派生类成员时不具有特殊性，派生类的友元也不能随意访问基类的成员。
派生类可以使用`using`为那些可以访问的名字提供声明，以改变这些名字在它的派生类中的可访问性。
#### 15.6 继承中的类作用域
每个类定义自己的作用域，当存在继承关系时，派生类的作用域嵌套在其基类的作用域之内。
当名字相同时，派生类的成员将隐藏基类的成员。基类可以通过** 作用域运算符**来使用隐藏的成员。一般情况下，我们应该不会这么使用，所以，平时继承类尽量不要覆盖继承而来的虚函数以外的基类的名字。
** 名字查找先于类型检查**：如果派生类的成员与基类中的某个成员同名，则派生类将在其作用域内隐藏该基类成员。一旦编译器查找到名字后，不管形参列表是否相同，都不会再继续查找，这也是我们需要在覆盖虚函数时，保证形参列表是相同的。
`using`声明语句指定一个名字而不是形参列表，所以我们在基类中使用一个`using`就可以把该函数的所有重载实例添加到派生类作用域中，派生类只需要定义特有的函数即可。
#### 15.7 构造函数与拷贝控制
位于继承体系中的类也需要控制当其对象执行一系列操作时发生怎样的行为：包括创建、移动、拷贝、赋值和销毁。
一般讲基类中的析构函数定义为虚函数，这样，继承体系中的派生类都会是虚析构函数，否则，若基类中的析构函数不是虚函数，则delete一个指向派生类对象的基类指针将产生未定义的行为。
虚析构函数将组织合成移动操作。
和普通成员的using声明不同，构造函数的using声明不会改变该构造函数的访问级别。
using声明语句不能指定explicit或constexpr。
当一个基类构造函数含有默认实参时，这些实参并不会被继承。派生类将获得多个继承的构造函数，其中每个构造函数分别省略掉一个含有默认实参的形参。
#### 15.8 容器与继承
容器不能直接存放继承体系中的对象，通常采用间接存储的方式。因为当我们把基类存储到一个容器中，当存入派生类对象，实际存入的只是派生类中基类的部分，显然不符合我们的需要。所以我们希望在具有继承关系的对象时，实际上存储的是基类的指针。（最好使用智能指针）
#### 15.9 文本查询程序再探