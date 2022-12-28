---
title: 'Clustering Guide'
date: 2020-02-05T18:44:37+09:00
categories: ['RabbitMQ']
tags: ['MQ', 'RabbitMQ']
author: 'nolleh'
---

한개 이상의 노드들의 논리적인 그룹을 의미하며, 각각은 유저와, 가상 호스트, 큐, exchanges, bindings 을 공유한다.

## Cluster Formation

다음 방법들로 구성 가능

- Declaratively by listing cluster nodes in config file
- Declaratively using DNS-based discovery
- Declaratively using AWS (EC2) instance discovery (via a plugin)
- Declaratively using Kubernetes discovery (via a plugin)
- Declaratively using Consul-based discovery (via a plugin)
- Declaratively using etcd-based discovery (via a plugin)
- Manually with rabbitmqctl

구성은 동적으로 변경 될수 있고, 모든 RabbitMQ 브로커는 하나의 노드로부터 시작해서 클러스터에 참여시키거나, 다시 개별의 브로커로 돌아갈 수 있다.

## Node Names (Identifiers)

클러스터 내에서 서로 구분할 수 있는 고유 값이어야함.  
환경 변수로 지정. `RABBITMQ_NODENAME`

fully qulified domain names (FQDNs)를 사용하는 경우 `RABBITMQ_USE_LONGNAME` true 로 지정

## Nodes in a Cluster

정상적으로 동작하기위해 모든 노드에 걸쳐 데이터와 상태가 복제 되어야 한다. 하나의 예외는 메시지 큐인데, 기본적으로 하나의 노드에서만 존재하지만 다른 노드들 사이에서 visible 하고 reachable 하다. 이마저도 복제하고 싶다면 HA 를 참고하라.

### Nodes are Equal Peers

어떤 분산시스템들은 leader 와 follower 가 있지만 rabbitMQ 에서는 일반적으로 그렇지 않다.
모든 노드는 동등하다. 다만, 이주제는 queue mirroring 과 연관이 되면 미묘해진다.

## HOW CLI Tools Authenticate to Nodes (And Nodes to Each Other): the Erlang Cookie

erlang cookie 라고 부르는 대칭키를 함께 보유하고 있어야한다.  
로컬키에 저장해둠.  
소유자에게 접근권한이 있어야함. (600 이나 유사 권한)  
파일이 없으면 생성하나, 이 방식은 모든 노드가 각자의 데이터를 생성하니, 개발단계에서 사용할 것.

쿠키 생성은 클러스터 배포단계에서 완료되어야하며, 자동화와 오케스트레이션 툴을 이용하는 것을 추천한다.

## Node Counts and Quorum

consensus 를 요구하는 플러그인들이 있으므로, 홀수개의 노드 추천.

## Clustrering and Clients

모든 멤버가 정상적으로 동작할때 클라이언트는 어느노드나 붙어서 작업을 수행할 수 있다. 노드들은 연산을 큐 마스터 노드 (HA) 로 투명히 전달, 클라이언트로 돌려준다.

실패한 경우 클라이언트는 다른 노드에 재연결하여 토폴로지를 복구하고, 다시 연산을 재개해야 한다.
이가 여의치 않은 경우 '미러링 되지 않은 큐가 실패한 노드에 있을 경우' 참고.

## Clustering and Observability

클라이언트 연결과 채널, 큐들은 클러스터 노드들에 나뉘어져 있다.  
운영자들은 모든 클러스터 노드에 걸쳐 이를 관찰하고 모니터 할 필요가 있다.

`rabbitmq-diagnostics` 와 `rabbitmqctl` 과 같은 CLI 툴의 경우 클러스터 단위의 리소스를 관찰하는 명령어들을 제공한다.

어떤 커맨드들은 하나의 노드에 집중하기도 한다.0

(e.g. `rabbitmq-diagnostics environment` and `rabbitmq-diagnostics status`)

## Node Failure Handling

각 개별의 노드의 장애에 대해서는 tolerate 하다.  
노드는 다른 클러스터 멤버 노드에 연결을 할 수 있는한, 원하면 실행되거나 중지될 수 있다.

큐 미러링은 큐의 데이터가 복수의 클러스터 노드에 복제 될 수 있도록 한다.

미러링 되지 않은 큐들도 클러스터에 사용될 수 있는데, 이런 큐들의 경우 노드 장애시 큐 durability 속성에 의해 동작이 정해진다.  
rabbitmq 클러스터링은 네트워크 파티션을 다루기 위한 (주로 일관성을 중시하는) 몇가지 모드가 있다.

## Disk and RAM Nodes

노드는 디스크 노드이거나 램 노드 일 수 있다. 램 노드들은 램에만 데이터베이스 테이블을 저장한다.  
여기에 메시지들은 포함하지 않는다.  
메시지는 색인, 큐 색인과 다른 노드 상태를 저장한다.

대부분 디스크 노드를 사용하는 것을 원할 것이다. 램 노드는 큐, exchange, bind 가 많을때 성능 개선을 원하는 경우에 사용할 것이다. 램노드를 사용한다고 해서 메시지 비율이 개선 되진 않는다.

램노드는 내부 데이터베이스테이블을 사용하기 때문에 peer 노드가 구동되는 경우 sync 해 줘야한다.
이는 하나의 디스크 노드는 필요하다는 것.
