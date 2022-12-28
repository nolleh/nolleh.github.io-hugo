---
title: "서브 모듈 추가하기"
date: 2022-05-29T16:37:55+09:00
categories: ["git"]
tags: ["version control", "tool"]
author: "nolleh"
draft: false
---

자주 사용하는 서브 모듈 명령어.

## add submodule

```bash
git submodule add {remote-repo}
```

## update

git submodule init

- git 에서 서브모듈을 관리하기위한 설정파일, gitmodules 를 설정한다.

```bash
git submodule update
```

- remote 저장소로부터 업데이트 내용을 가져와서 적용한다.

```bash
git submodule update --init
```

## remove submodule

```bash
git submodule deinit -f {path}
rm -rf .git/modules/{path}
git rm -f {path}
```
