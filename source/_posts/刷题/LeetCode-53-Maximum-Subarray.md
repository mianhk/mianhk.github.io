---
title: LeetCode-53-Maximum-Subarray
date: 2018-01-26 17:57:03
categories: 刷题
tags: [C++,LeetCode]
---
## LeetCode-53-Maximum-Subarray
> Find the contiguous subarray within an array (containing at least one number) which has the largest sum.
For example, given the array [-2,1,-3,4,-1,2,1,-5,4],
the contiguous subarray [4,-1,2,1] has the largest sum = 6.

最长子序列，又是一个动态规划的问题，关于动态规划，我们最主要的是要维护DP数组，这个问题以前还有点不理解，感觉主要的还是思想，只要知道这是一个动态规划的问题，解决动态规划的一般方法掌握了，其他的就都是细节了。

最近刷算法题，不得不想到的是以前的数学，数学是逻辑性可能更强的东西，尚且需要多做练习才行，何况算法了。当然现在慢慢的感觉就是，以前看到很多题完全没有头绪，现在很多大概是能分清是想考啥了，也会想着主动去选择相应的数据结构。
```
class Solution {
public:
    int maxSubArray(vector<int>& nums) {
        vector<int> dp(nums.size(),0);
        dp[0]=nums[0];
        int res=dp[0];
        for(int i=1;i<nums.size();++i){
            dp[i]=nums[i]+(dp[i-1]>0?dp[i-1]:0);
            res=max(dp[i],res);
        }
        return res;
    }
};
```

