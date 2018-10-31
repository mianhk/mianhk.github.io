---
title: LeetCode-31-Next-Permutation
date: 2018-01-12 17:26:20
categories: 刷题
tags: [C++,LeetCode]
---
### LeetCode-31-Next-Permutation

> Implement next permutation, which rearranges numbers into the lexicographically next greater permutation of numbers.
If such arrangement is not possible, it must rearrange it as the lowest possible order (ie, sorted in ascending order).
The replacement must be in-place, do not allocate extra memory.

这个排序主要是有两种情况，一个是类似于`3 1 2 `这样的情况，直接从后往前找到第一个`nums[i]<nums[i-1]`的，然后把`i`记下来，再与后面第一个小于`i`的`k`调换顺序之后，对`i`后面的进行反转排序就好了。
另一种情况是：已经反转成功了，类似`3 2 1`，需要直接置为最开始的状态，处理方式是，依旧从后往前找`i`,如果没有找到的话，就可以直接将序列反转即可。
代码如下：
```
class Solution {
public:
    void nextPermutation(vector<int>& nums) {
        int k=-1;
        for(int i=nums.size()-2;i>=0;--i){
            if(nums[i]<nums[i+1]){
                k=i;
                break;
            }
        }
        if(k==-1){
            reverse(nums.begin(),nums.end());
            return;
        }
        int l=0;
        for(int i=nums.size()-1;i>k;--i){
            if(nums[i]>nums[k]){
                l=i;
                break;
            }
        }
        swap(nums[l],nums[k]);
        reverse(nums.begin()+k+1,nums.end());
    }
};
```
