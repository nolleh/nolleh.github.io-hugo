---
title: "markDown 문법"
date: "2017-07-04T22:13:52+09:00"
description: "mark down 문법"
categories: ["개발환경"]
tags: ["GitHub-Page", "Editor"]
author: "nolleh"
---

마크다운으로 포스팅하는 Git 페이지를 생성하였으니, 자주 사용되는 대표 문법 정리  
[마크다운 문법](https://confluence.atlassian.com/bitbucketserver/markdown-syntax-guide-776639995.html#Markdownsyntaxguide-Listinlist)


## Heading 
'#' 으로 처리하며, 단계별로 더 많은 '#' 을 사용한다. 

```bash
# Title
## Heading 1
### Heading 2
```

결과 
# Title
## Heading 1
### Heading 2


## Listing
Asterisk (*) 를 사용하여 순서 없는 목록을, 숫자를 사용하여 순서 있는 목록을 나타낸다. 

### 순서 없는 경우  
* 이거닷  
* 이거 중요해!  

### 순서가 있는 경우  
1. 첫번째 순서
2. 두번째~
3. 셋!!

## Fonts 
```bash 
**Bold** _Italic_ ~~CANCEL_LINE~~
```
**Bold** _Italic_ ~~CANCEL_LINE~~


## SRC
```
![Alt](경로 "Optional Tooltip MSG")
```

## TABLE
```bash
| Day     | Meal    | Price |
| --------|---------|-------|
| Monday  | pasta   | $6    |
| Tuesday | chicken | $8    |
```

| Day     | Meal    | Price |
| --------|---------|-------|
| Monday  | pasta   | $6    |
| Tuesday | chicken | $8    |

