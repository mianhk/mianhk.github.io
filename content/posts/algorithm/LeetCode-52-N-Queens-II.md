+++
title = "LeetCode-52-N-Queens-II"
date = "2018-01-26T17:00:24+08:00"
categories = ["刷题"]
tags = ["C++", "LeetCode"]
description = ""
+++

### LeetCode-52-N-Queens-II
> Follow up for N-Queens problem.
Now, instead outputting board configurations, return the total number of distinct solutions.

只返回N皇后问题结果的种数。
因此不需要每一个字符串置位了，只需要判断一个位置的横竖，斜45度和斜135度方向的值即可。依然采用递归的方式，这里需要注意的是，由于是对列递归，所以需要考虑的是行，斜45度，斜135度，本来是要维护一个一维数组和两个二维数组，但是想到二维数组的特征，可以改为维护三个一维数组，这两个一维数组保存的是将二维数组展开的信息。甚至是一波操作改为共维护两个一维数组也可以。
接下来是代码：
```
class Solution {
public:
    int totalNQueens(int n) {
        vector<int> rows(n),d1(2*n-1),d2(2*n-1);
        return find(n,n,0,rows,d1,d2);
    }

    int find(int n,int left,int i,vector<int>& rows,vector<int>& d1,vector<int>& d2){
        if(left==0)
            return 1;
        int j,sum=0;
        for(j=0;j<n;++j){
            if(rows[j]||d1[i+j]||d2[n-1+i-j])
                continue;
            rows[j]=d1[i+j]=d2[n-1+i-j]=1;
            sum+=find(n,left-1,i+1,rows,d1,d2);
            rows[j]=d1[i+j]=d2[n-1+i-j]=0;
        }
        return sum;
    }
};
```

看了一下别人的好像确实快一点，毕竟0ms啊，也贴一下别人的代码吧：
```
class Solution {
public:
    int totalNQueens(int n) {
        bool flag[5*n] = {false};
        int num = 0;
        dfs(num,flag,0,n);
        return num;
    }

    void dfs(int& num, bool* flag, int row, int n){
        if(row == n){
            ++num;
            return;
        }
        for(int i = 0; i<n;i++){
            if(!flag[i] && !flag[row+i+n] && !flag[4*n + row - i]){
                flag[i] = 1;
                flag[row+i+n] = 1;
                flag[4*n + row - i] = 1;
                dfs(num,flag,row+1,n);
                flag[i] = 0;
                flag[row+i+n] = 0;
                flag[4*n + row - i] = 0;
            }
        }
    }
};
```

#### reference:
https://discuss.leetcode.com/topic/13617/accepted-4ms-c-solution-use-backtracking-and-bitmask-easy-understand
