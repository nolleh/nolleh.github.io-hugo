---
title: "Mac 터미널에서 복수의 유저 사용하기"
date: 2022-08-24T00:49:49+09:00
draft: false
categories: ["개발환경"]
tags: ["env", "MacOS", "unix", "linux", "cheatsheet"]
---

# 복수의 유저 사용하기

맥터미널에서 복수의 유저를 사용하려면 몇가지 신경써야할 부분들이 생긴다.  
home directory 가 분리 되어 있기 때문에 어떤 유저를 위해 설치한 데이터들은  
다른 유저에서는 사용못할수도 있고 (그러는게 맞고, 그럴려고 격리한거니)  
그러다보니 양쪽에서 같은 데이터를 설치해야하나 ?  
혹은 서로 충돌이 난다거나 하는 불편함들이 생긴다.

대표적인 예로 brew 에서 이런 문제가 발생하는데,,  
어떤 계정으로 설치한 패키지가 다른 계정에서 권한문제로 접근이 안되게 되면서 엉망이 된다.. (-\_--)
dependency 가 있는 다른 패키지 들과도 맞물리게 되면서 내가 설치한 패키지가 아닌 패키지에 대해 데이터를 바꾸려고 하면서 권한 이슈로 연결 되는식.

트러블 슈팅 진행하면서 겪은 해결책들을 여기에 기록하고자한다.

## 1.brew

첫번째(유저그룹변경) / 두번째 (별도 brew 생성) 방법이 있는데 용량 아껴볼려고 첫번째 방법으로 고통받아봤는데,  
잘 해결은 안됐기 때문에 개인적으로 두번째 방법을 추천한다.

[stackoverflow](https://stackoverflow.com/questions/41840479/how-to-use-homebrew-on-a-multi-user-macos-sierra-setup)

### 1-1. 유저그룹으로 권한 설정

example. brew

```bash
echo $(brew --prefix)
echo $(groups $(whoami))
sudo dseditgroup -o edit -a $(whoami) -t user admin
sudo chgrp -R admin $(brew --prefix)
sudo chmod -R g+rwX $(brew --prefix)
ls -lah $(brew --prefix)
```

순서대로,

1. brew install path 확인하고
2. 내 그룹 확인하고.
3. 2에서 어드민 그룹에 없다면 어드민 그룹에 넣고
4. 어드민 그룹으로 폴더 recursive 하게 소유권 변경
5. 어드민 그룹에 있는 유저들에 대해 읽기,쓰기,실행 권한 부여
6. 권한 확인

---

### 1-2. 공식 문서 제안법

하나도 사용하지 않거나, 하나의 글로벌 brew 설치를 하고, 모든 다른 유저들에서 지역 버전을 사용하는것이 공식 제안 법.

```bash
cd $HOME
git clone https://github.com/Homebrew/brew.git
./brew/bin/brew tap homebrew/core
```

```
export PATH=$HOME/brew/bin:$PATH >> ~/.zshrc # or ~/.bashrc
```

```
exec $SHELL
which brew
```
