---
title: "Unix 01 Intro"
date: 2017-08-01T22:54:19+09:00
Categories: ["Unix Network Programming"]
Tags: ["생각하는 프로그래머", "OS", "Unix"]
Author: "nolleh"
---

> 네트워킹의 바이블이라 할 수 있는 Unix Network Programming 의 내용 정리

# Books Introduction
Socket 을 통해 통신하는 프로그램을 작성하는 개발자를 위해 쓰여진 책.  
시작하는 사람에게나, 프로페셔널에게나 유용한 책.  
물론 유지보수를 하거나, 새로 작성하는 사람, 네트워크 시스템 함수를 이해하는 모두에게 유용하다.  

실제 텍스트들은 유닉스 시스템에서 구동가능하나, OS 에 독립적인 socket api 를 지원하는 다른 OS 에서도, 본문에서 제안하는 일반적인 개념을 활용가능하다.  
많은 OS 는 셀수 없이 많은 네트워크 응용프로그램을 제공하고 있으며 - 예컨데 웹브라우저, email.. 
이 프로그램들을 클라이언트와 / 서버로 분류하여 언급할 것이다.  

# Using This Book
초심자와 전문 프로그래머 모두 활용가능하다. 튜토리얼이 목적이라면 Part2 에 포커스를 맞추면 좋으며,  여기서 TCP 와 UDP, SCTP 모두에 대한 소켓 함수를 다루고 I/O multiplexing, socket options, basic name, address conversion 등을 다룬다.  
Section 1.4 에서는 본문 전체에서 다루는 래퍼펑션들이 소개된다.  
Part 3 에서는 "진화된 소켓" 에 대해 다루므로 아무나 읽어도 된다.  
소스코드는, 여기  
[unpbook](www.unpbook.com)
