+++
title = "牛客网-剑指offer-3"
date = "2017-11-17T19:50:52+08:00"
categories = "刷题"
tags = ["C++", "剑指offer", "牛客网"]
description = ""
+++



#### T7：斐波那契数列
> 大家都知道斐波那契数列，现在要求输入一个整数n，请你输出斐波那契数列的第n项。
n<=39

斐波那契数列是很常用的数列，也是很简单的递归能够解决的，但是当n稍微大一点的时候，复杂度都让人无法接受。
例如：
```
long long Fi(int n){
    if(n==0)
        return 0;
    if(n==1)
        return 1;
    return Fi(n-1)+Fi(n-2);
}
```
这样出现的问题主要是在递归的过程中会出现很多重复的计算，比如我们每次计算第n个的时候，都需要重新计算前面的n-1和n-2，这样每个值其实都会被计算两遍。简单的处理是：从下往上开始算，从第0个一直算到第n个。
代码如下：
```
class Solution {
public:
    int Fibonacci(int n) {
        if(n<=0)
            return 0;
        if(n==1||n==2)
            return 1;
        int newNum=1;
        int oneNum=1,twoNum=1;
        for(int i=3;i<=n;++i){
            newNum=oneNum+twoNum;
            oneNum=twoNum;
            twoNum=newNum;
        }
        return newNum;
    }
};
```

#### T8：跳台阶
> 一只青蛙一次可以跳上1级台阶，也可以跳上2级。求该青蛙跳上一个n级的台阶总共有多少种跳法。

该类问题其实就是斐波那契数列的应用：考虑第一次跳的情况，如果第一跳1级，那么后面就是n种情况，如果第一次跳2级，后面就是n-2种，于是：`f(n)=f(n-1)+f(n-2)`；同理：
```
class Solution {
public:
    int jumpFloor(int number) {
        if(number<=0)
            return 0;
        int result=0;
        if(number==1)
            return 1;
        int first_step=1;
        int second_step=1;
        while(number>=2){
            --number;
            result=first_step+second_step;
            first_step=second_step;
            second_step=result;
        }

        return result;
    }
};
```

#### T9：变态跳台阶
> 一只青蛙一次可以跳上1级台阶，也可以跳上2级……它也可以跳上n级。求该青蛙跳上一个n级的台阶总共有多少种跳法。

同样的分析：1.把第n级和第n-1级看成一级，则有：f(n-1)种；2.把第n级和第n-1级分开，则到n-1级有：f(n-1)，n-1级到第n级只有一种，所以加起来是：2*f(n-1)
代码如下：
```
class Solution {
public:
    int jumpFloorII(int number) {
        if(number<=0)
            return 0;
        int result=1;
        if(number==1)
            return 1;
        for(int i=1;i<=number-1;++i){
            result*=2;
            }
        return result;

    }
};
```
