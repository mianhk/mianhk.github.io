---
title: LeetCode-36-Valid-Sudoku
date: 2018-01-14 21:53:42
categories: 刷题
tags: [C++,LeetCode]
---
### LeetCode-36-Valid-Sudoku
> Determine if a Sudoku is valid, according to: Sudoku Puzzles - The Rules.
The Sudoku board could be partially filled, where empty cells are filled with the character '.'.
<div align="center"> <img src="http://blog-1252063226.cosbj.myqcloud.com/network/001.jpg" /> </div><br>


判断一个二维数组是不是数独数组。要求是：同行同列，斜对角不能有相同的数组，这里需要定义三个数组，当然参考了一下讨论区一个大神的代码。采用行列，竖列和斜列。其中比较惊艳的是k=i/3*3+j/3;这里可以直接得到斜对角的元素。

```
class Solution {
public:
    bool isValidSudoku(vector<vector<char>>& board) {
        int used1[9][9]={0},used2[9][9]={0},used3[9][9]={0};
        for(int i=0;i<board.size();++i){
            for(int j=0;j<board[i].size();++j){
                if(board[i][j]!='.'){
                    int num=board[i][j]-'0'-1,k=i/3*3+j/3;
                    if(used1[i][num]||used2[j][num]||used3[k][num])
                        return false;
                    used1[i][num]=used2[j][num]=used3[k][num]=1;
                }
            }
        }
        return true;
    }
};
```



#### reference:
http://blog.csdn.net/u012050154/article/details/51541380
