

## 简单排序 O(n^2)
### 选择排序
index从0开始，从后面遍历选择最小的跟index换。因此复杂度为O(n^2);
```
template <typename  T>
void selectSort(T* arr,int n){
    for(int i=0;i<n;++i){
        int minIndex=i;
        for(int j=i+1;j<n;++j){
            if(arr[j]<arr[minIndex])
                swap(arr[j],arr[minIndex]);
        }
    }
}
```
### 插入排序
类似于扑克牌，只考虑index前面的数的顺序，当前面已经排好了，可以提前终止。
```
template <typename T>
void insertionSort(T arr[],int n){
    for(int i=1;i<n;++i){
        for(int j=i;j>0 && arr[j]<arr[j-1];--j){  //当前面已经排好序后可以提前结束
            swap(arr[j],arr[j-1]);
        }
    }
}
```
但是由于每次进行的都是通过swap函数进行交换，会更增加复杂度，所以看起来可能不是很快，所以可以进行一些改进。改进方案就是，提前记下元素应该存在的位置，用元素的后移代替交换。
```
template <typename T>
void insertionSort2(T arr[],int n){
    for(int i=1;i<n;++i){
        T ele=arr[i];   //提前记下元素
        int j;
        for(j=i;j>0&&arr[j-1]>ele;--j)
            arr[j]=arr[j-1];        //用左边移代替交换
        arr[j]=ele;     //将元素放在应该在的位置上
    }
}
```
从复杂度的角度来分析，插入排序也是O(n^2)，但是从程序可以看到，当前面已经排序之后，或者实际使用过程中，需要排序的元素是近乎排好的话，采用插入排序的效率可能比一些O(nlogn)的算法更高。  

### 冒泡排序
非常经典的排序了，C语言都会上的排序课。

### 希尔排序
由插入排序延伸而来。

## 高级排序 O(nlogn)

### 归并排序
二分法的思想，采用递归。需要O(n)的空间。
自顶向下的排序

自底向上的排序
可以对链表进行排序

### 快速排序


快速排序的问题和解决
1.在数据很少的时候，采用插入排序  
2.对于近乎于有序的数组，最差的情况退化为O(n^2)。每次选择的数可以随机。  
3.对于很多重复数字的数组。重写patition  

#### 三路快速排序


### 归并排序和快速排序
都使用了分治算法  
逆序对问题：采用归并排序
取数组中第n大的数
暴力解法



原地堆排序

索引堆



## 二分搜索树
### 二分查找
### 二分查找的变种
floor和ceil

### 二分搜索树
优势：高效：查找元素(O(logn)),插入元素(O(logn)),删除元素(O(logn))

#### 遍历
深度优先遍历:
前序遍历、中序遍历、后序遍历。  
广度优先遍历：按层遍历。维护一个队列  

#### 二分搜索树最小值和最大值

#### 二分搜索树的删除
- 删除最小值  
- 删除最大值  
- 删除任意节点

### 贪心算法
怎么判断什么时候使用贪心算法。
直觉反例。  
数学推导：数学归纳法、反证法。应用起来有点困难
贪心算法为A、最佳算法为O.如果 用A能完全替代O，且不影响求出最优解。
# 判断一个图是否连通
并查集

# 数据流中的中位数
最大堆，最小堆
