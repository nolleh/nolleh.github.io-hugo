---
title: "Writing Plugin"
date: 2023-01-14T14:00:53+09:00
draft: true
categories: ["vim"]
tags: ["env", "vim", "vim-plugin", "cheatsheet"]
---

# Writing Plugin

제목은 거창하게 썼지만, 플러그인이나 rc 파일 작성에 필요한 지식들을 메모해 둘 예정.

## Preview Window

```zsh
:botright pedit { file }
```

```zsh
:botright pedit
```

### Preview Window 에서 라인 출력

```zsh
function! showInPreview(name, fileType, lines)
    let l:command = "silent! pedit! +setlocal\\ " .
                  \ "buftype=nofile\\ nobuflisted\\ " .
                  \ "noswapfile\\ nonumber\\ " .
                  \ "filetype=" . a:fileType . " " . a:name

    exe l:command

    if has('nvim')
        let l:bufNr = bufnr(a:name)
        call nvim_buf_set_lines(l:bufNr, 0, -1, 0, a:lines)
    else
        call setbufline(a:name, 1, a:lines)
    endif
endfunction
```

[stackExchange](https://vi.stackexchange.com/questions/19056/how-to-create-preview-window-to-display-a-string)

이 함수는 프리뷰에 stdin 으로 데이터를 노출할 방법이 없을까 검색하다가 찾은 snippet 인데,

```
call ShowInPreview('this-is-test', 'sql', 'SELECT 0')
```

와 같은 구문으로 실행해보면 별도 파일없이 프리뷰에 데이터를 출력가능하다.
1번째는 버퍼이름, 두번째는 해당 버퍼에대한 파일 타입 정보를 전달하는 형태로 보여서
해당 펑션을 선언후에 파라미터들은 미리 정해놓고 shortcut 매핑을 해놓고 세번째 '내용' 만 전달하는 형태로 사용하면
꽤 쓸만할 것 같다.

문제는 그 내용을 유의미한 데이터를 얻어오는건데..

pipe plugin 이 쉘 명령어를 실행하고 이 결과를 프리뷰에 노출하는 형태로 구성되어있다.
ANSI color 코드랑 결합하면 왜인지 제대로 동작을안한다. (두번째부터)
사실 그걸 디버그하려고 프리뷰 윈도우에 대해서 찾아보기 시작한건데 잘 안되네.

삽질기는 To Be Continued...
