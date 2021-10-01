+++
title = "LeetCode-55-Jump-Game"
date = "2018-01-30T15:39:55+08:00"
categories = ["刷题"]
tags = ["C++", "LeetCode"]
description = ""
+++

### LeetCode-55-Jump-Game
> Given an array of non-negative integers, you are initially positioned at the first index of the array.
Each element in the array represents your maximum jump length at that position.
Determine if you are able to reach the last index.

For example:
```
A = [2,3,1,1,4], return true.

A = [3,2,1,0,4], return false.
```

由题可知，数组的位置表示从该位置可以像前跳的步数，看最终能否跳到结尾。乍一看，这像是一个动态规划的问题，dp数组内存储每一个位置能够走的最远的位置，但是仔细一想，又是没有必要的，因为最终的目的不是为了判断哪一个位置能走的更远，而是能否到达最后一个位置。
能到达最后一个位置的必要条件，显然一个就是能从某一位置继续往前走，而不会断。例如：`[3,2,1,0,4]`，我们都能走到第4个位置，但是却无法继续往前走，故到不了最后一个。所以代码可以做一个判断。
另一个需要考虑的问题是：在从前往后遍历的过程中，维护哪一个变量？显然这个变量记录的是我们能走的最远的距离，如果这个距离走的更远就更新，直到不能继续往前走，此时判断能否到终点。

贴上代码：
```
class Solution {
public:
    bool canJump(vector<int>& nums) {
        int i=0;
        for(int reach=0;i<nums.size()&&i<=reach;++i)
            reach=max(reach,i+nums[i]);
        return i==nums.size();
    }
};
```
