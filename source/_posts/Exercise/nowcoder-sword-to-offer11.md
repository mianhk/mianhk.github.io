---
title: 牛客网-剑指offer-11
date: 2017-12-03 20:44:21
categories: 刷题
tags: [C++,剑指offer,牛客网]
---
#### T31：把数组排成最小的数
> 输入一个正整数数组，把数组里所有数字拼接起来排成一个数，打印能拼接出的所有数字中最小的一个。例如输入数组{3，32，321}，则打印出这三个数字能排成的最小数字为321323。

这里想到的是，要对数组里面的所有数进行一个排序：不只是排长度，还要排最高位的大小。于是可以通过c++的STL的排序，通过自己定义的一个谓语比较函数。在这个比较函数里，把整数转成string进行比较，但是想到string的长度不一样的话也没法比较字符的大小了。所以分别将两个数加在一起，前后顺序不同，这样string的长度就一样了，比较的就是顺序了。
代码如下：
```
class Solution {
public:
    string PrintMinNumber(vector<int> numbers) {
        string result;
        sort(numbers.begin(),numbers.end(),cmp);
        for(int i=0;i!=numbers.size();++i){
            result+=to_string(numbers[i]);
        }
        return result;
    }

    static bool cmp(int a,int b){
        string A=to_string(a)+to_string(b);
        string B=to_string(b)+to_string(a);
        return A<B;
    }
};
```
#### T32：丑数
> 把只包含因子2、3和5的数称作丑数（Ugly Number）。例如6、8都是丑数，但14不是，因为它包含因子7。 习惯上我们把1当做是第一个丑数。求按从小到大的顺序的第N个丑数。

要求出第N个丑数，显然就要求到这N个，所以就要把所有的找出来嘛。简单的办法，就是2,3，5的倍数，但是这些倍数出来的丑数的顺序，这时候需要排序。显然不能直接对所有的都排序，那复杂度就太大了。这里一种考虑就是：比如，对于一次倍数的计算，如果2的倍数比原来的都大，那么3和5的倍数显然只会更大了。所以可以通过记录下此时分别为2,3,5倍数三个值，这样就可以减少比较的次数了。
代码如下：
```
class Solution {
public:
    int GetUglyNumber_Solution(int index) {
        if(index==0)
            return 0;  //解决边界条件
        vector<int> result(index);
        result[0]=1;
        int x=0,y=0,z=0,i;
        for(i=1;i<index;i++){
            result[i]=min(result[x]*2,min(result[y]*3,result[z]*5));
            if(result[i]==result[x]*2)
                x++;
            if(result[i]==result[y]*3)
                y++;
            if(result[i]==result[z]*5)
                z++;
        }
        return result[index-1];
    }
};
```

#### T33：第一个只出现一次的字符
> 在一个字符串(1<=字符串长度<=10000，全部由字母组成)中找到第一个只出现一次的字符,并返回它的位置

很容易想到的一种复杂度为O(n)的算法是采用哈希表，遍历一次，将出现的字符放在键中，出现一次即在值中加1。第二次遍历，直接查找该键对应的值，第一个为1的输出即可。当然，这里由于是字符，所以可以直接采用数组的形式。** 一定要记得对数组进行初始化**
```
class Solution {
public:
    int FirstNotRepeatingChar(string str) {
        if(str.size()==0)
            return -1;        //处理边界条件
        int res[256]={0};  //局部变量，一定要初始化啊
        int i=0;
        for(;i!=str.size();++i){
            res[(int)str[i]]++;
        }
        for(i=0;i!=str.size();++i){
            if(res[(int)str[i]]==1)
                return i;
        }
        return str.size();
    }
};
```

