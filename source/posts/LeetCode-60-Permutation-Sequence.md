+++
title = "LeetCode-60-Permutation-Sequence"
date = "2018-02-06T17:32:24+08:00"
categories = "刷题"
tags = ["C++", "LeetCode"]
description = ""
+++

### LeetCode-60-Permutation-Sequence
> The set [1,2,3,…,n] contains a total of n! unique permutations.
By listing and labeling all of the permutations in order,
```
We get the following sequence (ie, for n = 3):

"123"
"132"
"213"
"231"
"312"
"321"
Given n and k, return the kth permutation sequence.
```

同样是排列 组合的问题，这次不需要打印所有的排列了，只需要按照排列的顺序打印出第k个，很显然，思路不会是列出所有的排列，然后找第k个打印出来是吧。

观察来看，以`1,2,3,4`为例，有`4*3*2*1=24`种排列，其中根据排列的顺序，按照第一个数字可以分为以下4种：
```
1 * * *

2 * * *

3 1 2 4
3 1 4 2
3 2 1 4
3 2 4 1
3 4 1 2
3 4 2 1

4 * * *
#### 方法一
```
* 第一个数
可以看出，当k=14时，第一个数字为3,这个是可以通过计算的。由于是从1开始的，取k=13；`index=k/(n-1)!=13/3!=2`，于是可以知道第一个数是3。那么第二个数字呢?
```
1+permutation(2,4)
2+permutation(1,4)
4+permutation(1,2)
```
* 第二个数
可以根据:`k=k-index_pre*(n-1)!=13-2*3!=1`;
`index=k/(n-2)!=1/(4-2)!=0`于是第二个数为1。
* 第三个数
接下来就只剩下2和4了，继续:`k=k-index_pre*(n-2)!=1-0*(4-2)!=1`,  `index=k/(n-3)!=1/(4-3)!=1`在此处表示为4.之后再确定最后一个:
* 第四个数
`k=k-index_pre*(n-4)!=1-1*(4-4)=0`;
`index=k/(n-4)!=0/(4-4)!=0` 故第四个数为2

到了这里，思路就比较清晰了。我们需要做的是从第一个一直到最后一个的循环，每次选出一个数，但是还需要将该数从原来的数组中剔除掉，因为前面选过的后面就不能排列了。

#### 方法二：
其实原理差不多，也还是根据排列的规律。只不过算的方法不一样。
1. j=i+k/(n-i)!;
2. 删除s[j];
3. k=k%(n-i);
4. s[i]=s[j];
代码如下：

```
class Solution {
public:
    string getPermutation(int n, int k) {
        if(n<=0)
            return " ";
        int i,j,f=1;
        string s(n,'0');
        for(i=1;i<=n;i++){
            f*=i;
            s[i-1]+=i;
        }
        for(i=0,k--;i<n;++i){
            f/=n-i;
            j=i+k/f;
            char c=s[j];
            for(;j>i;j--)
                s[j]=s[j-1];
            k%=f;
            s[i]=c;
        }
        return s;
    }
};
```
