---
title: 'Network'
date: 2020-02-06T11:56:11+09:00
Categories: ['Cheatsheet']
Tags: ['Cheatsheet', 'network']
Author: 'nolleh'
---

- time_wait 종료 시간 확인 : ndd -get /dev/tcp tcp_time_wait_interval
- time_wait 종료 시간 30초로 설정 : ndd -set /dev/tcp tcp_time_wait_interval 30000
- fin_wait_2 타임 아웃 시간 확인 : ndd -get /dev/tcp tcp_fin_wait_2_timeout
- fin_wait_2 타임 아웃 시간 5분으로 설정 : ndd -set /dev/tcp tcp_fin_wait_2_timeout 300000

출처: https://hyeonstorage.tistory.com/287 [개발이 하고 싶어요]
