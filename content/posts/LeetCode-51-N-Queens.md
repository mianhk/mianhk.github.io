+++
title = "LeetCode-51-N-Queens"
date = "2018-01-26T10:12:49+08:00"
categories = "刷题"
tags = ["C++", "LeetCode"]
description = ""
+++

### LeetCode-51-N-Queens
经典的N皇后问题，重点是全排列的问题，但是这里由于N皇后的不重复行、列、斜的要求，在排列的过程中，比如从行开始排列，只能保证同行不重复，所以需要引入isValid函数。通过判断列，左斜、右斜是否重复。

需要注意的是：关于全排列递归的写法，要更加熟练掌握才行，并且能完全理解，能够在不同的情况中灵活运用。其基本思想还是：固定前面的某个数字，不短的对后面进行交换。
```
class Solution {
public:
    bool isValid(vector<string>& queen, int row,int col,int n){
        for(int i=0;i<row;++i){
            if(queen[i][col]=='Q')
                return false;
        }
        for(int i=row-1,j=col-1;i>=0&&j>=0;--i,--j){
            if(queen[i][j]=='Q')
                return false;
        }
        for(int i=row-1,j=col+1;i>=0&&j<n;--i,++j){
            if(queen[i][j]=='Q')
                return false;
        }
        return true;
    }
    void recurse(vector<string>& queen,vector<vector<string>>& res,int row,int n){
        if(row==n){
            res.push_back(queen);
            return;
        }
        for(int col=0;col!=n;++col){
            if(isValid(queen,row,col,n)){
                queen[row][col]='Q';
                recurse(queen,res,row+1,n);
                queen[row][col]='.';
            }
        }
    }
    vector<vector<string>> solveNQueens(int n) {
        vector<vector<string>> res;
        vector<string> queen(n,string(n,'.'));
        recurse(queen,res,0,n);
        return res;
    }


};
```
