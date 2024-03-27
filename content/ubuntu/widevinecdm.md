---
title: "struggles to view OTT on UBUNTU X raspberry Pi 5 - A.K.A using Widevinecdm"
date: 2024-02-25T16:59:57+09:00
draft: true
---

라즈베리파이5 * Ubuntu 에서DRM 스트리밍서비스 (OTT) 를 이용하려고 여러 글들을 살펴봄. 

https://github.com/brave/brave-browser/issues/28903

https://support.brave.com/hc/en-us/articles/23881756488717-How-do-I-enable-Widevine-DRM-on-Linux

https://forum.radxa.com/t/lets-get-widevine-working/15391

https://github.com/raspberrypi/Raspberry-Pi-OS-64bit/issues/248

음 다안된다.
구글에서 제공하는 widevinecdm 컴포넌트/라이브러리가 필요한 모양인데
대략 해석해보면 구글에서 공식적으로 지원하는 aacrch 용은 없는 모양이고 
일부 오픈소스에서 chrome OS 용으로 제공하는 python 스크립트로 라이브러리를 좀 변조하는 형태로 시도한 내용들이 보이는데

vivaldi 브라우저에서 컴포턴트가 드디어 노출되는건 확인했지만  
해당 라이브러리가 정상적으로 동작하지는 않는모양.  

그냥 라즈베리파이에서는 공식 제공하는 라즈비안OS 를 사용하는 게 그냥 마음 편할듯.  

다만 난 우분투를 계속 가지고 놀 작정이라 일단 OTT 는 그냥 포기해야하겠다. 

한 세달뒤 쯤에 다시 도전해 봐야지...

