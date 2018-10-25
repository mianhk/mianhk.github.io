---
title: Leetcode-48-Rotate-Image
date: 2018-01-25 20:44:32
categories: 刷题
tags: [C++,LeetCode]
---
### Leetcode-48-Rotate-Image
> ou are given an n x n 2D matrix representing an image.
Rotate the image by 90 degrees (clockwise).
Note:
You have to rotate the image in-place, which means you have to modify the input 2D matrix directly. DO NOT allocate another 2D matrix and do the rotation.

Example :
```
Given input matrix =
[
  [1,2,3],
  [4,5,6],
  [7,8,9]
],

rotate the input matrix in-place such that it becomes:
[
  [7,4,1],
  [8,5,2],
  [9,6,3]
]

Given input matrix =
[
  [ 5, 1, 9,11],
  [ 2, 4, 8,10],
  [13, 3, 6, 7],
  [15,14,12,16]
],

rotate the input matrix in-place such that it becomes:
[
  [15,13, 2, 5],
  [14, 3, 4, 1],
  [12, 6, 8, 9],
  [16, 7,10,11]
]
```

这个乍一看觉得不难，但是写的时候又不知道怎么回事，其实旋转，对于我们写程序来说，其实就是不停的调换位置，但是怎么调换是个问题。

观察发现，第一个矩阵，最角上的四个1,3,7,9。转完之后，还是这四个数字，只不过是位置变了，接下来这样的四个是：2,4,6,8.最后一个5.再看一下4x4的其实也差不多。

所以想法就是直接每次四个数字进行换，换三次，就能换回来，然后进行下一次调换。
代码如下：

```
class Solution {
public:
    void rotate(vector<vector<int>>& matrix) {
        if(matrix.size()<=0)
            return;
        int a=0,b=matrix.size()-1;
        while(a<b){
            for(int i=0;i<b-a;++i){
                swap(matrix[a][a+i],matrix[a+i][b]);
                swap(matrix[a][a+i],matrix[b][b-i]);
                swap(matrix[a][a+i],matrix[b-i][a]);
            }
            ++a;
            --b;
        }
    }
};
```
