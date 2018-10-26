---
title: 剑指offer-刷题总结
date: 2018-06-20 21:40:02 
categories: 刷题
tags: [C++,LeetCode,剑指offer]
---

## 01.二维数组中的查找 
> 在一个二维数组中，每一行都按照从左到右递增的顺序排序，每一列都按照从上到下递增的顺序排序。请完成一个函数，输入这样的一个二维数组和一个整数，判断数组中是否含有该整数。  

分析：由于每一行都有递增的特性，我们可以采用类似二分搜索的方法。将数组分成行列来进行搜索。
```
class Solution {
public:
    bool Find(int target, vector<vector<int> > array) {
        if(0==array.size())
            return false;
        int raw=array.size();
        int col=array[0].size();
        for(int i=0;i<raw;++i){
            if(array[i][col-1]>=target){
                for(int j=0;j<col;++j){
                    if(array[i][j]==target)
                        return true;
                }
            }
        }
        return false;
    }
};
```
## 02.替换空格
> 请实现一个函数，将一个字符串中的空格替换成“%20”。例如，当字符串为We Are Happy.则经过替换之后的字符串为We%20Are%20Happy。  

考虑到是在原字符串上操作，如果遇到一个空格就替换的话，需要把后面的都要后移两位，这个复杂度就大了，所以可以先遍历第一遍，找到空格的总数，之后就可以计算替换后的字符串长度。再经过第二遍遍历，从后往前开始替换，这样就不用移动了。

```
class Solution {
public:
	void replaceSpace(char *str,int length) {
         if(length<=0)
             return;
        int origin_length=0,new_length=0,space_num=0;
        for(int i=0;str[i]!='\0';++i){
            origin_length++;
            if(str[i]==' ')
                space_num++;
        }
        new_length=origin_length+2*space_num;
        if(new_length>length)
            return;
        str[new_length]='\0';
        while(origin_length>0){
            --origin_length;
            if(str[origin_length]==' '){
                str[--new_length]='0';
                str[--new_length]='2';
                str[--new_length]='%';
            }
            else{
                str[--new_length]=str[origin_length];
            }
        }
	}
};
```
## 03.从尾到头打印链表
> 输入一个链表，从尾到头打印链表每个节点的值。  

分析：由于链表我们必须从头到尾遍历才能从链表尾开始，所以直接打印的话，需要先从前往后遍历一遍找到链表尾节点，再从后往前遍历打印。能够进行的改善是，通过增加O(N)的空间复杂度，第一次遍历的时候，将数据放在一个栈中，之后再从栈中把所有的数都弹出来就好。
```
/**
*  struct ListNode {
*        int val;
*        struct ListNode *next;
*        ListNode(int x) :
*              val(x), next(NULL) {
*        }
*  };
*/
class Solution {
public:
    vector<int> printListFromTailToHead(ListNode* head) {
        vector<int> res;
        if(!head)
            return res;
        stack<int> istack;
        while(head){
            istack.push(head->val);
            head=head->next;
        }
        while(!istack.empty()){
            res.push_back(istack.top());
            istack.pop();
        }
        return res;
    }
};
```
## 04.重建二叉树
> 输入某二叉树的前序遍历和中序遍历的结果，请重建出该二叉树。假设输入的前序遍历和中序遍历的结果中都不含重复的数字。例如输入前序遍历序列{1,2,4,7,3,5,6,8}和中序遍历序列{4,7,2,1,5,3,8,6}，则重建二叉树并返回。  

分析：首先需要知道的是前序遍历和后续遍历的特点，程序中可以维护4个子数组，当进行递归调用。   
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
        if(pre.empty() || pre.size()!=vin.size())
            return nullptr;
        vector<int> pre1,pre2,vin1,vin2;
        TreeNode* root=new TreeNode(pre[0]);
        int i=0;
        for(;i<vin.size();++i){
            if(pre[0]==vin[i])
                break;
        }
        //不需要判断i ==0 或者i==vin.size()-1的情况
        for(int j=0;j<i;++j){
            pre1.push_back(pre[1+j]);
            vin1.push_back(vin[j]);
        }
        for(int j=i+1;j<pre.size();++j){
            pre2.push_back(pre[j]);
            vin2.push_back(vin[j]);
        }
        root->left=reConstructBinaryTree(pre1,vin1);
        root->right=reConstructBinaryTree(pre2,vin2);
        return root;
    }
};
```
不过上述的方法有个问题，虽然看起来比较好理解，但是增加了空间复杂度，其实这里可以多加一个递归函数就好了，所以觉得还是需要重新写一下。  
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
    TreeNode* recurse(vector<int>& pre,int begin1,int end1,vector<int >& vin,int begin2,int end2){
        if(begin1>end1 || begin2>end2)  //退出条件
            return nullptr;
        TreeNode* root=new TreeNode(pre[begin1]);
        for(int i=begin2;i<=end2;++i){
            if(pre[begin1]==vin[i]){
                root->left=recurse(pre,begin1+1,begin1+i-begin2,vin,begin2,i-1);  //递归的重点，这个要考虑清楚
                root->right=recurse(pre,begin1+1+i-begin2,end1,vin,1+i,end2);
                break;
            }
        }
        return root;
    }
    TreeNode* reConstructBinaryTree(vector<int> pre,vector<int> vin) {
        if(pre.empty() || pre.size()!=vin.size())
            return nullptr;
        return recurse(pre,0,pre.size()-1,vin,0,vin.size()-1);
    }
};
```
## 05.用两个栈实现队列
> 用两个栈来实现一个队列，完成队列的Push和Pop操作。 队列中的元素为int类型。  

分析：由于栈是先进后出，队列是先进先出，于是可以想到，两个栈，必然能够实现一个队列。原理就是，当push的时候就往第一个栈push，pop的时候就从第二个栈pop，当第二个栈的数为空时，从第一个栈pop再push到第二个栈。  
```
class Solution
{
public:
    void push(int node) {
        stack1.push(node);
    }

    int pop() {
        if(stack2.empty()){
            while(!stack1.empty()){
                stack2.push(stack1.top());
                stack1.pop();
            }
        }
        int top=stack2.top();
        stack2.pop();
        return top;
    }

private:
    stack<int> stack1;
    stack<int> stack2;
};
```
## 06.旋转数组的最小数字
> 把一个数组最开始的若干个元素搬到数组的末尾，我们称之为数组的旋转。 输入一个非递减排序的数组的一个旋转，输出旋转数组的最小元素。 例如数组{3,4,5,1,2}为{1,2,3,4,5}的一个旋转，该数组的最小值为1。 NOTE：给出的所有元素都大于0，若数组大小为0，请返回0。  

分析：对于排序的数组，即使被旋转过，也能想到的是，采用二分查找。不过可能会存在的问题的是：当整个数组的值都是`1 0 0 1 1`之类的时候，就会失效了，只是非递减，但是不一定递增。  
```
class Solution {
public:
    int minNumberInRotateArray(vector<int> rotateArray) {
        if(0==rotateArray.size()){
            return 0;
        }
        int begin=0,end=rotateArray.size()-1;
        while(begin<end-1){
            int mid=begin+(end-begin)/2;
            if(rotateArray[begin]<rotateArray[mid])
                begin=mid;
            else if(rotateArray[begin]>rotateArray[mid])
                end=mid;
            else{
                int res=begin;
                for(size_t i=1;i<rotateArray.size();++i){
                    res=(res<rotateArray[i]?res:rotateArray[i]);
                }
                return res;
            }
        }
        return rotateArray[end];
    }
};
```
## 07.斐波那契数列
> 大家都知道斐波那契数列，现在要求输入一个整数n，请你输出斐波那契数列的第n项。n<=39    
   
分析：斐波拉契数列原理很简单，不过按照原理写的显然复杂度过高了，这里我们可以采用变量存下之前计算过的数。  
```
class Solution {
public:
    int Fibonacci(int n) {
        if(n==0)
            return 0;
        if(n==1||n==2)
            return 1;
        int first=1,second=1,res=0;
        while(--n>1){
            res=first+second;
            first=second;
            second=res;
        }
        return res;
    }
};
```
## 08.跳台阶
> 一只青蛙一次可以跳上1级台阶，也可以跳上2级。求该青蛙跳上一个n级的台阶总共有多少种跳法。  

分析：原理同斐波拉契数列。  
```
class Solution {
public:
    int jumpFloor(int number) {
        if(number<=2)
            return number;
        int first=1,second=2,res=0;
        while(--number>1){
            res=first+second;
            first=second;
            second=res;
        }
        return res;
    }
};
```
## 09.变态跳台阶
> 一只青蛙一次可以跳上1级台阶，也可以跳上2级……它也可以跳上n级。求该青蛙跳上一个n级的台阶总共有多少种跳法。  

分析：
```
f(n)=f(1)+f(2)+...+f(n-1)
f(n+1)=f(1)+f(2)+...+f(n-1)+f(n)=2f(n)
//代码如下：
class Solution {
public:
    int jumpFloorII(int number) {
        if(number<=2)
            return number;
        int res=2;
        while(--number>=2){
            res*=2;
        }
        return res;
    }
};
```

## 10.矩形覆盖 /TODO:
## 11.二进制中1的个数
> 输入一个整数，输出该数二进制表示中1的个数。其中负数用补码表示。  

分析：如果一个整数不为0，那么这个整数至少有一位是1。如果我们把这个整数减1，那么原来处在整数最右边的1就会变为0，原来在1后面的所有的0都会变成1(如果最右边的1后面还有0的话)。其余所有位将不会受到影响。
```
class Solution {
public:
     int  NumberOf1(int n) {
         int count=0;
         while(n){
             count++;
             n=n&(n-1);
         }
         return count;
     }
};
```

## 12.数值的整数次方
> 给定一个double类型的浮点数base和int类型的整数exponent。求base的exponent次方。  

分析：求一个数的次方，一个就是幂数是负数的处理，另一个就是，对幂的处理，连乘必然带来复杂度，可以想到的是2^4可以表示为(2^2)^2，想到这里，考虑的开水奇偶exponent的奇偶性了，奇数的时候直接乘以base，偶数的时候自乘。  
```
class Solution {
public:
    double Power(double base, int exponent) {
        bool flag=true;
        if(exponent<0){
            flag=false;
            exponent*=-1;
        }
        double res=1;
        while(exponent){
            if(exponent&1){
                res*=base;
                exponent--;
            }
            else{
                exponent=exponent/2;
                res*=res;
            }
        }
        return flag?res:(1/res);
    }
};
```
## 13.调整数组顺序使奇数位于偶数前面
> 输入一个整数数组，实现一个函数来调整该数组中数字的顺序，使得所有的奇数位于数组的前半部分，所有的偶数位于位于数组的后半部分，并保证奇数和奇数，偶数和偶数之间的相对位置不变。  

```
class Solution {
public:
    void reOrderArray(vector<int> &array) {
		if(array.empty())
			return;
		int begin=0,end=array.size();
		int even=-1;
		
		while(begin<end){
			while((array[begin]&1) && (begin<end)){
				begin++;
			}
			even=begin;
			while((!(array[begin]&1))){
				begin++;
			}
			if(begin>=end)
				return;
			int temp=array[begin];
			while(even<begin){
				array[begin]=array[begin-1];
				begin--;
			}
			array[even]=temp;
		}
    }
};
```
## 14.链表中倒数第k个结点
> 输入一个链表，输出该链表中倒数第k个结点。  

分析：采用两个指针一起移动是一个很好的办法，不过需要考虑是否越界。  
```
/*
struct ListNode {
	int val;
	struct ListNode *next;
	ListNode(int x) :
			val(x), next(NULL) {
	}
};*/
class Solution {
public:
    ListNode* FindKthToTail(ListNode* pListHead, unsigned int k) {
        ListNode* p1=pListHead;
        for(int i=0;i<k;++i){
            if(!p1)
               return nullptr;
            p1=p1->next;
        }
        while(p1){
            p1=p1->next;
            pListHead=pListHead->next;
        }
        return pListHead;
    }
};
```
## 15.反转链表
> 输入一个链表，反转链表后，输出新链表的表头。   

分析：注意断开链表重连的过程。  
```
/*
struct ListNode {
	int val;
	struct ListNode *next;
	ListNode(int x) :
			val(x), next(NULL) {
	}
};*/
//最开始的一版代码，采用的是栈，看起来比较复杂。
class Solution {
public:
    ListNode* ReverseList(ListNode* pHead) {
        if((!pHead)||(!pHead->next))
            return pHead;
        stack<ListNode*> list_stack;
        while(pHead->next){
            list_stack.push(pHead);
            pHead=pHead->next;
        }
        ListNode *newHead=pHead;
        while(!list_stack.empty()){
            pHead->next=list_stack.top();
            pHead=pHead->next;
            list_stack.pop();
        }
        pHead->next=nullptr;
        return newHead;
    }
};

//采用在链表中的穿针引线。涉及到链表的断开与重连，维护三个指针，分别为：pre,cur,next
class Solution {
public:
    ListNode* ReverseList(ListNode* pHead) {
        ListNode* pre=nullptr;
        ListNode* cur=pHead;
        while(cur){
            ListNode* next=cur->next;
            cur->next=pre;
            pre=cur;
            cur=next;
        }
        return pre;
    }
};

//采用递归实现
class Solution {
public:
    ListNode* ReverseList(ListNode* pHead) {
        if(!pHead||!pHead->next)
            return pHead;
        ListNode* rHead=ReverseList(pHead->next);
        // head->next此刻指向head后面的链表的尾节点
        // head->next->next = head把head节点放在了尾部
        pHead->next->next=pHead;
        pHead->next=nullptr;
        
        return rHead;
    }
};

```
## 16.合并两个排序的链表
> 输入两个单调递增的链表，输出两个链表合成后的链表，当然我们需要合成后的链表满足单调不减规则。  

```
/*
struct ListNode {
	int val;
	struct ListNode *next;
	ListNode(int x) :
			val(x), next(NULL) {
	}
};*/
class Solution {
public:
    ListNode* Merge(ListNode* pHead1, ListNode* pHead2)
    {
        //当一个链表为空时，直接返回另一个链表
        if(!pHead1)
            return pHead2;
        if(!pHead2)
            return pHead1;
        ListNode* vHead=new ListNode(0);  //设立虚拟的头节点
        ListNode* vHeadHead=vHead;
        while(pHead1 && pHead2){  //一旦有一个链表为空，就退出循环
            if(pHead1->val<=pHead2->val){
                vHead->next=pHead1;
                pHead1=pHead1->next;
            }
            else{
                vHead->next=pHead2;
                pHead2=pHead2->next;
            }
            vHead=vHead->next;
        }
        //另一个链表不为空时，加在后面
        if(!pHead1)
            vHead->next=pHead2;
        else
            vHead->next=pHead1;
        return vHeadHead->next;  //返回虚拟头节点的下一个节点
    }
};
//采用递归实现
class Solution {
public:
    ListNode* Merge(ListNode* pHead1, ListNode* pHead2)
    {
        if(!pHead1)
            return pHead2;
        if(!pHead2)
            return pHead1;
        ListNode* vHead=nullptr;
        if(pHead1->val<=pHead2->val){
            vHead=pHead1;
            vHead->next=Merge(pHead1->next,pHead2);
        }
        else{
            vHead=pHead2;
            vHead->next=Merge(pHead1,pHead2->next);
        }
        return vHead;
    }
};
```
## 17.树的子结构
> 输入两棵二叉树A，B，判断B是不是A的子结构。（ps：我们约定空树不是任意一个树的子结构）  

```
class Solution {
public:
    bool dfs(TreeNode* pRoot1,TreeNode* pRoot2){
        if(!pRoot2)    //注意不能先判断pRoot1再判断pRoot2，因为，只要pRoot2为空的时候，都是true了，而不管这时候pRoot1是不是为空。
            return true;
        if(!pRoot1)
            return false;
        if(pRoot1->val!=pRoot2->val)
            return false;
        return dfs(pRoot1->left,pRoot2->left)&&dfs(pRoot1->right,pRoot2->right);
        
    }
    bool HasSubtree(TreeNode* pRoot1, TreeNode* pRoot2)
    {
        if((!pRoot2)||(!pRoot1))
            return false;
        return (dfs(pRoot1,pRoot2)||HasSubtree(pRoot1->left,pRoot2)||HasSubtree(pRoot1->right,pRoot2));
    }
};
```
## 18.二叉树的镜像
> 操作给定的二叉树，将其变换为源二叉树的镜像。   

分析：简单的递归解决。

```
/*
struct TreeNode {
	int val;
	struct TreeNode *left;
	struct TreeNode *right;
	TreeNode(int x) :
			val(x), left(NULL), right(NULL) {
	}
};*/
class Solution {
public:
    void Mirror(TreeNode *pRoot) {
        if(pRoot==nullptr)
            return;
        Mirror(pRoot->left);
        Mirror(pRoot->right);
        swap(pRoot->left,pRoot->right);
    }
};
```
## 19.顺时针打印矩阵
## 20.包含min函数的栈
> 定义栈的数据结构，请在该类型中实现一个能够得到栈最小元素的min函数。   

分析：维护两个栈，其中一个是压入数据的栈，另一个是min栈，存储当前数据的最小的值。只有压入的数小于min栈的时候，才压入新值，否则继续压入最小值。
```
class Solution {
public:
    void push(int value) {
        stk.push(value);
        if(!stk_min.empty()){
            if(value<stk_min.top())
                stk_min.push(value);
            else{
                int temp=stk_min.top();
                stk_min.push(temp);
            }
        }
        else
            stk_min.push(value);
    }
    void pop() {
        stk_min.pop();
        stk.pop();
    }
    int top() {
        return stk.top();
    }
    int min() {
        return stk_min.top();
    }
private:
    stack<int> stk;
    stack<int> stk_min;
};
```
## 21.栈的压入、弹出序列
> 输入两个整数序列，第一个序列表示栈的压入顺序，请判断第二个序列是否为该栈的弹出顺序。假设压入栈的所有数字均不相等。例如序列1,2,3,4,5是某栈的压入顺序，序列4，5,3,2,1是该压栈序列对应的一个弹出序列，但4,3,5,1,2就不可能是该压栈序列的弹出序列。（注意：这两个序列的长度是相等的）  

思路：判断是否是压入弹出序列，可以直接使用一个栈进行压入，然后在压入的过程中判断是否跟弹出序列的值相同，是的话则先弹出，最后判断栈是否为空即可。
```
class Solution {
public:
    bool IsPopOrder(vector<int> pushV,vector<int> popV) {
        stack<int> istack;
        int i=0,j=0;
        while(i<pushV.size()){
        	istack.push(pushV[i++]);
        	while(j<popV.size() && istack.top()==popV[j]){
        		istack.pop();
        		++j;
			}
		}
		return istack.empty();
    }
};
```
## 22.从上往下打印二叉树
> 从上往下打印出二叉树的每个节点，同层节点从左至右打印。  

分析：层序遍历，需要每遍历一个节点，就将他们的左右节点保存起来，当前层遍历完后，再顺序遍历他们的孩子节点。于是很容易想到先入先出的结构，队列。
```
/*
struct TreeNode {
	int val;
	struct TreeNode *left;
	struct TreeNode *right;
	TreeNode(int x) :
			val(x), left(NULL), right(NULL) {
	}
};*/
class Solution {
public:
    vector<int> PrintFromTopToBottom(TreeNode* root) {
        vector<int> res;
        if(root==nullptr)
            return res;
        queue<TreeNode*> ique;
        ique.push(root);
        while(!ique.empty()){
            TreeNode* temp=ique.front();
            res.push_back(temp->val);
            ique.pop();
            
            if(temp->left)
                ique.push(temp->left);
            if(temp->right)
                ique.push(temp->right);
        }
        return res;
    }
};
```
## 23.二叉搜索树的后序遍历序列
> 输入一个整数数组，判断该数组是不是某二叉搜索树的后序遍历的结果。如果是则输出Yes,否则输出No。假设输入的数组的任意两个数字都互不相同。  

```
class Solution {
public:
    bool VerifySquenceOfBST(vector<int> sequence) {
		return Verify(sequence,0,sequence.size());
    }
    bool Verify(vector<int> sequence,int start,int end){
        int i=start;
        if(start==end)
            return false;
		for(;i<end-1;++i){
			if(sequence[i]>sequence[end-1]){
                break;
            }
		}
        for(int j=i;j!=end;++j){
            if(sequence[j]<sequence[end-1]){
                 return false;
                }
             }
        bool left=true;
        if(i>start)
            left=Verify(sequence,start,i);
        
        bool right=true;
        if(i<end-1)
            right=Verify(sequence,i,end-1);
        return left&&right;
    }
};
```
## 24.二叉树中和为某一值的路径
> 输入一颗二叉树和一个整数，打印出二叉树中结点值的和为输入整数的所有路径。路径定义为从树的根结点开始往下一直到叶结点所经过的结点形成一条路径。

```
class Solution {
public:
    vector<vector<int>> res;
    vector<int> temp;
    vector<vector<int> > FindPath(TreeNode* root,int expectNumber) {
        if(!root)
            return res;
        temp.push_back(root->val);
        if(expectNumber-root->val==0 && root->left==nullptr && root->right==nullptr)
            res.push_back(temp);
        FindPath(root->left,expectNumber-root->val);
        FindPath(root->right,expectNumber-root->val);
        if(!temp.empty())
            temp.pop_back();
        return res;
    }
};
```
## 25.复杂链表的复制
代码问题：
```
        while(pHead->next){
//        	cout<<pHead->label<<endl;
//            RandomListNode* pTemp=pHead;   //傻了吧
            RandomListNode* pTemp=new RandomListNode(pHead->label);  
            pTemp->next=pHead->next;
            cout<<pTemp->next->label<<endl;
            pHead->next=pTemp;
            pHead=pTemp->next;
        }
        
                //拆分
        pNode=pHead;
		RandomListNode* newHead=pHead->next;
        RandomListNode* pTemp=pNode->next;
		while(pNode){
			pNode->next=pTemp->next;
			pNode=pNode->next;
			pTemp->next=pNode?pNode->next:NULL;
			//pTemp->next=pNode->next;
			//cout<<"pTemp: "<<pTemp->label<<endl;
			pTemp=pTemp->next;
			//cout<<"text"<<endl;
		}
```

```
class Solution {
public:
    RandomListNode* Clone(RandomListNode* pHead)
    {
    	if(!pHead)
    		return pHead;
    	RandomListNode* pNode=pHead;

    	while(pNode){
    		RandomListNode* pClone=new RandomListNode(pNode->label);
    		pClone->next=pNode->next;
    		pNode->next=pClone;
    		pNode=pClone->next;
		}

		pNode=pHead;
		while(pNode){
			RandomListNode* pClone=pNode->next;
			if(pNode->random)
				pClone->random=pNode->random->next;
			pNode=pClone->next;
		}
		pNode=pHead;
		RandomListNode* newHead=pNode->next;
		

		while(pNode->next){
			RandomListNode* pTemp=pNode->next;
			pNode->next=pTemp->next;
			pNode=pTemp;
//			pNode=pNode->next;                  //这种不行，搞得我折腾了很久
//			pTemp->next=pNode->next;
		}

		return newHead;
}
};
```

## 26.二叉搜索树与双向链表
> 输入一棵二叉搜索树，将该二叉搜索树转换成一个排序的双向链表。要求不能创建任何新的结点，只能调整树中结点指针的指向。
TODO:



## 27.字符串的排列
## 28.数组中出现次数超过一半的数字
解决一个问题，最终输出的判断，是1，还是0。如果大于1的话，万一最后只剩下了一个呢。所以还需要再判断最后剩下的结果是不是符合条件的，即是大于一般数目的。
```
class Solution {
public:
    int MoreThanHalfNum_Solution(vector<int> numbers) {
        if(numbers.empty())
            return 0;
        int count=1;
        int num=numbers[0];
        for(int i=1;i<numbers.size();++i){
            if(numbers[i]==num)
                count++;
            else{
                if((--count)<=0){
                    num=numbers[i];
                    count=1;
                }
            }
        }
        //判断结果是否符合条件
        count=0;
        for(int i=0;i<numbers.size();++i){
            if(num==numbers[i]){
                count++;
            }
        }
        return count*2>numbers.size()?num:0;
    }
};
```
## 29.最小的K个数
存在的问题，写程序的时候越界，没有判断好边界条件。
```
class Solution {
public:
    vector<int> GetLeastNumbers_Solution(vector<int> input, int k) {
        vector<int> min_stack;
        if(input.empty()||(k<=0)||(k>input.size()))  //边界条件的判断
            return min_stack;
        for(int i=0;i<input.size();++i){
            sort(min_stack.begin(),min_stack.end());
            if(min_stack.size()<k){
                min_stack.push_back(input[i]);
                
            }
            else{
            	//cout<<"min_stack[min_stack.size()-1]: "<<min_stack[min_stack.size()-1]<<endl;
                if(input[i]<min_stack[min_stack.size()-1]){
                    min_stack.pop_back();
                    min_stack.push_back(input[i]);
                }
            }
        }
        return min_stack;
    }
};
```
## 30.连续子数组的最大和
```
class Solution {
public:
    int FindGreatestSumOfSubArray(vector<int> array) {
    	int  res=array[0];
    	int cur=array[0];
    	for(int i=1;i<array.size();++i){
    		cur+=array[i];
    		if(cur<array[i])
    			cur=array[i];
    		res=(res>cur?res:cur);
		}
		return res;
    }
};
```
## 31.整数中1出现的次数（从1到n整数中1出现的次数）
## 32.把数组排成最小的数
> 输入一个正整数数组，把数组里所有数字拼接起来排成一个数，打印能拼接出的所有数字中最小的一个。例如输入数组{3，32，321}，则打印出这三个数字能排成的最小数字为321323。  

```
class Solution
{
  public:
    static bool equal(int a,int b){
        string str1=to_string(a)+to_string(b);
        string str2=to_string(b)+to_string(a);
        return str1<str2;
    }
    string PrintMinNumber(vector<int> numbers)
    {
        string result;
        sort(numbers.begin(),numbers.end(),equal);
        
        for(int i=0;i<numbers.size();++i){
            result+=to_string(numbers[i]);
        }
        return result;
    }
};
```
## 33.丑数
> 把只包含因子2、3和5的数称作丑数（Ugly Number）。例如6、8都是丑数，但14不是，因为它包含因子7。 习惯上我们把1当做是第一个丑数。求按从小到大的顺序的第N个丑数。  

```
class Solution {
public:
    int GetUglyNumber_Solution(int index) {
        if(index<=0)        
            return 0;
        vector<int > res(index);
        res[0]=1;
        int x=0,y=0,z=0;
        for(int i=1;i<index;++i){
            res[i]=min(2*res[x],min(3*res[y],5*res[z]));
            if(res[i]==2*res[x])
                x++;
            if(res[i]==3*res[y])
                y++;
            if(res[i]==5*res[z])
                z++;
        }
        return res[index-1];
    }
};
```
## 34.第一个只出现一次的字符位置
> 在一个字符串(1<=字符串长度<=10000，全部由字母组成)中找到第一个只出现一次的字符,并返回它的位置  

一般对于这种字符的处理，因为字符一般都是不超过256的，所以尤其是计数之类的，我们可以首先考虑数组。
```
class Solution
{
  public:
    int FirstNotRepeatingChar(string str)
    {
        if(str.size()<=0)
            return -1;
        int array[256]={0};
        for(int i=0;i<str.size();++i){
            array[int(str[i])]++;
        }
        for(int i=0;i<str.size();++i){
            if(array[int(str[i])]==1)
                return i;
        }
        return str.size();
    }
};
```
## 35.数组中的逆序对
> 在数组中的两个数字，如果前面一个数字大于后面的数字，则这两个数字组成一个逆序对。输入一个数组,求出这个数组中的逆序对的总数P。并将P对1000000007取模的结果输出。 即输出P%1000000007  
//TODO:
## 36.两个链表的第一个公共结点
> 输入两个链表，找出它们的第一个公共结点。  

需要知道的一个常识是，对于只有一个单链表，两个链表有公共节点，意味着从公共节点开始，之后两个链表都是公共的，因此他们有共同的终点。有了这个就好办了。可以将两个链表一直遍历，当遍历到链表尾的时候，就换另一个链表，当他们有公共节点时，在他们遍历到同一个节点时停止遍历，此节点即为第一个公共节点。   

**对于这种将两个不同的长度，通过两个结合在一起，使两个长度相等的方法，其实我们用到过很多次。例如本题中的找公共节点，原因是两个链表长度不同。还有之前的一个判断两个string的大小，可以把他们放在一起，这样他们的长度就相同了，可以直接用string的方法进行比较。**

```
class Solution {
public:
    ListNode* FindFirstCommonNode( ListNode* pHead1, ListNode* pHead2) {
        ListNode* p1=pHead1;
        ListNode* p2=pHead2;
        while(p1!=p2){
            p1=(p1==nullptr?pHead2:p1->next);
            p2=(p2==nullptr?pHead1:p2->next);
        }
        
        return p1;
    }
};
```
## 37.数字在排序数组中出现的次数
> 统计一个数字在排序数组中出现的次数。  


显然很容易想到的是二分法,没有用函数的话，就存在一个找到没找到的问题，在这采用了一个返回值的处理。如果没找到，(end-begin-1)<0，则可以判断是没有找到。
```
class Solution {
public:
    int GetNumberOfK(vector<int> data ,int k) {
        if(data.empty())
            return 0;
        int begin=0,end=data.size()-1;
        int count=0;
        int mid;
        while(begin<=end){
        	mid=(begin+end)/2;
//        	cout<<"dsdasads"<<endl;
			if(data[mid]==k)
				break;
            else if(data[mid]<k){
                begin=mid+1;
                continue;
            }
            else if(data[mid]>k){
                end=mid-1;
                continue;
            }
        }

        begin=end=mid;
        while(data[begin]==k)
            --begin;
        while(data[end]==k)
            ++end;
        count=(end-begin-1)>0?(end-begin-1):0;
        return count;
    }
};
```

## 38.二叉树的深度
## 39.平衡二叉树
## 40.数组中只出现一次的数字
> 一个整型数组里除了两个数字之外，其他的数字都出现了两次。请写程序找出这两个只出现一次的数字。  

数组中只出现一次的数字，当有一个的时候，很容易利用的特性是：全部异或，最后剩下的那个就是。原因是一个数跟自身异或，结果为0.那么出现有两个的时候呢。很容易想到的还是异或，最后的结果是两个只出现一次数字异或的结果，再进行分组解决。分组的依据是：因为有两个不同的数字只出现一次，所以整个数组异或的结果必然不为0，不为0就肯定有一位为1.按该位是否为1来进行划分即可。代码如下：
```
class Solution {
public:
    void FindNumsAppearOnce(vector<int> data,int* num1,int *num2) {
        if(data.empty())
            return;
        //第一次遍历一遍，求两个数字最后的异或
        int res=data[0];
        for(int i=1;i<data.size();++i){
            res=res^data[i];
        }
        if(res==0)
            return;
        //由于存在两个只出现一次的数字，所以res的值为这两个数字的异或，因此肯定不为0，肯定不为0意味着肯定有一位是1.找出这一位是1的
        int index=0;
        while((res&1)==0){
            res=res>>1;
            index++;
        }
        *num1=*num2=0;        
        //根据index位为不为1，将数组分为两部分。
        int x;
        for(int i=0;i<data.size();++i){
            if((x=data[i]>>index)&1)
                *num1^=data[i];
            else
            {
                *num2^=data[i];
            }
            
        }
    }
};
```
## 41.和为S的连续正数序列
> 输出所有和为S的连续正数序列。序列内按照从小至大的顺序，序列间按照开始数字从小到大的顺序  

```
class Solution {
public:
    vector<vector<int> > FindContinuousSequence(int sum) {
        vector<vector<int>> res;
        vector<int> temp;
        //边界条件的判断
        if(sum<0)
            return res;
            
        int end=0;
        int tempSum=0;
        //遍历数组
        while(end<sum){
            if(tempSum==sum){
                res.push_back(temp);
                end=temp[0];  //这一句其实很重要,因为要考虑将end从最开始重新开始计算，不然可能会有所遗漏,eg:9=2+3+4=4+5，其中4会重复
                temp.erase(temp.begin(),temp.end());
                tempSum=0;
                continue;
            }
            if(tempSum>sum){
                tempSum-=temp[0];
                temp.erase(temp.begin());
                continue;
            }
            temp.push_back(++end);
            tempSum+=end;
        }
        return res;
    }
};
```
## 42.和为S的两个数字
> 输入一个递增排序的数组和一个数字S，在数组中查找两个数，是的他们的和正好是S，如果有多对数字的和等于S，输出两个数的乘积最小的。  

输出乘积最小的，显然距离最大的乘积就越小，所以，可以直接前后两个指针搜索，搜到的第一个就是。
```
class Solution
{
  public:
    vector<int> FindNumbersWithSum(vector<int> array, int sum)
    {
        vector<int > res;
        if(array.empty())
            return res;
            
        int i=0,j=array.size()-1;
        while(i<j){
            int temp=array[i]+array[j];
            if(temp>sum)
                --j;
            if(temp<sum)
                ++i;
            
            if(temp==sum) 
            {
                res.push_back(array[i]);
                res.push_back(array[j]);
                return res;
            }
        }
        return res;
    }
};
```
## 43.左旋转字符串
> 汇编语言中有一种移位指令叫做循环左移（ROL），现在有个简单的任务，就是用字符串模拟这个指令的运算结果。对于一个给定的字符序列S，请你把其循环左移K位后的序列输出。例如，字符序列S=”abcXYZdef”,要求输出循环左移3位后的结果，即“XYZdefabc”。是不是很简单？OK，搞定它！  

由BA=(ATBT)T计算可得 
```
//第一次通过代码
class Solution {
public:
    string LeftRotateString(string str, int n) {
        int len=str.size();
        if(n>=len)
            return str;
        int i=0,j=0;
        for(i=0,j=n-1;i<j;++i,--j){swap(str[i],str[j]);}
        for(i=n,j=len-1;i<j;++i,--j){swap(str[i],str[j]);}
        for(i=0,j=len-1;i<j;++i,--j){swap(str[i],str[j]);}
        return str;
    }
};
```
## 44.翻转单词顺序列
//TODO:
> 牛客最近来了一个新员工Fish，每天早晨总是会拿着一本英文杂志，写些句子在本子上。同事Cat对Fish写的内容颇感兴趣，有一天他向Fish借来翻看，但却读不懂它的意思。例如，“student. a am I”。后来才意识到，这家伙原来把句子单词的顺序翻转了，正确的句子应该是“I am a student.”。Cat对一一的翻转这些单词顺序可不在行，你能帮助他么？  



```
//以前买的
class Solution {
public:
    void ReverseSentence(string &str,int begin,int end){
        while(begin<end){
            char tmp=str[begin];
            str[begin]=str[end];
            str[end]=tmp;
            begin++;
            end--;
        }
    }
    string ReverseSentence(string str) {
        if(str.size()<=1)
            return str;
      	
        int begin=0;
        int end=0;
        
        //这里需要注意，考虑只有一个单词的情况
        while(end!=str.size()){
            if(str[end]==' '){
                ReverseSentence(str,0,str.size()-1);
                break;
            }
            else if(end==str.size()-1)
            	return str;
            else
                ++end;
        }
        end=0;
        //开始遍历，旋转每个单词
        while(begin!=str.size()){
            if(str[begin]==' '){
                ++end;
                ++begin;
            }
            else if(str[end]==' '||end==str.size()){
                ReverseSentence(str,begin,--end);
                begin=++end;
            }
            else
                ++end;
        }
        return str;
    }
};
```
## 45.扑克牌顺子
> LL今天心情特别好,因为他去买了一副扑克牌,发现里面居然有2个大王,2个小王(一副牌原本是54张^_^)...他随机从中抽出了5张牌,想测测自己的手气,看看能不能抽到顺子,如果抽到的话,他决定去买体育彩票,嘿嘿！！“红心A,黑桃3,小王,大王,方片5”,“Oh My God!”不是顺子.....LL不高兴了,他想了想,决定大\小 王可以看成任何数字,并且A看作1,J为11,Q为12,K为13。上面的5张牌就可以变成“1,2,3,4,5”(大小王分别看作2和4),“So Lucky!”。LL决定去买体育彩票啦。 现在,要求你使用这幅牌模拟上面的过程,然后告诉我们LL的运气如何。为了方便起见,你可以认为大小王是0。  

```
class Solution
{
  public:
    bool IsContinuous(vector<int> numbers)
    {
        if (numbers.empty())
            return false;
        sort(numbers.begin(), numbers.end());
        int sum = 0, zero_num = 0;
        for (int i = 0; i < numbers.size() - 1; ++i)
        {
            if (numbers[i] == 0)
            {
                zero_num++;
                continue;
            }
            //考虑数字重复的情况
            if (numbers[i + 1] == numbers[i])
                return false;
            sum += numbers[i + 1] - numbers[i] - 1;
        }
        return sum <= zero_num; //注意这里要大于等于就可以，不一定等于
    }
};
```
## 46.孩子们的游戏(圆圈中最后剩下的数)
> 每年六一儿童节,牛客都会准备一些小礼物去看望孤儿院的小朋友,今年亦是如此。HF作为牛客的资深元老,自然也准备了一些小游戏。其中,有个游戏是这样的:首先,让小朋友们围成一个大圈。然后,他随机指定一个数m,让编号为0的小朋友开始报数。每次喊到m-1的那个小朋友要出列唱首歌,然后可以在礼品箱中任意的挑选礼物,并且不再回到圈中,从他的下一个小朋友开始,继续0...m-1报数....这样下去....直到剩下最后一个小朋友,可以不用表演,并且拿到牛客名贵的“名侦探柯南”典藏版(名额有限哦!!^_^)。请你试着想下,哪个小朋友会得到这份礼品呢？(注：小朋友的编号是从0到n-1)   

此约瑟夫环的问题。TODO:https://www.nowcoder.com/profile/4566768/codeBookDetail?submissionId=13393365
```
class Solution {
public:
    int LastRemaining_Solution(int n, int m)
    {
        if(n<=0)
            return -1;
        int last=0;
        for(int i=2;i<=n;++i){
            last=(last+m)%i;
        }
        return last;
    }
};
```
## 47.求1+2+3+...+n
> 求1+2+3+...+n，要求不能使用乘除法、for、while、if、else、switch、case等关键字及条件判断语句（A?B:C）。  

这个题，可以有好几种解决办法，一个容易想到的就是递归，每次都跟自己相加，直到加到0为止，判断的条件可以采用`&&`的短路特性：通过&&判断值是否为0已经到达结尾了。   
另一种办法，可以利用类的构造函数。TODO:
```
class Solution {
public:
    int Sum_Solution(int n) {
        int sum=n;
        sum&&(sum+=Sum_Solution(n-1));
        return sum;
    }
};
```
## 48.不用加减乘除做加法
> 写一个函数，求两个整数之和，要求在函数体内不得使用+、-、*、/四则运算符号。  

不能用加法做加法运算，可以想到的计算机中利用的二进制的加法。通过异或两个数，也就是模2加，得到的是不考虑进位的加法的结果。通过两个数异或，左移一位得到的是进位。无进位结果加上进位，一直循环知道进位为0的时候，结果即为加法的结果。   
计算的过程中，一定要细心。方法虽然简单，但是要写对。

```
class Solution
{
  public:
    int Add(int num1, int num2)
    {
        int res = num1 ^ num2, temp = num1 & num2;
        while (temp != 0)
        {
            temp = temp << 1;
            int t = res;  //暂存res,以避免res的值被改变
            res ^= temp;
            temp = temp & t;
        }
        return res;
    }
};
```
## 49.把字符串转换成整数
> 输入一个字符串,包括数字字母符号,可以为空.如果是合法的数值表达则返回该数字，否则返回0  

分析：主要首先要考虑正负号，这里有一个小细节，我们把flag直接置1的话，可以直接输出flag*res得到结果，而不需要进行判断，是一种省略。另外的判断就比较简单了，按照正常的思路去判断就行。 

```
class Solution
{
  public:
    int StrToInt(string str)
    {
        if (str.size() == 0)
            return 0;
        int flag = 1;
        int size = str.size(), res = 0;
        int i = 0;
        if (str[0] == '-')
        {
            flag = -1;
            i++;
        }
        else if (str[0] == '+')
        {
            i++;
        }
        for (; i < size; ++i)
        {
            if (str[i] <= '0' || str[i] >= '9')
            {
                return 0;
            }
            else
                res = res * 10 + (str[i] - '0');
        }
        return flag * res;
    }
};
```
## 50.数组中重复的数字
> 在一个长度为n的数组里的所有数字都在0到n-1的范围内。 数组中某些数字是重复的，但不知道有几个数字是重复的。也不知道每个数字重复几次。请找出数组中任意一个重复的数字。 例如，如果输入长度为7的数组{2,3,1,0,2,5,3}，那么对应的输出是第一个重复的数字2。  

分析：由于规定了数组中的数字在范围为0--n内，所以可以利用当前数组的位置进行遍历，比如每次遍历到一个位置，就将该数字对应位置的值加n，这样，当再次遍历到该值时，发现如果该值已经大于n，说明已经重复了，返回即可。不过在遍历的时候，如果发现某一位置的值大于n，应该先减去n，得到该位置上原来的值，这里应该捋清楚。  
 
```
class Solution
{
  public:
    // Parameters:
    //        numbers:     an array of integers
    //        length:      the length of array numbers
    //        duplication: (Output) the duplicated number in the array number
    // Return value:       true if the input is valid, and there are some duplications in the array number
    //                     otherwise false
    bool duplicate(int numbers[], int length, int *duplication)
    {
        for(int i=0;i<length;++i){
            int index=numbers[i];
            if(index>=length)
                index=index-length;
            if(numbers[index]>=length){
                *duplication=index;
                return true;
            }
            numbers[index]+=length;
        }
        return false;
    }
};
```
## 51.构建乘积数组
> 给定一个数组A[0,1,...,n-1],请构建一个数组B[0,1,...,n-1],其中B中的元素B[i]=A[0]*A[1]*...*A[i-1]*A[i+1]*...*A[n-1]。不能使用除法。  

```
class Solution {
public:
    vector<int> multiply(const vector<int>& A) {
        vector<int> res(A.size());
        if(A.empty())
            return res;
        res[0]=1;
        //计算下三角
        for(int i=1;i<A.size();++i){
            res[i]=res[i-1]*A[i-1];
        }
        int temp=1;
        for(int i=A.size()-2;i>=0;--i){
            temp*=A[i+1];
            res[i]*=temp;
        }
        return res;
    }
};
```
## 52.正则表达式匹配
## 53.表示数值的字符串

```
/*
struct ListNode {
    int val;
    struct ListNode *next;
    ListNode(int x) :
        val(x), next(NULL) {
    }
};
*/
class Solution {
public:
    ListNode* deleteDuplication(ListNode* pHead)
    {
        if(pHead==nullptr)
            return pHead;
        ListNode* virtualHead=new ListNode(0);
        virtualHead->next=pHead;
        ListNode* prev=virtualHead;
        
        while(pHead->next){
            if(pHead->val==pHead->next->val){
                if(pHead->next->next){
                    pHead=pHead->next->next;
                    prev->next=pHead;
                }
                else 
                    return virtualHead->next;
            }
            else{
                pHead=pHead->next;
                prev=prev->next;
            }
            
        }
        return virtualHead->next;
    }
};
```
测试用例:
{1,1,1,1,1,1,1}

对应输出应该为:

## 54.字符流中第一个不重复的字符
## 55.链表中环的入口结点
## 56.删除链表中重复的结点
## 57.二叉树的下一个结点
## 58.对称的二叉树
## 59.按之字形顺序打印二叉树
## 60.把二叉树打印成多行
## 61.序列化二叉树
## 62.二叉搜索树的第k个结点
## 63.数据流中的中位数
## 64.滑动窗口的最大值
## 65.矩阵中的路径
## 66.机器人的运动范围 
