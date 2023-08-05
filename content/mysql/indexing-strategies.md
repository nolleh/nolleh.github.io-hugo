---
title: "Indexing Strategies"
date: 2023-07-24T08:44:12+09:00
draft: true
---

# Overview

- in data driven application's poorly designed indexes and a lack of indexes are primary sources bottlenecks.
- As databases grow in size, finding efficient ways to retrieve and manipluate data becomes increasingly important.

# Basics of Indexing 

a database index serves a similar purporse in that of book, speeding up data retrieval without needing to scan every row in a database table  

the structure of a database index includes an ordered list of values, with each value connected to pointers leading to data pages where these alues reside.  

indexes are typically stored on disk. they are associated with a table to speed up data retrieval. keys made from one or more columns in the table make up the index, which , for most releational database, are stored in B+ tree structure. this structure allows the database to locate associated rows efficiently. 

finding the right indexes for a database is a balancing act between quick query responses and update costs. Narrow indexes, or those with fewer columns, save on disk apace and mainteneance, while whide indexes cater to a borader range of queries. often, it requires several iterations of designs to find the most efficient index. 

IN its siplest form, an index is stored table that allows for searches to be conducted in O(Log N) imte complexcity uisng binary search on a stored data structure. 

# Primer on B+ Tree  

understanding it requires some background on its predesessor, ths B-Tree

The B-Tree, or Balanced Tree, is a self-balancing tree data structure that maintains stored data and allows for efficient insertion. deletion, and search operation.

