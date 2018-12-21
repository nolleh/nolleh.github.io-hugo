---
title: "Async Await"
date: 2018-12-18T13:47:33+09:00
Categories: ["csharp"]
Tags: ["C#", "Programming", "async", "await"]
Author: "nolleh"
---

# NeoSmart.AsyncLock 라이브러리에 관하여

> 다음에서 발췌, 번역 - [Neosmart Docs.](https://neosmart.net/blog/2017/asynclock-an-asyncawait-friendly-locking-library-for-c-and-net/)

## 개요
---
semaporeslim 은 reentrance 를 지원하지 않는다. 따라서,
recursion 에서 적절히 사용되지 않으면 데드락이 발생한다.   
asynclock 은 reentrance 기능을 semaphoreslim 에 추가한거. 

## 대안
---
간단한 방법은  semaphoreslim 으로 교체하고, recursion 인 경우를 스레드 아이디로 확인 하는 것.   
이 경우의 문제는  
    async / await 의 가장 기본적인 목적인 ui 의 불필요한 블럭킹 없이 작업의 완료를 기다린다는 문제를 그대로 안고 있다. 

await 코드를 넣어도 다른 코드가 실행 될 수 없다.   
  

```
class ThreadIdConflict
{
    BadAsyncLock _lock = new BadAsyncLock();

    async void Button1_Click()
    {
        using (_lock.Lock())
        {
            await Task.Delay(-1); //at this point, control goes back to the UI thread
        }
    }

    async void Button2_Click()
    {
        using (_lock.Lock())
        {
            await Task.Delay(-1); //at this point, control goes back to the UI thread
        }
    }
}
```
  

원래 메인스레드는 메시지 펌핑을 하면서 콜백을 호출해주는 구조로 되어 있고, 

"hard" await 을 마주쳐서 메인 ui 로 돌아갈때도  
이벤트 핸들러의 실행을 일시 정지하지만 실제 스레드가 동작을 멈추지는 않는다.   
await 이 완료 되고 나면, continuation 이 다시 main 스레드에서 실행된다. 

여기에서 중요한 것은, 항상 같은 스레드가 실행된다는 것이다. (non- awaited async 함수 호출을 제외하고.) <B> ``Button1_Click() 을 실행한 스레드가 await 을 만나 동작을 정지하고, 이후 Button2_cllick 을 호출한다.`` </b>   
Button1_click() 의 남은 코드는 옆에 놓여지는거지, 실제로 정지 되는것이 아니다. 이 의미는, Button2_click 이 실행되어야할 때 Button1_click() 은 세마포어를 통해 상호 배제적인 접근을 하고 있으므로 접근 불가해야하나, owningthreadId 가 같으므로 두 메소드가 동시에 실행된다.   
  
## AsyncLock  
---

 그럼 어떻게 해야하는가? recursion 을 체크하기위해 뭔가 다른 방법을 찾아야한다. 
`Envrionment` 클래스를 통해 스택 트레이스에 접근 할 수 있다. 
이를 락을 얻기 위한 요건으로 사용할 수 있지 않을까 ?   

> Update 5/25/2017 (AsyncLock 은 이제는 taskid 를 통해 확인하고 있다. )


```csharp
List _stackTraces = new List();
async Task Lock()
{
    if (!lock.locked)
    {
        _stackTraces.Add(Environment.StackTrace);
        lock.Wait();
        return true;
    }
    else if (_stackTraces.Peek().IsParentOf(Environment.StackTrace))
    {
        _stackTraces.Add(Environment.StackTrace);
        return true;
    }
    else
    {
        //wait for the lock to become available somehow
        return true;
    }
}
```

Lock() 의 호출이 스택추적을 낭비하지 않는다고 가정하면,(?) isParentOf 메소드가 현재 호출이 저장된 스택트레이스의 자식인지 확인한다.    

하지만 이런 접근은 첫번째 솔루션으로는 쉽게 해결 됐을 다음 코드를 처리하지 못한다.

```csharp
class StackTraceConflict
{
    BadAsyncLock _lock = new BadAsyncLock();

    async void DoSomething()
    {
        using (_lock.Lock())
        {
            await Task.Delay(-1);
        }
    }

    void DoManySomethings()
    {
        while(true)
        {
            DoSomething(); //no wait here!
        }
    }
}
```

모두 같은 지점에서 실행되기 때문에 다른 스레드에서 같은 스택트레이스를 갖게 되고 완벽하게 실패하게 된다!

따라서 적절한 솔루션은, 두 솔루션을 결합하는 것이다. 

```csharp
class AsyncLockTest
{
    AsyncLock _lock = new AsyncLock();
    void Test()
    {
        //the code below will be run immediately (and asynchronously, in a new thread)
        Task.Run(async () =>
        {
            //this first call to LockAsync() will obtain the lock without blocking
            using (await _lock.LockAsync())
            {
                //this second call to LockAsync() will be recognized as being a reëntrant call and go through
                using (await _lock.LockAsync())
                {
                    //we now hold the lock exclusively and no one else can use it for 1 minute
                    await Task.Delay(TimeSpan.FromMinutes(1));
                }
            }
        }).Wait(TimeSpan.FromSeconds(30));

        //this call to obtain the lock is synchronously made from the main thread
        //It will, however, block until the asynchronous code which obtained the lock above finishes
        using (_lock.Lock())
        {
            //now we have obtained exclusive access
        }
    }
}
```

task 가 먼저 실행되도록 하기위해 30 초를 대기했다가 평범하게 락을 건다.   
첫번째 락은 평범하게 얻어진 뒤에, 다시 reentrant call 이 발생하고, 이것 또한 넘어가게 된다. (# await 실행된 스레드아이디 + 실행된 콜스택의 부모)  

Task.Delay 를 마주쳐서 스레드는 pause 상태로 전환되고, _이 시간동안 공유되는 리소스에 대해 배제적 접근을 하게 된다._   

30 초 뒤에 lock 을 얻으려고 시도할때, 이 시도는 실패하게 되고  
다시 30초 뒤에 task 가 완료되어 lock 을 release 하게 되면 메인스레드가 락을 얻어 동작이 재개 된다. 

이 코드 조각은 두개의 락 옵션을 사용하고 있다. Lock() 과 LockAsync() 인데, 이들은 둘다 기본 개념은 같고, async 메소드는 async/ await 패러다임을 품어 이 실행이 lock 이 사용 가능할때에 새로 얻을 수 있도록 한 개념이다. 이렇게 해서 await lock.LockAsync() 가 블러킹 되지 않도록 한 것이다. 