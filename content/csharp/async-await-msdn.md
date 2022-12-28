---
title: "Async Await 을 사용한 비동기 프로그래밍"
date: 2018-12-21T21:41:08+09:00
Categories: ["csharp"]
Tags: ["C#", "async-await", "생각하는 프로그래머"]
Author: "nolleh"
---


# 개요  
---
> 다음에서 발췌 [MSDN](https://docs.microsoft.com/ko-kr/dotnet/csharp/programming-guide/concepts/async/)


# 반응성을 향상시키는 비동기  
---
잠재적인 차단 작업 완료 될때까지 다른 작업을 게속 수행

# 작성이 간편한 비동기 메서드  
---
반환 형식은 다음 중 하나   
- Task<TResult>  
- Task  
- void - 비동기 이벤트 처리기 작성  
- GetAwaiter 포함 모든 기타 형식  

![navigation-trace](https://docs.microsoft.com/ko-kr/dotnet/csharp/programming-guide/concepts/async/media/navigationtrace.png)

- await 을 만나면 yield 함 (호출자로 제어가 돌아감)  
	- 이때, Task<int> 가 호출자에게 반환되고 이는 언젠가 다운로드된 문자열의 길이가 반환된다는 약속 (future) 을 의미한다.  
	- await 전에 작업이 완료된다면 제어가 돌아가지 않는다.  


# 스레드
---
비동기 메서드의 await 식은 대기한 작업이 실행되는 동안 현재 스레드를 차단하지 않는다. 
대신, 메서드의 나머지를 연속으로 등록하고 비동기 메서드 호출자에 반환.

async / await 으로 인해 스레드가 추가로 생성되지 않는다.  
비동기 메서드는 자체 스레드에서 실행되지 않고 ``현재 동기화 컨텍스트``에서 실행되며,  
활성화된 경우에만 스레드에서 시간을 사용.  
