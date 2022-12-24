---
title: "Mac Cheat"
date: 2022-08-24T00:49:49+09:00
draft: true
Categories: ["개발환경"]
Tags: ["env", "mac", "unix", "linux" ]
---

[stackoverflow](https://stackoverflow.com/questions/41840479/how-to-use-homebrew-on-a-multi-user-macos-sierra-setup)

## 유저그룹으로 권한 설정

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

## 공식 문서 제안법

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
