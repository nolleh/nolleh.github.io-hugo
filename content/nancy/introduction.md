---
title: "Nancy Introduction"
date: 2018-04-24T21:43:04+09:00
Categories: ["Nancy"]
Tags: ["Programming", "C#"]
Author: "nolleh"
---

> [Nancy 에 대한 문서 번역 #1](https://github.com/NancyFx/Nancy/wiki/Introduction). By Nolleh

## Introduction  
---
가장 먼저, Nancy 의 세계에 온것을 환영합니다!  
루비의 sinatra 프레임워크에 영감을 받아 Nancy 라는 이름을 붙이게 되었습니다. (Frank Sinatra 의 딸이름이 Nancy 니까요!)   
NancyFx 의 Fx 에 대해 많은 사람들이 궁금해하여 여기에 붙입니다만, framework 라는 뜻입니다 :)   
NancyFx 는 모든 컴포넌트들을 포함하는 umbrella project 입니다. (#역자주: 우산효과의 우산처럼, 포괄적인 프로젝트라는 의미로 쓴게 아닐까? )  

이 가이드는 앞으로 개괄적이고 빠르게 Nancy 의 특징들을 살펴 독자 스스로 Nancy 의 세계를 탐험해 볼 수 있는 시야를 제공할겁니다.  

Nancy 는 가볍고, 적은 준비의식(#역자주: 라이브러리를 쓰기 위한 선제 작업)의 HTTP 기반의 서비스를 개발할 수 있는 .Net 과 [Mono](http://mono-project.com/) 기반 프레임 워크입니다.  
이 프레임워크의 목적은 모든 상호 통신(ineractions)을 신경쓰지 않으면서도 동시에 슈퍼-엄청-행복한 방법으로-(super-duper-happy-path) 제공하는 것입니다.  

이 말은 Nancy 를 통한 모든 것들이 당신을 개고생하게 만드는 설정 지옥에서 벗어날 수 있도록 관습적이고/기본적인 설정 값을 적극 활용하는 것을 의미합니다.   
Nancy 와 함께라면 아무것도 없는 상태에서 수 분안에 웹사이트를 만들 수 있습니다. 문자 그대로요!!  

Nancy 는 DELETE, GET, HEAD, OPTIONS, POST, PUT, PATH 요청을 단순하고 우아한 [Domain Specific Language (DSL)](http://en.wikipedia.org/wiki/Domain-specific_language) 을 몇번의 타이핑만으로 응답으로 전달하도록 디자인 되어 있어 당신은 다른 좀 더 중요한 **당신의** 코드, **당신의** 어플리케이션에 집중 할 수 있도록 하였습니다.  

이 모든 것들은 [MIT License](http://www.opensource.org/licenses/mit-license.php) 의 오픈 소스 입니다. 

[Nuget, our TeamCity Server](http://teamcity.codebetter.com/project.html?projectId=project112&tab=projectOverview&guest=true) 와 [github repository](http://nancyfx.org/) 로부터 살펴 보실 수 있습니다.  

  

## Built to run anywhere
---
원하는 곳 어디에서든 빌드되고 실행될 수 있습니다.  
Nancy 는 어떤 존재하는 프레임워크에도 의존성이 없도록 디자인 되었습니다.  
request / response 객체 전부 자체에 포함되어 있으므로, [.NET framework client profile](http://msdn.microsoft.com/en-us/library/cc656912.aspx) 을 통해 빌드하여 Nancy 는 당신이 원하는 곳 어디에서든 사용될 수 있습니다.  
  
Nancy 의 핵심 개념중의 하나로 hosts 가 있습니다. 하나의 호스트는 nancy 와 호스팅 환경의 어댑터로서 동작하게 되므로 Nancy 를 기존의 존재하는 - ASP.Net, WCF, OWIN, 다른 통합 응용프로그램 - 기술에서 활용해보십시오.  
  
특정 호스트 구현은 Nancy 프레임워크의 핵심 기능을 제공하지 않을 수 있습니다. 이런 추가기능들 - 인증과 같은- 은 개별로 제공됩니다.  
Nancy 응용 프로그램을 빌드하는 것은 웹프레임워크의 buffet 으로부터 가장 좋아하는 부분을 뽑아내는 것과 같습니다!  Nancy 서비스를 빌드하는데 사용할 최소한의 부분은 핵심 프레임워크와 host 가 될 것입니다.  

## The super-duper-happy-path  
---
그 "super-duper-happy-path" (말을 줄이길 좋아하는 요새 사람들을 따르자면 **SDHP** 랄까요?) 란, Nancy 의 정신을 바로 짚는 용어라 하겠습니다;동시에 Nancy 의 API 를 이용하는 동안 "슈퍼-엄청-행복한-길" 에 대한 경험을 당신에게 제공하는 것이라 할 수도 있겠네요.  

결국에는 대단히 감정적 용어이기때문에 정확히 어떤 것인지 짚어보기 전에 이 배후의 아이디어를 살펴보도록합시다.  

- "그냥 동작해" - 이것 저것 할것 없이 하나 집어서 사용하면 됩니다. 새로운 모듈을 추가한다? 이것들은 다 당신을 위해 자동으로 이뤄집니다. 새로운 뷰 엔진을 쓴다? 당신은 아무것도 할 것 없이, 미리 준비되어 있습니다. 당신 모듈에 새로운 의존성을 추가하는 것마저 자동으로 injection 해줄겁니다! - 설정노노해!- 

- "쉬운 커스터 마이즈" - "그냥 동작해" 와 같은 기능이 커스터마이즈를 어렵게 할 것 같지만 그렇지 않습니다. 다른 컨테이너를 원하세요? 문제 없어요! 라우딩 되는 다른 경로를 원하세요 ? 하세요! 우리의 bootstrapper 가 이 모든 것들을 누워서 떡먹게 해줍니다.  

- "적은 준비 의식" - 당신의 응용 프로그램을 위한 Nancy code 의 양은 아주 적습니다. Nancy 응용프로그램의 중요한 부분은 당신의 코드입니다. 실제 동작하는 Nancy 어플리케이션이 다음의 [한 개의 트위터 글](https://twitter.com/Grumpydev/statuses/83495940048166912)로 작성될 수 있다는 게 바로 그 증거죠.   

- "적은 마찰" - Nancy 로 소프트웨어를 빌드할때 API 들이 도와줄 것입니다. 이름은 명확하고 요구되는 설정은 최소한이지만 강력한 성능과 확장성은 당신이 필요로 할 때 여전히 그 자리에 있어 줄 겁니다 :)

위 내용들을 종합해 볼때, Nancy 로 응용프로그램을 작성하는 것은 즐겁고 재밌을거예요! 하지만 응용프로그램이 성장할 수록 성능이나 확장성을 포기해야할 때가 올 수도 있죠..

## Creating your first Nancy application
---
이야기는 이제 충분합니다. 이제 코드를 봅시다! Nuget (혹은 Mono) 은 설치되어 있을 것이라 가정하겠습니다.  
(우리곁의 어디에나 있는) 유비쿼터스 "Hello World" 응용프로그램을 Nancy 와 Nancy 의 ASP.NET 호스팅으로 빌드해보겠습니다.  
  
1. visual studio 2012 이상이라면 [SideWaffle Template Pack for Visual Studio](http://sidewaffle.com/) 을, 2010 사용자라면 [Nancy project templates](http://visualstudiogallery.msdn.microsoft.com/f1e29f61-4dff-4b1e-a14b-6bd0d307611a) 을 설치합시다. 

2. `Nancy empty project with ASP.NET host` 메뉴 (sidewaffle) / `Nancy Empty Web Application with ASP.NET Hosting` 메뉴 (Nancy project template) 를 선택합니다.

3. `Nancy Module` 을 C# 클래스로 추가하고 root url 에 라우트 핸들러를 생성자에 작은 코드를 넣어 정의합니다:

4. Compile and run to see result ! 

5. 강제하진 않지만 권장하는 내용으로, 새로운 업데이트를 체크하기 위해 Nuget Package Manager 를 사용해보세요.

The HelloModule.cs code

```C#
public class HelloModule : NancyModule
{
    public HelloModule()
    {
        Get["/"] = parameters => "Hello World";
    }
}
```

모듈을 public 으로 선언하지 않으면 NancyFx 가 찾을 수 없으므로, 잊지마세요! 

## More Info
---
[- Why use NancyFX?](http://blog.jonathanchannon.com/2012/12/19/why-use-nancyfx/)
