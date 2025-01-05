---
title: "How to Make Package"
date: 2023-07-12T08:29:46+09:00
draft: true
---

패키지를 만들때 기본 구성

```json
{
  "main": "./dist/cjs/index.js",
  "types": "./dist/cjs/types/index.d.ts",
  "files": ["dist/**/*"],
  "scripts": {
    "clean": "rm -rf ./dist",
    "build": "pnpm run clean && pnpm build:esm && pnpm build:cjs",
    "build:esm": "tsc -p ./tsconfig.esm.json && mv dist/esm/index.js dist/esm/index.mjs",
    "build:cjs": "tsc -p ./tsconfig.cjs.json",
    "prepack": "pnpm build"
  },
  "repository": {
    "type": "git",
    "url": "https://github.com/nolleh/serialize-interceptor"
  },
  "keywords": [
    "nestjs",
    "nest.js",
    "serialize",
    "deserialize",
    "camel",
    "snake",
    "json",
    "dto",
    "transform"
  ],
  "exports": {
    ".": {
      "import": {
        "types": "./dist/esm/types/index.d.ts",
        "default": "./dist/esm/index.mjs"
      },
      "require": {
        "types": "./dist/cjs/types/index.d.ts",
        "default": "./dist/cjs/index.js"
      }
    }
  }
}
```

## main/types/files

```json
{
  "main": "./dist/cjs/index.js",
  "types": "./dist/cjs/types/index.d.ts",
  "files": ["dist/**/*"]
}
```

이 패키지의 entry point 는 무엇인지에 대한 정보인지가 main 에,
그 타입에 대한 정보가 types 에,
어떤 파일들이 패포 될 것인지에 대한 정보가 files 로 기입된다.
여기서 files 는, whitelist 로써 동작하며, 가장 높은 우선순위를 보유한 것으로 알고 있음.

## scripts

```json
{
  "build": "pnpm run clean && pnpm build:esm && pnpm build:cjs",
  "build:esm": "tsc -p ./tsconfig.esm.json && mv dist/esm/index.js dist/esm/index.mjs",
  "build:cjs": "tsc -p ./tsconfig.cjs.json"
}
```

esm 을 사용하는 모듈에서 사용될 빌드 파일과 cjs 을 사용하는 모듈 각각에 대해 별도 배포 파일을 생성하기 위해 빌드 설정을 분리한다.
build 명령어를 통해서는 양쪽 모두를 빌드한다.
ESModule 쪽에서는 mjs extension 을 사용하기 위해 mv 도 잊지 말것.

## repository / keywords

meta information.
npmjs.com 등에서 노출 될 때 사용되는 정보.

## exports

### exports 에 대한 기본 설명 - exports subpath

exports 없이는 사용처에서 추가적으로 dist 를 참조해야하는 상황이 발생할 수 있는데, (main 은 index.js 만 지정하기 때문에.)

ex. import { a } form 'serialize-interceptor/dist/a';

or

import { a } from 'serialize-interceptor/nested/a'

when directory structure is..

/nested
a.ts
index.ts

subpath 를 배포하기 위해서는 exports 에 추가로 작성하는 형태로 접근가능.

기본 구문:

```json

{
    exports: {
        ".": "./dist/index.js"
        "./nested": "./dist/nested/index.js"
      }
  }
```

### exports - conitional exports

여기서 모듈 시스템에 따른 conditional exports 확장
