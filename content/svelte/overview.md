---
title: "Overview"
date: 2022-10-11T23:34:14+09:00
categories: ["svelte"]
tags: ["FE"] 
draft: false
---

## 서론
react, vue, angluar 가 장악하던 FE 진영에서 떠오르고 있는 프레임워크.
주요 철학은 [svelte](svelte.dev) 의 메인 화면에서 보여주고 있는것처럼
'보다 짧은 코드', 'No Virtual DOM', 'Truely reactive' 인 듯하다.
지만 나는 어디까지나 BE 개발자이기 때문에 아직 어떤 의미인지 자세하게는 모르겠고(...)

스벨트 컬럼을 새로 생성하며 블로그에 정리를 결심한 것은 어디까지나 호기심이 충만한 나의 심심풀이 변덕이다. 
(더 정확히는, 팀 내 주니어 개발자와의 원활한 의사 소통을 위해..)
심심할 때 더 자세히 살펴보고 정리할 것. 
본문에서는, 단순히 스벨트 프로젝트를 만들고 실행해보는 정도로 정리하겠다. 

## 시작하기
사용하는 패키지 매니져의 create 명령어(starter kit 을 통해 정의된 프로젝트 생성)

```bash
➜  workspace_github pnpm create vite@latest svelte-test -- -- template svelte
Packages: +1
+
Packages are hard linked from the content-addressable store to the virtual store.
  Content-addressable store is at: /Users/nolleh/.pnpm-store/v3
  Virtual store is at:             node_modules/.pnpm

/private/var/folders/97/vks5483s2yn95dxdpdspjsgw0000gq/T/dlx-31846/5:
+ create-vite 3.1.0

Progress: resolved 1, reused 0, downloaded 1, added 1, done

   ╭──────────────────────────────────────────────────────────────────╮
   │                                                                  │
   │                Update available! 6.32.3 → 7.13.4.                │
   │   Changelog: https://github.com/pnpm/pnpm/releases/tag/v7.13.4   │
   │                 Run pnpm add -g pnpm to update.                  │
   │                                                                  │
   │      Follow @pnpmjs for updates: https://twitter.com/pnpmjs      │
   │                                                                  │
   ╰──────────────────────────────────────────────────────────────────╯

✔ Select a framework: › Svelte
✔ Select a variant: › TypeScript

Scaffolding project in /Users/nolleh/Documents/workspace_github/svelte-test...

Done. Now run:

  cd svelte-test
  pnpm install
  pnpm run dev
```

위 명령은 다음과 같은 폴더들을 생성한다.

```bash
➜  svelte-test l
total 128
drwxr-xr-x  15 nolleh  staff   480B Oct 11 23:30 .
drwxr-xr-x  22 nolleh  staff   704B Oct 11 23:29 ..
-rw-r--r--   1 nolleh  staff   253B Oct 11 23:29 .gitignore
drwxr-xr-x   3 nolleh  staff    96B Oct 11 23:29 .vscode
-rw-r--r--   1 nolleh  staff   3.1K Oct 11 23:29 README.md
-rw-r--r--   1 nolleh  staff   365B Oct 11 23:29 index.html
drwxr-xr-x  15 nolleh  staff   480B Oct 11 23:30 node_modules
-rw-r--r--   1 nolleh  staff   511B Oct 11 23:29 package.json
-rw-r--r--   1 nolleh  staff    28K Oct 11 23:29 pnpm-lock.yaml
drwxr-xr-x   3 nolleh  staff    96B Oct 11 23:29 public
drwxr-xr-x   8 nolleh  staff   256B Oct 11 23:29 src
-rw-r--r--   1 nolleh  staff   207B Oct 11 23:29 svelte.config.js
-rw-r--r--   1 nolleh  staff   658B Oct 11 23:29 tsconfig.json
-rw-r--r--   1 nolleh  staff   142B Oct 11 23:29 tsconfig.node.json
-rw-r--r--   1 nolleh  staff   176B Oct 11 23:29 vite.config.ts
➜  svelte-test
```

으음 .vscode 폴더도 생성하네, 친절하다. (난 vscode 로 실행할 생각이 없지만)
제일 중요할 package.json 의 내용은 다음과 같음.

```json
{
  "name": "svelte-test",
  "private": true,
  "version": "0.0.0",
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "preview": "vite preview",
    "check": "svelte-check --tsconfig ./tsconfig.json"
  },
  "devDependencies": {
    "@sveltejs/vite-plugin-svelte": "^1.0.2",
    "@tsconfig/svelte": "^3.0.0",
    "svelte": "^3.49.0",
    "svelte-check": "^2.8.1",
    "svelte-preprocess": "^4.10.7",
    "tslib": "^2.4.0",
    "typescript": "^4.6.4",
    "vite": "^3.1.0"
  }
}
```

vite 라는 패키지를 이용해서 빌드하고 실행하도록 구성되어 있고, check 를 통해 lint 체크등이 일어나는 모양.
svelte package 등도 프로젝트 별로 버전을 관리하는 형태로 구성되었다. 모든 dependency 는 devDependency 에 정의되어있으므로, 
모든 패키지는 런타임엔 하는 역할이 없다고 봐도 무방.

생성된 app.svelte 는 대충 이런모양

```svelte
<script lang="ts">
  import svelteLogo from './assets/svelte.svg'
  import Counter from './lib/Counter.svelte'
</script>

<main>
  <div>
    <a href="https://vitejs.dev" target="_blank"> 
      <img src="/vite.svg" class="logo" alt="Vite Logo" />
    </a>
<main>

<style>
  .logo {
    height: 6em;
    padding: 1.5em;
    will-change: filter;
  }
  .logo:hover {
    filter: drop-shadow(0 0 2em #646cffaa);
  }
  .logo.svelte:hover {
    filter: drop-shadow(0 0 2em #ff3e00aa);
  }
  .read-the-docs {
    color: #888;
  }
</style>
```

즉 다음과 같은 골격을 가지고 있다.

> 1. ``<script>``
> 2. ``<main>``
> 3. ``<style>``

이는 vue 에서도 유사한 형태를 가지고 있던것 같다. (@nolleh 의 기억에 의존) 따라서 크게 의아한 점은 없는듯.
해당 app.svelte 를 렌더링하는 부분은 main.ts 인데, 다음과 같이 구성되어 있다.

```typescript
import './app.css'
import App from './App.svelte'

const app = new App({
  target: document.getElementById('app')
})

export default app
```

역시 vue.js 와 유사한 골격이다. 
상대경로에서 필요한 파일들을 가져와서 .svelte 파일에서 생성되는 App 클래스로 인스턴스를 생성하고 export 한다.
(이건 좀 신기하다. extends 구문도 없고, 클래스를 정의하는 부분도 없는데 App 이라는 클래스명으로 지정이 된다.  
뭐 어차피 컴파일러도 별도 정의한 것이고, 각 IDE 에서의 에러 여부 판단도 약속만 되어있으면 상관없을 테지만.) 

실행해보면
```bash
  VITE v3.1.7  ready in 153 ms

  ➜  Local:   http://127.0.0.1:5173/
  ➜  Network: use --host to expose
``` 
와 같이 어떤 url 로 접근하면 해당 페이지를 노출할 것인지 보여준다.
vite 라는 녀석이 serving 을 해주는 것 같은데, 뭐하는 놈인지 좀 검색해봄.

1. javascript 의 태생, 모듈의 니즈 
2. AMD
3. 번들러(webpack)의 등장
4. esbuild (구현: javascript -> go) 100 배 빠른 빌드
   - 역시 고는 짱짱맨!
6. webpack 이 지원하던 다른 많은 기능들이 4에서는 부재하므로 잘 사용되지 않음
   - devServer, Loader 를 통한 transfile, HTML, CSS 지원등.. 단순 빌드 도구가 아니라 개발의 통합 툴이었음
8. snowpack 의 등장
   - esbuild 를 통한 빌드, 실제 번들은 Webpack
9. vite 의 등장
   - esbuild 와 브라우저 모듈을 이용한 개발모드,개발서버, 프록시서버, 번들툴, 코드 스프리팅, HMR 등 스노우팩의 컨셉 + 다른 번들도구의 기능을 하나로 모은 도구
10. Svelte 의 vite 의 차용
   - '2021 년 가장 만족도가 높은 번들툴' 로 선정된 vite 의 차용.
   - Dev server + HMR + typescirpt + dev proxy 를 지원하게 되었다.

즉, svelte 에서 사용하는 번들 툴이 되겠다.

해당 url 로 들어가면 다음과 같은 페이지가 노출 된다. 


