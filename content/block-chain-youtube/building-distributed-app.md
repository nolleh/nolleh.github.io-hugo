---
title: "Building Distributed App"
date: 2019-01-23T20:32:59+09:00
categories: ["block-chain-concept"]
tags: ["EOSIO", "block-chain"]
author: "nolleh"
---

> 다음에서 발췌 ()[]

# Smart Contract

- 블록은 트랜잭션을 포함한다.
- 트랜잭션은 액션의 기록이다.
- 액션은 컨트랙트의 동작이다.

스마트컨트랙트의 사용

- eos.io 의 컨트랙트는 abi 로 표현된다.
- 어플리케이션 코드는 json data 를 이용한 http 를 통해 contract 를 트리거 한다.
- EOS.IO 는 컨트랙트를 간단히 스크립팅하거나 테스팅하기위한 커맨드라인 인터페이스를 제공한다.

# Intro Smart Contracts

- EOS.IO 스마트 컨트랙트는 WebAssembly 로 구동된다. (WASM)

  - web 표준으로 떠오르는중
  - c/c++ 로부터 clang/llvm 을 통해 생성된다.
  - 다른 언어들도 언젠가 지원될 것

- Transaction - 실행되는 하나이상의 액션의 집합.
  - 하나의 액션이라도 실패하면 모든 트랜잭션이 실패한다
- Action - 스마트컨트랙트를 실행하는 고수준의 함수
  - 데이터를 컨트랙트에 전송하기 위해서는 payload 를 포함해야한다.

cloes 는 http 를 호출하는 syntatic sugar~

transaction json 을 살펴보면.
signature 가 있고, 이 특정한 트랜잭션의 시그니쳐를 표현한다.

action json 은 이런 형태

`actions : [{ "account": "eosio", "name": "newaccount","actor": "eosio", "permission": "acitve" }], "Data": "000000000ea30550 .. 000a8ed32320100" }]`

> - account : 액션을 실행하는 계정의 이름 (스마트 컨트랙트가 올라가있는 계정. 어떻게 action 을 실행할지에 대해 알고있다.)
> - name : "authroization": [{ // 어떤 시그니쳐가 필요한지 나타낸다.
> - data : hex 로 표현된 값

table 을 업데이트할때, payer 에 대해 0 를 전달하면 이전 payer 를 그대로 사용한다.

unittest - test_api -> tests directories . - api_tests.cpp

```cpp
#include <boost/test/unit_test.hpp>
#inclue <eosio.token/eosio.token.wast.hpp>
abi.hpp>

BOOST_AUTO_TEST_SUITE(dice_tests)
BOOST_FIXTURE_TEST_CASE(dice_test, dice_tester) try {
create_accounts( {N(eosio.token), N(dice), N(alice), N(bob), false});
set_code(N(eosio.token), eosio_token_wast);
set_abi(N(eosio.token), eosio_token_abi);
push_action(N(eosio.token), N(create), N(eosio.toekn), mvo() ("issuer", "eosio.token"))
}

```

load balcancing 을 담당하는 릴레이노드 /
producer node 가 별개로 있다

특정노드에 컨트랙트를 전송 ?
host 지정 하면 된다.

context free action 를 어디서배우면 되나~ //

transaction 을 트랙킹하기위해 플러그인을 사용해도 된다.
mongodb plugin 등.
