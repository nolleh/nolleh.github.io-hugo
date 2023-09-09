---
title: "Internet Speed"
date: 2023-09-09T15:36:52+09:00
draft: false
category: ubuntu
---

라즈베리파이에서 우분투를 설치해서 사용하고 있는데, 
인터넷 속도가 어마하게 느린 이슈가 있다. 

거기서 개선을 위해 시도해본 것들에 대해 기록할 예정.

일단 다음은 확실히 효용이 있는 것으로 보임. 

60mb -> 140mb 정도로 개선됨. 


```bash 
sudo iwconfig wlan0 power off
```

