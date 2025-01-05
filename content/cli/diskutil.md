---
title: "Diskutil"
date: 2023-08-05T16:14:33+09:00
draft: true
---

mac 에서는, diskutil 과 dd 를 사용해서 microSD 카드를(disk) 포멧 할 수 있다.

disk utility 라는 GUI 툴도 있는데, 파티셔닝 되어있던 애를 이걸 통해서 지웠더니 뭔갈 잘못한건지
절반정도의 디스크용량이 날아가 버렸다 ㅡㅡ;;;

32GB 짜리 SD 카드가 반토막 난 격이라;;
dd 와 fdisk 를 활용해서 뭔가 다시 복구하려는 삽질기가 되시겠다...

```bash
$ diskutil list
```

output

```bash
/dev/disk5 (external, physical):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:                                                   *15.9 GB    disk5
```

format 하려면

```bash
$ diskutil umount
$ sudo dd if=/dev/zero of=/dev/{dev-name} bs=1M status=progress ## this is really long term work
```

되-게 오래 걸리는 작업이라서, 잊지 말고status=progress 옵션을 사용하는 것을 권장 한다.
(status 를 안켜고 몇 번 돌리다가 인내하지 못하고 Ctrl + c 를 두 번이나 누르게 되었다... )

partition

```bash
$ sudo fdisk /dev/sdc

$
```
