---
title: "Neovim"
date: 2023-09-09T15:33:49+09:00
categories: ['ubuntu']
tags: ['nvim', 'neovim', 'linux']
draft: true
---

apt-get install neovim 과 같은 방법으로는 최신 버전을 설치 할 수 없다.

최신버전을 설치하려면, 다음 과정을 거쳐야한다. 

cf.https://github.com/neovim/neovim/wiki/Installing-Neovim

sudo apt-get install software-properties-common
- 이 명령어를 선행해줘야할 수도 있다. 

```bash
sudo apt-get remove neovim -y

sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update -y
sudo apt-get install neovim -y
```
https://launchpad.net/~neovim-ppa/+archive/ubuntu/unstable

ppa archive 를 살펴보고 원하는 아키텍쳐 / 버전이 없는경우 unstable 버전에서 찾아서 다시 반복해볼 필요가 있다.
다행히 unstable 버전은 ubuntu 23.04 를 지원하는게 있어서 받아서 씀...

sudo add-apt-repository ppa:neovim-ppa/unstable


이렇게 설치하고 나면, 
NvChad 를 세팅해보자.

 git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1 && nvim
 
nvim 을 실행해보면 에러가 발생한다.

snap 을 사용하는게 깔끔한듯.

sudo snap install --beta nvim --classic


