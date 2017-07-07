---
Categories: ["개발환경"]
title: "How To Make Git Page"
date: 2017-07-07T21:22:50+09:00
Tags: ["GitHub-Page", "Editor"]
---

# GitHub-Page
이런게 있다더라 ~ 라고 주변으로부터 처음 들은건 1~2년전이었던것 같은데  
갑자기 꽂혀서 git page 를 만들었다. (!!)  
github 에서는 1계정당 1 호스트를 제공하는 것 같고   

``` <ID>.github.com  ```
  
뭐 이런식? github 의 제공 영역은 repo 에 존재하는 index.html 을 repo 에 지정된 1 도메인과   
연결해주는 정도인 것 같다. 

# Repository
git 을 사용해 본 적이 있다면 간단하다.  
그렇다면 다음 절로 넘어가고, 그렇지 않다면, 다음을 따라하자.   

## github 가입
이 항목에 있어 더 이상의 자세한 설명은 생략한다.
[github](https://github.com)

## sshKey
여기를 따라하자.
[github-gen-sshkey](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/)

## github repo 생성
* github 본인 메인 페이지에서 Repositories
* New 버튼
* 안내에 따라 따라하기
    - 즉, 로컬의 git repo 대상 폴더에서 git init
    - git add -A
    - git commit -m "some-message"
    - git remote add origin git@github.com:<ID>/<Repo>.git
    - git push -u origin master

이제 github 에 repository 를 올릴수 있게 되었다! 

## 내 Repo 를 GithubPage 로 지정하기  
본 repo 에서 <ID>.github.com 의 index.html 을 찾도록 github 에 알려주자.  

![세팅](./images/github-setting.png =100x20)


# MarkDown-To-HTML
잘은 모르겠지만.. github 페이지에서는 유독 MarkDown 을 통해  
html 을 작성하는게 잘 권장? 되어있는거 같고,  
- 아마도 git page 의 최초 제공 목적 자체가 블로그가 아니라 위키 정리와 같은 마크업 언어로 간단하게 문서를 작성하는 데에 있었기 때문일거다 -  

jekyll 이나 hugo 를 통해 MarkDown 으로 작성된 문서를 자동으로 html 로 생성할 수 있다.  


## Hugo 
사실 jekyll 을 많이들 쓰고 있는 것 같고 공식적으로 지원? 하는 것 같은데 
내 맥 PC 의 버전으로 ruby 가 잘 설치가 안되서 괴로워하던 중에 지인이 hugo 를 사용하는 것을 보고 그냥 hugo 를 선택했다. 나름 괜찮은 듯.  
공식 가이드는 다음을 살펴보면 되고,  
[Quick-Start](https://gohugo.io/overview/quickstart/)

내가 따라가면서 확인한 주요한 내용은 다음과 같다.  
### Hugo OneStep 
```Bash
# 휴고 설치
$ brew install hugo

# 사이트 생성
this/is/my/github/repo$ hugo new site

# 포스트 생성
this/is/my/github/repo$ hugo new post/hello-world.md

# 포스트 수정
this/is/my/github/repo$ vim content/post/hello-world.md

# 로컬에서 확인하기
this/is/my/github/repo$ hugo server ## http://localhost:1313 에서 확인

```

### Hugo - 사이트 꾸미기

#### hugo 가 올바르게 generate 하기 위한 설정 값 지정

```Bash 
this/is/my/github/repo$ vim config.toml

### .... config.toml
baseurl = "https://nolleh.github.io"
languageCode = "ko-KR"
title = "The Computer Programmer, Nolleh"
theme = "hello-programmer"
Paginate    = 2                    # the number of posts per page
disqusShortname = "your-disqus-short-name"

[params]
    author = "nolleh"
    locale = "ko-KR"

```

#### hugo 의 테마
페이지를 예쁘게 구성하기 위해, 많은 개발자들이 오픈소스로 공개한 테마를 활용할 수 있다.  

1. [Hugo-Theme-ShowCase](http://themes.gohugo.io/)  
2. [All-Themes-Github](https://github.com/dim0627/hugoThemes)

1 에서 각 테마의 섬네일을,  
2 에서 각 테마의 repository 를 확인하여 clone 받을 수 있다.  
본인의 gitpage repo root/themes 로 이동하여 2의 repo 를 clone,
위에서 기술한 config.toml 의 theme 항목을 지정하는 것으로 테마를 변경 할 수 있다. 

### Hugo - Generate
앞서 기술한 hugo - onestep 의 마지막 라인의 hugo server 라인을 통해 html 파일을 생성, http://localhost:1313 에서 확인할 수 있지만 이 html 들을 repo 에 올리면 css 파일을 찾지 못해  원하는 대로 페이지가 렌더링 되지 않는다.  
css 파일을 서버에서 찾을 수 있도록  
hugo server 실행시 추가 파라메터를 제공, 로컬이 아니라 배포용의 html 을 생성할 수 있도록 하자.
- 이것때문에 얼마나 삽질을 했던지!  

```Bash
$ sudo hugo server --baseUrl=https://nolleh.github.io --destination=public/ --port=80 --appendPort=false
```

### Deploy 
Generate 할때, destination 을 public 으로 지정하였으므로 public 디렉토리에 생성된다. 
이 폴더 전체를 다시 github repo 를 생성해서 올려두자.

```Bash 
this/is/my/github/repo/public$ git init 
this/is/my/github/repo/public$ git add -A
this/is/my/github/repo/public$ git commit -m "my awesome site"
this/is/my/github/repo/public$ git push ...
```

**끝!**


