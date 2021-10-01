+++
title = "牛客网刷题总结-剑指offer(1)"
date = "2017-10-15T21:26:46+08:00"
categories = ["刷题"]
tags = ["C++", "剑指offer", "牛客网"]
description = ""
+++

> 说在前面：刷题真的是一件残酷的事情，就好比以前大学的时候只剩两天就考试了，刚刚看了一遍就开始先做题一样的感觉，面对无数的套路，幸运的时候还能庆幸自己能发现他们的套路。。
刷题的开始总是艰难的，希望有一天我能以上帝视角看清这些芸芸众生的时候，还能想起来当年我不止一次的一道题怼了一晚上照样白怼。


#### T1：二维数组的查找
> 在一个二维数组中，每一行都按照从左到右递增的顺序排序，每一列都按照从上到下递增的顺序排序。请完成一个函数，输入这样的一个二维数组和一个整数，判断数组中是否含有该整数。



这里一般的思路肯定是，从行或者列开始找，根据递增的顺序，找到行或者列之后再判断列或者行，知道找到为止。最好的方法是，从左下角或者右上角开始找。原因是：这样的一行和一列的顺序是不一样的，这样我们找一行的时候没有就可以直接找下一行，充分利用递增的顺序，减少循环的次数。
其他的就是循环的写法了，关于数组，一定注意的是不要越界，这真的是我的痛啊，日常越界一百遍。_^_^_
```
class Solution {
public:
    bool Find(int target, vector<vector<int> > array) {
        bool found=false;
        if(array.size()==0 ||array[0].size()==0)
            return found;
        for(int i=array[0].size()-1;i>=0;--i){
            if(target>=array[0][i]){
                for(int j=0;j!=array.size();++j){
                    if(target==array[j][i])
                        found=true;
                }
            }
            else
                continue;
        }
        return found;
    }
};
```

#### T2：替换空格
> 请实现一个函数，将一个字符串中的空格替换成“%20”。例如，当字符串为We Are Happy.则经过替换之后的字符串为We%20Are%20Happy。


替换的过程是，先找到这个空格，正常想法是，从前往后找，然后遇到就开始替换。但是注意到*对于一般题目，最直观的解法总不是最好的*，都是需要多从**时间复杂度和空间复杂度想一想**。就这个题目而言，直接从前往后替换，因为替换后的字符比原来多2个，所以每次替换我们都需要将后面的字符串向后移2个，这无疑会增加复杂度。一个很好的办法是：先统计空格的个数，计算出替换后的字符串长度，然后从后往前开始替换，这样就减少了移动的复杂度。
```
class Solution {
public:
    void replaceSpace(char *str,int length) {
        if(length<=0)
            return;
        int move_length=0;
        int original_length=0;
        for(int i=0;str[i]!='\0';++i){
            ++original_length;
            if(str[i]==' ')
                ++move_length;
        }
        int new_length=original_length+2*move_length;
        if(new_length>length)
            return;
        str[new_length]='\0';
        while(original_length>0){
            --original_length;
            if(str[original_length]==' '){
                str[--new_length]='0';
                str[--new_length]='2';
                str[--new_length]='%';
            }
            else
                str[--new_length]=str[original_length];
        }

    }
};
```


#### T3:从尾到头打印链表
> 输入一个链表，从尾到头打印链表每个节点的值。

链表我们一般都是从头到尾处理的，要从尾到头打印，这里想到一个数据结构：**栈**，后入先出的特点。从头到尾遍历链表，并把节点的值存入栈中，再从栈一一弹出即可。
```
/**
*  struct ListNode {
*        int val;
*        struct ListNode *next;
*        ListNode(int x) :
*              val(x), next(NULL) {
*        }
*  };
*/
class Solution {
public:
    vector<int> printListFromTailToHead(ListNode* head) {
        stack<int> stack;
        vector<int> result;
        while(head!=nullptr){
            stack.push(head->val);
            head=head->next;
        }
        while(stack.size()!=0){
            result.push_back(stack.top());
            stack.pop();
        }
        return result;
    }
};
```
