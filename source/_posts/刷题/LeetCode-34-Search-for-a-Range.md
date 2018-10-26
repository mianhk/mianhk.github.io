---
title: LeetCode-34-Search-for-a-Range
date: 2018-01-14 21:52:38
categories: 刷题
tags: [C++,LeetCode]
---
### LeetCode-34-Search-for-a-Range

> Given an array of integers sorted in ascending order, find the starting and ending position of a given target value.
Your algorithm's runtime complexity must be in the order of O(log n).
  If the target is not found in the array, return [-1, -1].

在一个排序的数组中找到出现这个值的起点和重点。很容易想到的是二分查找了。复杂度为`nlog(n)`。思路如下，先二分查找，找到下界，如果下界lo的值不等于target时，直接返回{-1，-1}，否则，直接将下界添加到res中。之后重置上界，同样的方法搜索上界。注意到，**由于每次循环中，我们只考虑了一个界，所以只有一个界能mid+1，否则就会出现相等的也被else处理了。写的时候就是这个问题没有考虑好，折腾了很久。**



```
class Solution {
public:
    vector<int> searchRange(vector<int>& nums, int target) {
        vector<int> res={-1,-1};
        if(nums.size()<=0)
            return res;
        int lo=0,hi=nums.size()-1;
        while(lo<hi){  //找下界
            int mid=(lo+hi)/2;
            if(nums[mid]<target)
                lo=mid+1;
            else
                hi=mid;
        }
        if((nums[lo]!=target)){
            return res;
        }
        else
            res[0]=lo;
        hi=nums.size()-1;
        while(lo<hi){  //找上界
            int mid=(lo+hi)/2+1;
            if(nums[mid]>target)
                hi=mid-1;
            else
                lo=mid;
        }
        res[1]=hi;
        return res;
    }
};
```


当然还看到有用stl的方法的，直接用lower_bound()和upper_bound()函数，速度要快一些。虽然觉得stl应该也是一样的原理写的吧。。
```
class Solution {
public:
    vector<int> searchRange(vector<int>& nums, int target) {
        if (nums.empty()) return{ -1, -1 };

    auto iter1 = lower_bound(nums.begin(), nums.end(), target);
    auto iter2 = upper_bound(nums.begin(), nums.end(), target);

    if (iter1 == nums.end()) return{ -1, -1 };

    if ((*iter1) != target) return{ -1, -1 };
    vector<int> tmp(2, 0);
    tmp[0] = iter1 - nums.begin();

    --iter2;
    tmp[1] = iter2 - nums.begin();
    return tmp;
    }
};
```
