---
title: "Concurrent Idiom 1 - Stack"
date: 2017-07-10T22:57:57+09:00
Categories: ["서버개발지식"]
Tags: ["Concurrent Programming", "Programming", "생각하는 프로그래머", "Note"]
Author: "nolleh"
---
> concurrent 프로그램을 작성할 때 고려해야할 몇가지 사항. 그리고 idiom.  
여러 서적에서 발췌하였으며, 정리 차원에서 작성한 내용이므로 본 글을 처음 접한 사람이 이해하기에 많은 내용을 담지 않을 수 있음.  
어쩌면 작성자의 부사수를 위한 자재가 될지도 모르겠...(..)  

# Concurrent ISSUE - Stack 
이번엔 스택.
```cpp
if (!s.empty())
{
    item = s.top();
    s.pop();
}
```
인터페이스상의 문제이기 때문에 empty 와 top 사이의 safety 를 보장할 수 없다.  
top() / pop() 도 마찬가지 ->> 조회되지 못하는 아이템이 있을 수 있다. (생각해보자.)  
해결을 위해 ?? -> Returning Pop ? -->> 역시, 생각해보자. (Hint. Exception)  

## Options
### Reference 
호출전 인스턴스 생성 필요. 생성자의 인자가 항상 제공 가능한 경우가 아닐때도.  
그리고 assign 필요. (Q. 이것이 무엇을 의미하는가? - C++ 개발지식이 있다면 대답할 수 있어야 한다.)  

### Move
Exception 만이 문제라면 이 선택으로 회피 가능할 수 있지 않은가.  
하지만.. 위와 마찬가지. (Q. 역시, 대답할 수 있어야 한다. )  

### Pointer
유저에게 메모리 관리 작업을 맡기는 것. (Q. 이게 문제라면, 어떻게 해결할 수 있겠는가?) 간단한 타입에 대해서는 오버헤드. 

### Compounded Options
말그대로, 결합. 

**끝**

