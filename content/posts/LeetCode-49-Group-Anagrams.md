+++
title = "LeetCode-49-Group-Anagrams"
date = "2018-01-25T21:44:37+08:00"
categories = "刷题"
tags = ["C++", "LeetCode"]
description = ""
+++

### LeetCode-49-Group-Anagrams
> Given an array of strings, group anagrams together.
For example, given: ["eat", "tea", "tan", "ate", "nat", "bat"],

Return:
```
[
  ["ate", "eat","tea"],
  ["nat","tan"],
  ["bat"]
]
```
输入一个字符串数组，输出的是：将相同字符的字符串放在一个数组的二维数组。相同字符的处理，基本就是要对字符串排序的。然后需要考虑的就是排序好的那一个字符串怎么存的问题。用的数据结构是map，string为键，对应的值是一个set或者是一个vector，存放满足要求的string，之后再用这个初始化结果数组。
```
class Solution {
public:
    vector<vector<string>> groupAnagrams(vector<string>& strs) {
        unordered_map<string,multiset<string>> map_str;
        for(string s:strs){
            string t=s;
            sort(t.begin(),t.end());
            map_str[t].insert(s);
        }
        vector<vector<string>> res;
        for(auto temp:map_str){
            vector<string> vec_str_temp(temp.second.begin(),temp.second.end());
            res.push_back(vec_str_temp);
        }
        return res;
    }
};
```

后来发现用vector其实要好一些。只是别人这么写的，时间竟然要短一点，毕竟是用vector初始化vector？
