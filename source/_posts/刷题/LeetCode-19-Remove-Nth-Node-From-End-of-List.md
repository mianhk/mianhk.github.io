---
title: LeetCode-19-Remove-Nth-Node-From-End-of-List
date: 2018-01-12 17:25:23
categories: 刷题
tags: [C++,LeetCode]
---
> Given a linked list, remove the nth node from the end of list and return its head.
For example,
```
Given linked list: 1->2->3->4->5, and n = 2.

   After removing the second node from the end, the linked list becomes 1->2->3->5.
```

这个题目之前在剑指offer上就有，记得当时的方法是：采用两个指针，首先判断n的大小是否比链表的长度要大，大的话直接返回。否则采用一前一后两个指针，两个指针相差n，当前面的指针到链表末尾时，后面的指针所在的位置就是要删除的位置了。

当然，这是个很好的方法，不过看了一下后面的答案，以及前天看到的一个有点不是很明白的一个答案，才知道大家都用的是二级指针，二级指针的好处是，可以直接记住链表的头节点，而不至于总是去判断。这样显得对指针的理解就不一样了。可以看看下面的这篇文章。

[Linus：利用二级指针删除单向链表](http://blogread.cn/it/article/6243?f=wb)

下面是代码：
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
    ListNode* removeNthFromEnd(ListNode* head, int n) {
        ListNode **t1=&head,*t2=head; //这样head一直指向的是头节点
        for(int i=0;i<n;++i){
            t2=t2->next;
        }
        while(t2!=nullptr){
            t1=&((*t1)->next);
            t2=t2->next;
        }
        *t1=(*t1)->next; //删除找到的节点
        return head;
    }
};
```

无奈每次提交总是有群禽兽比我的快那么多啊，我的12ms，别人的6ms。。

不过别人的代码一看好像也还好，思路都是差不多的，就是一些细节的地方注意的比较好，看来还得好好弄啊。
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
    ListNode* removeNthFromEnd(ListNode* head, int n) {
        int counter = 0;
        if(!head || !n) {
            return head;

        }
        ListNode *p = head;
        ListNode **pp = &head;
        while(p && n) {
            p = p->next;
            n--;
        }
        while(p) {
            p = p->next;
            pp = &((*pp)->next);
        }
        ListNode *temp = *pp;
        *pp = temp->next;
        delete(temp);
        return head;
    }
};
```

