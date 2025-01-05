---
title: "Optimize Speed"
date: 2023-09-09T15:36:52+09:00
draft: false
category: ubuntu
tags: [linux', "ubuntu", "raspberry pi"]
---

라즈베리파이에서 우분투를 설치해서 사용하고 있는데,
인터넷 속도가 어마하게 느린 이슈가 있다.

거기서 개선을 위해 시도해본 것들에 대해 기록할 예정.

##1. iwconfig

일단 다음은 확실히 효용이 있는 것으로 보임.

60mb -> 140mb 정도로 개선됨.

```bash
sudo iwconfig wlan0 power off
```

##2. zram

그리고나서, zswap 대신 zram 을 사용하도록 변경.

```Bash
sudo apt install -y linux-modules-extra-raspi

sudo apt install -y zram-tools
sudo apt autoremove --purge -y zram-config

sudo nvim /etc/default/zramswap
```

에디터는 어떤걸 사용해도 상관없지만, nvim 사용하고 있어서 그걸로 세팅.
해당 설정파일에서 다음 데이터들 세팅. (대부분 주석처리 되어있는걸 푸는 형태)

ALGO=zstd
PERCENT=50
PRIORITY=100

##3. use GOOGLE DNS server

ISP 제공자들의 DNS 서버가 느리기때문에,
구글의 DNS 를 사용하도록 설정

setting -> DNS :
IPv4: 8.8.4.4, 8.8.8.8
IPv6 DNS : 2001:4860:4860::8888, 2001:4860:4860::8844

##4. Nala mirror

```
sudo apt install nala
sudo nala fetch
```

여기까지 설정을 하고 나니 200Mbps 정도 나오고,
크롬탭 몇개 켜놔도 (4개) + tmux + alacritty 돌리는데 무리없는 수준이 됨. cpu 항상 100% 치고 있었는데  
60~70% 정도 수준.

cf. https://teejeetech.com/2022/06/04/tweaks-for-ubuntu-22-04-on-raspberry-pi-4/
