+++
title = "LeetCode-8-String to Integer (atoi)"
date = "2018-01-09T22:24:41+08:00"
categories = ["刷题"]
tags = ["C++", "LeetCode"]
description = ""
+++

### 8.String to Integer (atoi)
> Implement atoi to convert a string to an integer.

讲字符串转化为整型。当然过程很简单，但是需要考虑的乱七八糟的情况很多，空格和正负号之类的。提交了一百次，终于过了，但是看到别人的代码还是很气呀，还是得多写才行，但是起码写的慢慢有感觉了是吧。
总体思路基本都是差不多的：
1.循环字符串，从第一个开始不为空的字符开始判断，如果是正负号，则只能有一个正负号，进行标记，数字开始。
2.数字开始之后，出现空格或者字母，返回已经生成的整型。
3.当数字大于最大的整数或者小于最小的整数的时候，应该将其置为最大或者最小。所以这里应该将结果定义为long long int ，不然当加到INT_MAX的时候，会自动+1，置为INT_MIN，应该避免这样的情况。
这里贴一下自己改的乱七八糟的代码吧，实在很气呀。
```
class Solution {
public:
    int myAtoi(string str) {
        int flag=1;
        long long int res=0;
        int begin=-1;
        for(int i=0;i<str.size();++i){
            if(str[i]=='-'||str[i]=='+'){
                if(begin!=-1)
                    return 0;
                begin=i;
                flag=str[i]=='-'?-1:1;
            }
            else if(str[i]>='0'&&str[i]<='9'){
                begin=i;
                res=res*10+str[i]-48;
                if(res*flag>INT_MAX)
                    return INT_MAX;
                if(res*flag<INT_MIN)
                    return INT_MIN;
            }
            else if(str[i]==' '){
                if(begin!=-1)
                    return res*flag;
            }
            else
                return res*flag;
        }
        return res*flag;
    }
};
```

提交一看，这个时间还有点问题，就懒得自己再改了，思路都是一样的吧，就直接贴过来学习一下了，即使我觉得写的也一般呀。。
```
class Solution {
public:
    int myAtoi(string str) {
        int i = 0;
        long long res = 0;
        if(str.size() == 0)
            return res;

        while(i < str.size() && str[i] == ' ')
            i++;

        int flag = 1;
        if(str[i] == '+')
            i++;
        else if(str[i] == '-')
        {
            flag = -1;
            i++;
        }

        while(str[i] >= '0' && str[i] <= '9')
        {
            res = res * 10 + str[i] - '0';
            i++;
        if(res * flag >= INT_MAX)
            return INT_MAX;
        if(res * flag <= INT_MIN)
            return INT_MIN;
        }


        return res * flag;
    }
};
```

