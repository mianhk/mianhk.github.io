+++
title = "牛客网-剑指offer-2"
date = "2017-10-27T19:50:52+08:00"
categories = ["刷题"]
tags = ["C++", "剑指offer", "牛客网"]
description = ""
+++



#### T4：重建二叉树
> 输入某二叉树的前序遍历和中序遍历的结果，请重建出该二叉树。假设输入的前序遍历和中序遍历的结果中都不含重复的数字。例如输入前序遍历序列{1,2,4,7,3,5,6,8}和中序遍历序列{4,7,2,1,5,3,8,6}，则重建二叉树并返回。输入某二叉树的前序遍历和中序遍历的结果，请重建出该二叉树。假设输入的前序遍历和中序遍历的结果中都不含重复的数字。例如输入前序遍历序列{1,2,4,7,3,5,6,8}和中序遍历序列{4,7,2,1,5,3,8,6}，则重建二叉树并返回。

二叉树是觉得很烦的东西了，比链表复杂很多，看着头都有点疼啊，但是没办法，生活就是这样，只有把不会的会了才会进步，怕的变得不怕才能越来越厉害。
常规的理解一下：二叉树的遍历序列分为三种：前序遍历、中序遍历和后序遍历。这样叫是根据根节点相对于其左右子节点而言的。所以很容易知道三种遍历序列的特点，比如对于前序遍历而言，第一个就是根节点，对于中序遍历，根节点的左边必然是左子树，右边为右子树。所以首先可以根据两个序列确定根节点，然后把两个序列都分别分为两个序列，两个左右子树的前序遍历和两个左右子树的后序遍历。于是便可以采用递归的方式分别对左右子树进行处理了。
代码如下：
```
/**
 * Definition for binary tree
 * struct TreeNode {
 *     int val;
 *     TreeNode *left;
 *     TreeNode *right;
 *     TreeNode(int x) : val(x), left(NULL), right(NULL) {}
 * };
 */
class Solution {
public:
    TreeNode* reConstructBinaryTree(vector<int> pre,vector<int> vin) {
        if(pre.size()==0||vin.size()==0||pre.size()!=vin.size())
            return nullptr;
        TreeNode *root=new TreeNode(pre[0]);
        vector<int> pre1,pre2,vin1,vin2;
        int i=0;
        for(;i!=vin.size();++i){
            if(root->val==vin[i]){
                break;
            }
        }
        //if(i==0)
            //root->left=nullptr;
        //else if(i==vin.size()-1)
            //root->right=nullptr;
        //else{
        for(int j=0;j<i;++j){
            pre1.push_back(pre[1+j]);
            vin1.push_back(vin[j]);
            }
        for(int j=i+1;j<vin.size();++j){
            pre2.push_back(pre[j]);
            vin2.push_back(vin[j]);
            }
        root->left=reConstructBinaryTree(pre1,vin1);
        root->right=reConstructBinaryTree(pre2,vin2);
        //}

        return root;
    }
};
```

#### T5:用两个栈实现队列
> 用两个栈来实现一个队列，完成队列的Push和Pop操作。 队列中的元素为int类型。

对于这种简单的结构，实现起来可能还是比较简单一点，主要还是思考的过程，通过队列和栈的特点进行分析。队列是一个先进先出的结构，而栈是一个先进后出的结构。显然当我们把数据push到第一个栈，每次数据pop都把第一个栈的全部数据先放到第二个栈当中，然后再pop，肯定就达到了先入先出的目的了。
另外需要的是代码的编写。
代码如下：
```
class Solution
{
public:
    void push(int node) {
        stack1.push(node);
    }

    int pop() {
        if(stack2.size()<=0){
            while(stack1.size()>0){
                int temp=stack1.top();
                stack1.pop();
                stack2.push(temp);
            }
        }
        int result=stack2.top();
        stack2.pop();

        return result;
    }

private:
    stack<int> stack1;
    stack<int> stack2;
};
```

#### T6：旋转数组的最小数字
> 把一个数组最开始的若干个元素搬到数组的末尾，我们称之为数组的旋转。 输入一个非递减排序的数组的一个旋转，输出旋转数组的最小元素。 例如数组{3,4,5,1,2}为{1,2,3,4,5}的一个旋转，该数组的最小值为1。 NOTE：给出的所有元素都大于0，若数组大小为0，请返回0。

对于数组或者双链表的问题，很多时候我们都可以采用** 双指针**的方法来解决，这通常能减小难度，就像这题，首先我们需要注意的是，旋转数组的特点，旋转之前是一个非递减排序，所以旋转之后必然是前面一个非递减排序加上后半部分的一个非递增排序。很容易想到的是，采用前后两个指针，根据两个指针中间的点的值，可以确定这个数组中最小的值在前半部分还是后半部分，然后移动某一指针到中间节点，知道两个指针之间相差1，就可以确定最小值。
然而，看题目还存在一个问题，就是题目所说的是一个非递减排序，而并非递增序列。（这就需要我们认真审题了），可以想到，如果出现了特殊的情况，例如存在几个相等值，导致左右两个指针和中间值都相同的时候，我们只能通过最原始的办法一个个进行判断了。
代码如下：
```
class Solution {
public:
    int minNumberInRotateArray(vector<int> rotateArray) {
        if(rotateArray.size()<=0)
            return 0;
        int index1=0;
        int index2=rotateArray.size()-1;
        int indexMid=index1;
        while(rotateArray[index1]>=rotateArray[index2]){
            if(index2-index1==1){
                indexMid=index2;
                break;
            }
            indexMid=index1+(index2-index1)/2;
            if(rotateArray[index1]==rotateArray[indexMid]&&
               rotateArray[indexMid]==rotateArray[index2])
                return MinInorder(rotateArray);
            if(rotateArray[indexMid]>=rotateArray[index1])
                index1=indexMid;
            else if(rotateArray[indexMid]<=rotateArray[index2])
                index2=indexMid;
        }
        return rotateArray[indexMid];
    }

    int MinInorder(vector<int> rotateArray){
        int result=rotateArray[0];
        int index2=rotateArray[1];
        while(index2!=rotateArray.size()){
            if(result>rotateArray[index2])
                result=rotateArray[index2++];
            else
               ++index2;
               }
        return result;
    }
};
```

