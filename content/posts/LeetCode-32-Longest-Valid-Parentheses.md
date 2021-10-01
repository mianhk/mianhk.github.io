+++
title = "LeetCode-32-Longest-Valid-Parentheses"
date = "2018-01-12T17:28:31+08:00"
categories = ["刷题"]
tags = ["C++", "LeetCode"]
description = ""
+++

### LeetCode-32-Longest-Valid-Parentheses

> Given a string containing just the characters '(' and ')', find the length of the longest valid (well-formed) parentheses substring.
For "(()", the longest valid parentheses substring is "()", which has length = 2.
Another example is ")()())", where the longest valid parentheses substring is "()()", which has length = 4.

表示这是一道没有看懂题目的题，看到题目的难度是hard，但是自己的想法很简答，以为直接一个栈就可以了。。 too young啊

提交之后才知道，原来还要解决类似`()((()))`这类问题，所以这是一个动态规划的问题啊。
昨天看了一下动态规划，我们首先要构建D数组，如下所示的`vector longest`，负责存下当前第i个的长度。需要考虑的情况如下。
只有当s[i]为`)`时，才需要判断，如果它的左边是`(`或者`)`的情况。
代码如下：
```
class Solution {
public:
    int longestValidParentheses(string s) {
        if(s.length()<=1)
            return 0;
        vector<int > longest(s.size(),0);
        int curMax=0;
        for(int i=1;i<s.length();++i){
            if(s[i]==')'){
                if(s[i-1]=='('){
                    longest[i]=(i-2>=0?(longest[i-2]+2):2);
                    curMax=curMax>longest[i]?curMax:longest[i];
                }
                else {
                    if(i-longest[i-1]-1>=0&&s[i-longest[i-1]-1]=='('){
                        longest[i]=longest[i-1]+2+((i-longest[i-1]-2>=0)?longest[i-longest[i-1]-2]:0);
                        curMax=curMax>longest[i]?curMax:longest[i];
                    }
            }
            }
        }
        return curMax;
    }
};
```
