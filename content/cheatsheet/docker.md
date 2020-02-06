---
title: 'Docker'
date: 2020-02-06T10:53:37+09:00
Categories: ['Cheatsheet']
Tags: ['Docker', 'Cheatsheet']
Author: 'nolleh'
---

## Docker Cheat Sheet

### 1. docker conntianer 내부 소켓 상태 확인

[](https://aidanbae.github.io/code/docker/docker-netstat/)

```bash
$ docker inspect -f '{{.State.Pid}}' cb2939r52s22
5645
```

```bash
[ec2-user@ip-10-100-77-76 ~]$ sudo nsenter -t 5645 -n netstat
Active Internet connections (w/o servers)
Proto Recv-Q Send-Q Local Address               Foreign Address             State
tcp        0      0 ip-172-17-0-2.ec2.:webcache ip-10-100-77-225.ec2.:45104 ESTABLISHED
tcp        0      0 ip-172-17-0-2.ec2.:webcache ip-10-100-77-225.ec2.:14804 TIME_WAIT
tcp        0      0 ip-172-17-0-2.ec2.:webcache ip-10-100-76-6:seclayer-tls TIME_WAIT
tcp        0      0 ip-172-17-0-2.ec2.:webcache ip-10-100-76-65.ec:plethora TIME_WAIT
tcp        0      0 ip-172-17-0-2.ec2.:webcache ip-10-100-77-225.ec2.:14830 TIME_WAIT
tcp        0      0 ip-172-17-0-2.ec2.:webcache ip-10-100-76-65.ec2.i:23284 ESTABLISHED
tcp        0      0 ip-172-17-0-2.ec2.:webcache ip-10-100-76-65.ec2.i:27948 ESTABLISHED
tcp        0      0 ip-172-17-0-2.ec2.:webcache ip-10-100-77-225.ec2.:14848 TIME_WAIT
tcp        0      0 ip-172-17-0-2.ec2.:webcache ip-10-100-77-225.ec2.:45544 ESTABLISHED
Active UNIX domain sockets (w/o servers)
Proto RefCnt Flags       Type       State         I-Node Path
```

docker container 의 ulimit 가 호스트를 따라가지 않을 수 있음.

빠르게 open 하고 close 시, 사용하는 ORM 솔루션에 따라 기대하는 동작과 다를 수 있음.

small idle connection.. -> cause high reconnect rate.
