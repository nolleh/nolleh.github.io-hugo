---
title: "Shell"
date: 2023-01-01T10:44:05+09:00
draft: false
categories: ["Cheatsheet"]
tags: ["Cheatsheet", "unix", "Linux"]
author: "nolleh"
---

# Cheatsheet - Shell

쉘 커맨드들을 자주 까먹곤 해서 자주쓰는것 위주로 생각날때마다 하나씩 등록 예정.

## Primitives

### if statement

```zsh
if [ 10 -gt 20 ]; then echo 'gt'; else echo 'lt'; fi;
```

| operator | desc                       |
| -------- | -------------------------- |
| !        | not true                   |
| -n       | 문자열의 길이가 0보다 크다 |
| -z       | 문자열의 길이가 0이다      |
| =        | 문자열이 같다              |
| -eq      | 정수가 같다                |
| -gt      | 정수가 크다                |
| -lt      | 정수가 작다                |
| -d dir   | dir 디렉토리가 있다        |
| -e file  | file 이 있다               |

### for statement

```zsh
for file in *.sh; do echo $file; done
```

echo 로 출력해보면 마지막 값이 나오는것을 보면, file 이라는 변수에 값을 하나씩 할당하고  
for 문 바깥에서도 유효함 (스코프바깥) 이 확인된다.

## heredoc

```zsh
cat > file.txt <<EOF
hello
this is nolleh
EOF
```

표준입력으로부터 파일을 생성하는 구문이다.
이렇게도 사용할 수 있지만,
쉘스크립트를 사용할때 아래와 같은 구문을 작성함으로써
복수의 라인을 변수로 선언하는 형태로도 사용가능하다.

```zsh
sql=$(cat <<EOF
SELECT foo, bar FROM db
WHERE foo='baz'
EOF
)
```

## Futher

### strip string

let's say you want to strip 'sh'

```zsh
echo ${a/.sh}
```

궁금해서 이렇게도 돌려봄.

```zsh
test=aaabbb
echo ${test/a}
```

결과는 `aabbb`
recursive 하게 제거하지 않고, first occurrence 를 제거

curly brace 내부가 평가되어 rvalue 에 evaluation 될 수 있도록 감싸주는것을 잊지 말자.

### list all files in directories

조금 재미있는건 이 명령어와

```zsh
for file in ./*; do echo $file; done
```

이 명령어의 결과가 다르다는 점이다.

```zsh
for file in *; do echo $file; done
```

ls ./* 평가 결과와 ls *의 차이로 봐도 무관할듯.  
어떤 폴더의 결과를 출력할때 상대경로의 유무가 그 결과에도 함께 반영이 된다.

만약 순수하게 파일명만 가져오고 싶다면 후자를 사용해야할 것.
