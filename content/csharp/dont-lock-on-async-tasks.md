---
title: "Dont Lock on Async Tasks"
date: 2022-09-06T00:20:16+09:00
categories: ["csharp"]
tags: ["Programming", "async-await", "concurrent", "생각하는 프로그래머"]
draft: false
---

## 서론

예전 회사에서나 현 직장에서나, 면접관으로 들어가다가 C# 이 이력서에 적혀있는 경우 
Task 와 async/await 관련하여 동기화 관련한 내용에 대해 물어보곤한다. 
그리고 이 질문에서 대부분 깊이가 드러나게 된다. 
(여담이지만, 대부분의 지원자가 자바스택이라, 이런 재미진? 것들을 물어보기가 어렵다. 
C# 이랑 C++, 실시간 게임서버는 재미진 질문? 들이 많은데.. ㅎㅎㅎㅎ
면접관으로 들어가기위해서 자바스택의 재미진 토픽들도 좀 찾아봐야겠다....
- 내 경험에서 질문을 도출하려고 스프링의 라이브러리들을 어떻게 구현할 수 있을지 물어볼수는 없으니...)

물어보다가 나도 생각도 정리하고, 내가 알고 있는 틀린 부분이 없는지 정리하는겸해서 블로그에 기록해 놓는다.

## 내용

출처 - [Don't Lock On Async Tasks](https://davidsekar.com/c-sharp/dont-lock-on-async-tasks)

다음과 같이 일반적으로 락을 건다고 하자. 

```c#
public class LockTest{
    private readonly object objLock = new object();

    public void RecordSuccess(int batchId){
        lock(objLock){
            // Record a success in database
            var success = GetCurrentSuccessCountFromDB();
            SaveSuccessCountToDB(success+1);
        }
    }

    public void RecordFailure(int batchId){
        lock(objLock){
            // Record a failure in database
            var success = GetCurrentFailureCountFromDB();
            SaveFailureCountToDB(success+1);
        }
    }
}
```

락을 거는 것의 목적은 동시에 해당 영역에 두개이상의 스레드들이 접근 불가하도록 하는것인데, 
10 개의 스레드가 락을 얻으려고 한다고 가정할때 순차적으로 락을 얻게 된다. 

task 와 async/await 으로 위와 같은 코드를 작성하는 경우 async/await 의 이점을 제대로 누리지 못하고 
스레드들이 잠기게 될것이다. (it ain't async over here)
- 때문에, 컴파일조차 안되게끔 컴파일러에서 막고있다. (이건 nolleh 의 경험상 적은 문구.)

그럼 어떻게 async 하게 wait 할수있을까?
이걸 위해 semapore 와 semaporeslim 이 있음.

세마포어는 IPC 에서 사용할수 있고
세마포어 슬림은 어플리케이션 레벨에서 사용할 수 있다.  
`` -> 이제 blocking 에서, suspended 된다.``
요렇게 사용하면 됨. 
```
public class LockTest{
    private readonly SemaphoreSlim _lock= new SemaphoreSlim(1, 1);

    public async Task RecordSuccess(int batchId){
        await _lock.WaitAsync();
        try{
            // Record a success in database
            var success = GetCurrentSuccessCountFromDB();
            SaveSuccessCountToDB(success+1);
        }
        finally{
            _lock.Release();
        }
    }

    public async Task RecordFailure(int batchId){
        await _lock.WaitAsync();
        try{
            // Record a failure in database
            var success = GetCurrentFailureCountFromDB();
            SaveFailureCountToDB(success+1);
        }
        finally{
            _lock.Release();
        }
    }
}
```

- nolleh 의 경험상, 여기에서 추가로 더 알아 둬야할 게 있는데, (reentrance 관련)
해당 컬럼은 본 블로그의 같은 카테고리-다음글-에서 찾아볼수 있다.

[이어보기 - NeoSmart.AsyncLock 라이브러리에 관하여](https://nolleh.github.io/csharp/async-await/)
