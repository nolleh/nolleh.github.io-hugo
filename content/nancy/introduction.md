---
title: "Nancy Introduction"
date: 2018-04-24T21:43:04+09:00
Categories: ["Nancy"]
Tags: ["Programming", "C#"]
Author: "nolleh"
---

[Nancy 에 대한 문서 번역 #1](https://github.com/NancyFx/Nancy/wiki/Introduction). By Nolleh

## Introduction  
---
가장 먼저, Nancy 의 세계에 온것을 환영합니다!  
루비의 sinatra 프레임워크에 영감을 받아 Nancy 라는 이름을 붙이게 되었습니다. (Frank Sinatra 의 딸이름이 Nancy 니까요!)   
NancyFx 의 Fx 에 대해 많은 사람들이 궁금해하여 여기에 붙입니다만, framework 라는 뜻입니다 :)   
NancyFx 는 모든 컴포넌트들을 포함하는 umbrella project 입니다. (#역자주: 우산효과의 우산처럼, 포괄적인 프로젝트라는 의미로 쓴게 아닐까? )  

이 가이드는 앞으로 개괄적이고 빠르게 Nancy 의 특징들을 살펴 독자 스스로 Nancy 의 세계를 탐험해 볼 수 있는 시야를 제공할겁니다.  

Nancy 는 가볍고, 작은 세레모니의 HTTP 기반의 서비스를 개발할 수 있는 .Net 과 [Mono](http://mono-project.com/) 기반 프레임 워크입니다.  
이 프레임워크의 목적은 모든 상호 통신(ineractions)을 신경쓰지 않으면서도 동시에 슈퍼-엄청-행복한 방법으로-(super-duper-happy-path) 제공하는 것입니다.  

이 말은 Nancy 를 통한 모든 것들이 당신을 개고생하게 만드는 설정 지옥에서 벗어날 수 있도록 관습적이고/기본적인 설정 값을 적극 활용하는 것을 의미합니다.   
Nancy 와 함께라면 아무것도 없는 상태에서 수 분안에 웹사이트를 만들 수 있습니다. 문자 그대로요!!  

Nancy 는 DELETE, GET, HEAD, OPTIONS, POST, PUT, PATH 요청을 단순하고 우아한 [Domain Specific Language (DSL)](http://en.wikipedia.org/wiki/Domain-specific_language) 을 몇번의 타이핑만으로 응답으로 전달하도록 디자인 되어 있어 당신은 다른 좀 더 중요한 당신의 코드, 당신의 어플리케이션에 집중 할 수 있도록 하였습니다.  

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

---