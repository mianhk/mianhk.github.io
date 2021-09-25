+++
title = "LeetCode-23-Merge-k-Sorted-Lists"
date = "2018-01-11T22:23:23+08:00"
categories = "刷题"
tags = ["C++", "LeetCode"]
description = ""
+++


### 23. Merge k Sorted Lists
> Merge k sorted linked lists and return it as one sorted list. Analyze and describe its complexity.

这个题乍一看只是对链表的一个排序，因为是很多个链表，所以很简单的想法就是将整个数组里面的两个链表分别进行排序。两个两个互相排序之后就能排好。这里用的是递归。当vector中的元素大于1说明还没有排完。
直接一下就AC了，但是一看detail，果然时间有点长。运行时间内93ms，看到别人的只需要20+。。
还是先记一下自己的代码 吧。


```
/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     ListNode *next;
 *     ListNode(int x) : val(x), next(NULL) {}
 * };
 */
class Solution {
public:
    ListNode* merge2List(ListNode* lList,ListNode* rList){
        if(lList==nullptr)
            return rList;
        if(rList==nullptr)
            return lList;
        if(lList->val<rList->val){
            lList->next=merge2List(lList->next,rList);
            return lList;
        }
        else{
            rList->next=merge2List(lList,rList->next);
            return rList;
        }
    }
    ListNode* mergeKLists(vector<ListNode*>& lists) {
        if(lists.size()==0)
            return nullptr;
        while(lists.size()>1){
            lists.push_back(merge2List(lists[0],lists[1]));
            lists.erase(lists.begin());
            lists.erase(lists.begin());
        }
        return lists[0];
    }
};
```

 看了一下别人的代码，用了优先队列，进行排序，没有重新写了。


```
/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     ListNode *next;
 *     ListNode(int x) : val(x), next(NULL) {}
 * };
 */
class Solution {
    class Cmp
    {
    public:
        bool operator() (ListNode *a, ListNode *b) const
        {
            return a->val > b->val;
        }
    };
public:
    ListNode* mergeKLists(vector<ListNode*>& lists) {
        priority_queue<ListNode *, vector<ListNode *>, Cmp> pq;
        ListNode *head = NULL;
        ListNode *cur = NULL;
        int k = lists.size();
        if(k == 0)
        {
            return NULL;
        }
        for(ListNode *list: lists)
        {
            if(list != NULL)
            {
                pq.push(list);
            }
        }
        while( !pq.empty() )
        {
            ListNode *next = pq.top();
            pq.pop();
            if(next->next != NULL)
            {
                pq.push(next->next);
            }
            next->next = NULL;
            if(head == NULL)
            {
                head = next;
                cur = head;
            }
            else
            {
                cur->next = next;
                cur = cur->next;
            }
        }
        return head;
    }
};
```
