+++
Categories = ["개발환경"]
Description = "개발 환경 - Brew"
Tags = ["MacOS"]
date = "2017-07-04T22:31:23+09:00"
title = "Brew Install 이 구버전만 설치할 때"
+++

## Let's 사족
처음 회사에 입사 했을 때 자리에는 Mac PC 만이 덩그러니 있었고, Mac 을 사용해본적 없던 꼬꼬마는 
자연스럽게 윈도우 CD 를 인사팀에서 받아와서 깔고 있었드랬다.   
  
> "기껏 좋은 컴퓨터 줬더니 넌 뭘하고 있는거니?"  
  
라는 선배의 말을 듣고 그제야 맥에서도 안드로이드 개발이 되는거구나.. (이때는 현업 안드로이드 개발자였다.)  
하곤 윈도우 설치페이지를 취소하고 다시 맥 OS 를 부팅했었지.  
   
이때가, Mac OS 와의 첫 만남이었드랬다.   

## Brew
뭐 전혀 관계 없는 얘기로 포스트를 열었지만.  
어쨌거나 그때부터 Mac 을 수년간 사용하면서 - 그때 쓰던 회사 Mac 은 여전히 내 사무실 책상의 한켠을 차지하고 있다 -   
Mac 을 비롯한 Linux 계통에서 Windows 를 압도하는 장점을 들자면,   

> 개발자를 위한 환경 설정이 간편하다

가 되겠다.   
Mac 에서는 그 역할을 충실히 하는 요소 중에 하나가 "HomeBrew" 라 하겠고.  
[HomeBrew] (http://docs.brew.sh/)

### Brew 설치
> 다음 라인을 터미널에서 실행하자. brew 설치 자체도 이렇게 간편하다니.. Linux 계통은 보통 이렇게 one line 으로 다 해결이 된다.

```Bash
mkdir homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C homebrew
```
  
### Brew 를 통해 설치하기
Formula 라고 지칭하고 있는게 맞는지는 잘 모르겠지만.  
brew 를 통해 프로그램/binary 를 설치할 경우 다음과 같이 실행  

#### 최초 설치
```Bash
$ Brew install ${Formula}
```
#### 업데이트
```Bash
$ Brew upgrade ${Formula}
```

### Brew Install 이 구 버전만 다운로드 받을 때
이건.. 맥을 사용한 지금까지 잘 모르고 있었던 건데,  
Brew 자체를 업데이트해서 formular 를 갱신할 필요가 있나보다.  
다음을 통한다. 

```Bash
$ Brew update
```

### 업데이트시 다음 에러 노출시
```Bash
$ Error: /usr/local must be writable!
```

다음 실행

```Bash
sudo chown -R $(whoami) /usr/local
```

