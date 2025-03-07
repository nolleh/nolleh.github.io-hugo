---
date: "2017-07-04T00:45:55+09:00"
title: "C++ CLI 에서 managed 콜백을 unmanaged 로 전달하기"
categories: ["C++ CLI"]
tags: ["C++ CLI"]
author: "nolleh"
---

파라미터가 없다면 DelegateToPointer 로 마샬링해서 전달하면되는데,  
이러면 파라미터를 마샬링할 기회가 주어지지 않는다는게 문제다.  
좀 구글링을 해봤는데,  
이런 포스트가 있었다.

[스택오버플로-파라미터와 함께 unmanaged 콜백으로 변환하기](https://stackoverflow.com/questions/32386851/managed-to-unmanaged-callback-with-managed-parameters)

채택된 답변을 살펴보면 클래스 구조는 대략 다음과 같다.

#### 클래스 구조

> 1. NativeCallbackHandler - msclr::gcroot<OutputManaged^> m_owner (OutputLogManaged) 를 멤버로 보유.
> 2. OutputLogManaged - native OutputLog\* (m_nativeOutputLog) / 1의 Holder 를 보유 (m_nativeHandler)] / 그리고 managed 콜백을 보유
> 3. OutputLog - Native Callback 과 void\* UserData 를 멤버로 보유.

이해하는데 주요한 클래스는 위 내용 정도인 듯.

- Main 함수에서는 managed 로거와 native 에 적당한 콜백을 등록해 두고(OnError/GetNative()), Test 함수를 통해 콜백을 호출한다.

- OutputLogManaged 에는 생성시에 1의 NativeCallbackHandler 가 생성되며 여기에 정의된 native callback 을 OutputLog 의 Callback 멤버변수에 세팅한다.
  동시에 NativeCallbackHandler 를 this 로 해서 함께 UserData 라는 객체로 OutputLog 의 멤버로 등록을 한 상태이다.  
  (다시 말해 OutputLog 의 UserData 에는 1의 인스턴스가, 같은 객체의 멤버 변수인 NativeCallback 타입에는 그 인스턴스의 함수가 등록이 되어있다.)

- 1의 콜백을 지닌 3 의 객체의 함수를 등록해두었고, 이 함수에서 1의 콜백을 호출하고 있으므로 1의 콜백이 호출이 되는데 (등록해두었던 umanaged 콜백이 호출되는 단순한 전개라 하겠다.)  
  이때 OutputLog(3) 의 객체의 멤버함수(최초로 호출되는 콜백)에서 멤버변수로 보유한 NativeCallbackHandler(1) 객체를 1의 콜백의 파라미터로 전달, 콜백 등록 당시의 NativeCallbackHandler(1) 의 인스턴스를 얻어온다 (물론, 콜백을 여러개 등록할 수 있으므로. 각 인스턴스를 별도로 두는 것이 자연스럽다.)  
  이 인스턴스의 멤버인 m_owner 를 통해 OutputLogManaged 의 managed 콜백을 호출한다.

내용을 말로 설명하려고하니 불필요하게 복잡해진 느낌인데,  
정리하면 다음과 같다.

#### Summary

unmanged 에서 Managed 의 객체를 들고 있다가 unmanaged 의 콜백이 호출될때 마샬링하여 Managed 의 콜백을 호출한다.

C++/CLR 을 처음 접하고 필요에 따라 구글링으로 작업을 하다보니 managed 와 unmanged 사이에서 서로 멤버로 두려고 하면 컴파일 에러가 나길래
안되는 거구나..했는데.. 이런 기능이 있었나보다...

```cpp
msclr::gcroot<...>
```

> gcroot 는 unmanaged 에서 managed 를 참조하는 방법이며, interop 에서는 레퍼런스 카운트를 하나 증가시킨다.  
> [참고 - gcroot 의 역할](https://stackoverflow.com/questions/8458886/what-is-a-rooted-reference)

약간 허무하군.. (그래 안되면 어떻게 쓰겠냐만서도.. )

[참고 - MSDN / How to: Declare Handles in Native Types](https://msdn.microsoft.com/en-us//library/481fa11f.aspx)
