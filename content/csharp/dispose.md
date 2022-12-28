---
title: "Dispose"
date: 2018-12-19T10:18:25+09:00
categories: ["csharp"]
tags: ["C#"]
author: "nolleh"
---

# Dispose 에 대한 여러가지
## MSDN
>[Implementing a Dispose method](https://docs.microsoft.com/en-us/dotnet/standard/garbage-collection/implementing-dispose#Y754)

## threadSafety

>[stackoverflow](https://stackoverflow.com/questions/5024883/thread-safety-of-dispose-methods) dispose 의 threadsafety

많은 경우 어떤 스레드든지 다른 스레드가 dispose 를 시작했을때 오브젝트에 대해 작업을 하고 있을 수 있기 때문에, interlocked.Exchange 를 통해 배제하는게 옳아 보인다.  

물론, 좋은 생각이고 표준 dispose 패턴의 일부가 되어야 한다고 생각한다.   
(champareExchange가 base class 에 봉인됨으로써 derived class 에서 private 한 disposed flag 를 사용하는 것을 피해야한다.)  
하지만 불행히도, dispose 가 정확히 어떤것을 하는지 생각해보면 문제는 좀 더 복잡해진다.  

Dispose 의 진짜 목적은 그 오브젝트가 버려지게 하는 목적이라기보다, 그 오브젝트가 들고 있는 레퍼런스를 비우는데 목적이 있다.  
이 엔터티 들은 managed objects 일 수도 있고, system object 일수도 있고, 다른 어떤 것일 수도 있다; 심지어 같은 컴퓨터에 존재하지 않을 수도 있다.   

thread-safe 하려면, 이 Dispose 가 정리하는 동시에 다른 스레드가 이를 가지고 다른 일을 할 수 있도록 다른 엔티티들이 허용해야한다.   
어떤 객체들은 이렇게 할 수 있지만, 그렇지 않은 객체들도 있다.   

짜증나는 예를 들어보자: 객체들은 thread-safe 하지 않은 RemoveHandler 이벤트를 갖도록 허용되어있다. 결과적으로, 구독이 이루어졌던 그 스레드에서만 Dispose 를 호출하도록 해야한다. 
