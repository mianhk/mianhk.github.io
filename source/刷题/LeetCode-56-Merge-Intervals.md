---
title: LeetCode-56and57-Merge-Intervals
date: 2018-01-30 16:00:00
categories: 刷题
tags: [C++,LeetCode]
---
### LeetCode-56-Merge-Intervals
> Given a collection of intervals, merge all overlapping intervals.
For example,
```
Given [1,3],[2,6],[8,10],[15,18],
return [1,6],[8,10],[15,18].
```
如例子中所示，每个数组的前后分别表示开始和结束，工作是合并有重叠的数组。例如，由于[1,3]和[2,6]有重叠，故直接改为[1,6]后输出。
想法还是比较简单的，因为输入的并不一定是给好的按照开始，所以需要先对输入以开始的值排序。首先在结果数组中写入第一个，只有遍历进行判断，分为两种情况：
1. 如果某一interval的开始比结果数组中的结尾要大，显然不会有重叠，直接写入到结果数组中即可；
2. 某一interval的开始比结果数组中的结尾要大，必然有重叠，此时还需要判断结束位置的大小。

代码如下：

```
/**
 * Definition for an interval.
 * struct Interval {
 *     int start;
 *     int end;
 *     Interval() : start(0), end(0) {}
 *     Interval(int s, int e) : start(s), end(e) {}
 * };
 */
class Solution {
public:
    vector<Interval> merge(vector<Interval>& intervals) {
        vector<Interval> res;
        if(intervals.size()<=0)
            return res;
        sort(intervals.begin(),intervals.end(),[](Interval a,Interval b){return a.start<b.start;});
        res.push_back(intervals[0]);
        for(int i=1;i<intervals.size();++i){
            if(res.back().end<intervals[i].start) res.push_back(intervals[i]);
            else{
                res.back().end=max(res.back().end,intervals[i].end);
            }
        }
        return res;
    }
};
```

### 57-Insert-Interval
> Given a set of non-overlapping intervals, insert a new interval into the intervals (merge if necessary).
You may assume that the intervals were initially sorted according to their start times.

题目改为向一个已经重叠的数组中加入新加入一个。需要做的是判断所处的位置，插入进去后还要删掉，值得注意的是这个删掉值的时候，vector的迭代器会发生变化，即有些会失效，所以最好的做法是，先插入，把需要的插入都插入之后再删除。

另外还有一个值得注意的是，排序搜索的谓语，使用的是`a.end<b.start`，而不是之前的`a.start<b.start` ，原因是需要找到一个范围，将newINterval夹在中间的一个范围。
```
/**
 * Definition for an interval.
 * struct Interval {
 *     int start;
 *     int end;
 *     Interval() : start(0), end(0) {}
 *     Interval(int s, int e) : start(s), end(e) {}
 * };
 */
class Solution {
public:
    vector<Interval> insert(vector<Interval>& intervals, Interval newInterval) {
        if(intervals.size()<=0){
            intervals.push_back(newInterval);
            return intervals;
        }
        auto range=equal_range(intervals.begin(),intervals.end(),newInterval,[](Interval a,Interval b){return a.end<b.start;});
        auto iter1=range.first,iter2=range.second;
        if(iter1==iter2)
            intervals.insert(iter1,newInterval);
        else{
            iter2--;
            iter2->start=min(newInterval.start,iter1->start);
            iter2->end=max(newInterval.end,iter2->end);
            intervals.erase(iter1,iter2);
        }
        return intervals;
    }
};
```
