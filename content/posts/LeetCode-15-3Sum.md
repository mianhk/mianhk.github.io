+++
title = "LeetCode-15-3Sum&&4Sum"
date = "2018-01-10T21:57:08+08:00"
categories = ["刷题"]
tags = ["C++", "LeetCode"]
description = ""
+++

### 15. 3Sum
> Given an array S of n integers, are there elements a, b, c in S such that a + b + c = 0? Find all unique triplets in the array which gives the sum of zero.

```
Note: The solution set must not contain duplicate triplets.
For example, given array S = [-1, 0, 1, 2, -1, -4],

A solution set is:
[
  [-1, 0, 1],
  [-1, -1, 2]
]
```

同之前的2sum差不多，计算两个的和的方式是：为了避免重复，重新用一个set容器，解决重复的问题。但是这里的情况是，重复的一个数字是可以出现的，而且是三个数字相加的和，所以我们没法用之前的处理办法。

很容易想到的办法是，先让一个指针向前走，然后对之后的数字搜索，为了减少搜索的复杂度，我们可以先将数组进行排序，先排序后搜索，可以从O(n^2)的复杂度减小到nlog(n)，所以采用先排序。

然而这里需要注意的是，需要判断数组中有相同数字的情况。虽然结果中允许有相同的数字出现，但不允许出现完全相同的两个结果，所以需要处理这种情况。
具体的代码如下：

```
class Solution {
public:
    vector<vector<int>> threeSum(vector<int>& nums) {
        vector<vector<int>> res;
        if(nums.size()<=0)
            return res;
        sort(nums.begin(),nums.end());
        for(int i=0;i<nums.size()&&nums[i]<=0;++i){
            int j=i+1,k=nums.size()-1;
            while(j<k){
                    if(nums[i]+nums[j]+nums[k]<0)
                        j++;
                    else if(nums[i]+nums[j]+nums[k]>0)
                        --k;
                    else if(nums[i]+nums[j]+nums[k]==0){
                        vector<int> temp(3,0);
                        temp[0]=nums[i];
                        temp[1]=nums[j];
                        temp[2]=nums[k];
                        res.push_back(temp);
                        while(k>j&&nums[k]==temp[2]) //去除k的重复
                            k--;
                        while(k>j&&nums[j]==temp[1]) //去除j的重复
                            j++;
                    }
                }
                while(i+1<nums.size()&&nums[i+1]==nums[i])  //去除i的重复
                    i++;
            }
        return res;
    }
};
```


### 18. 4Sum
> Given an array S of n integers, are there elements a, b, c, and d in S such that a + b + c + d = target? Find all unique quadruplets in the array which gives the sum of target.

**Note **: The solution set must not contain duplicate quadruplets.

其实跟前面的3sum解决的办法是一样的，无非这里为了减少一点复杂度，借用了一下大家使用的方法。，在每次遍历的时候进行一点判断，以减少循环的次数。代码如下：

```
class Solution {
public:
    vector<vector<int>> fourSum(vector<int>& nums, int target) {
        vector<vector<int>> res;
        int n=nums.size();
        if(n<4)
            return res;
        sort(nums.begin(),nums.end());
        for(int i=0;i<n-3;++i){
            if(i>0&&nums[i]==nums[i-1]) continue;
            if(nums[i]+nums[i+1]+nums[i+2]+nums[i+3]>target) break;
            if(nums[i]+nums[n-1]+nums[n-2]+nums[n-3]<target) continue;
            for(int j=i+1;j<nums.size()-2;++j){
                if(j>i+1&&nums[j]==nums[j-1]) continue;
                if(nums[i]+nums[j]+nums[j+1]+nums[j+2]>target) break;
                if(nums[i]+nums[j]+nums[n-2]+nums[n-1]<target) continue;
                int begin=j+1,end=n-1;
                while(begin<end){
                    int sum=nums[i]+nums[j]+nums[begin]+nums[end];
                    if(sum>target)
                        --end;
                    else if(sum<target)
                        ++begin;
                    if(sum==target){
                        vector<int> temp(4,0);
                        temp[0]=nums[i];
                        temp[1]=nums[j];
                        temp[2]=nums[begin];
                        temp[3]=nums[end];
                        res.push_back(temp);
                        while(begin<end&&temp[2]==nums[begin])
                            ++begin;
                        while(begin<end&&temp[3]==nums[end])
                            --end;
                    }
                }
            }
        }
         return res;
    }
};
```
