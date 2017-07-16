---
title: "파일 버퍼링"
date: 2017-07-17T00:25:28+09:00
Categories: ["운영체제"]
Tags: ["Kernel", "OS", "Programming"]
Author: "nolleh"
---

> 다음에서 발췌, 번역  
> - https://msdn.microsoft.com/en-gb/library/windows/desktop/cc644950(v=vs.85).aspx
  

# File Buffering

파일버퍼링 - unbuffered file I/O.  
본문에선 시스템에 의해 캐싱되지 않는 (buffered) 데이터를  
어떻게 유저 모드의 응용프로그램에서 데이터를 활용할 수 (interact) 있을지에 대해 다룬다.  

FILE_FLAG_NO_BUFFERING 플래그를 통해 CreateFile 을 Open 하면,  
파일을 읽거나 쓸때 시스템의 캐싱을 비활성화 하도록 제어할 수 있다.  
I/O 버퍼링을 사용한것과 같은 효과를 내려면, 데이터 alignment 가 반드시 고려되어야 한다. 

    Note 파일에 대해 Seeking 과 위치포인터,  
    offsets 의 개념을 사용하는 파일에 대해 alignment 정보가 고려될 필요가 있다. 

물리 디스크와 파일 시스템 저장소의 계층에서 write 연산은 alignment 기준을 맞추지 못한다면 실패 할 것이다. 

# Alignment and File Access Requirement
다음을 만족시켜야한다. 

- 파일 접근 사이즈. OVERLAPPED 구조체의 offset 을 포함해서,  
지정된다면 volume 의 섹터사이즈의 정수배로 지정되어야한다. 
- 읽기/쓰기 연산의 버퍼주소는 물리적 섹터에 aligned 되어있어야 한다.  
즉, 물리 섹터 사이즈의 정수배로 메모리가 주소에 정렬되어 있어야함을 의미한다.  
디스크에 따라 강제사항이 아닐 수도 있다.

4096 byte 의 미디어 섹터사이즈가 시장에 나온 것을 고려해야하는데,  
일시적인 방안으로, ATA / SCSI 명령어를 통해 일반적인 512 바이트의 섹터 저장소가  
에뮬레이트 되도록 할 수 있다.

이 에뮬레이트를 사용할때, 다음 두 가지를 알아야한다.  

- 논리섹터: 미디어에 접근할때 사용되는 논리 블럭의 단위. 이 부분이 바로 "emulation"  
- 물리섹터: 읽기/쓰기가 하나의 연산으로 이뤄지는 단위. 최적의 성능과 신뢰성을 위해 unbuffered I/O 가 aligned 되어야하는 단위이기도 하다.  

IOCTL_DISK_GET_DRIVE_GEOMETRY 와 GetDiskFreeSpace 를 통해 논리 섹터사이즈를 알 수 있으며,  
IOCTL_STORAGE_QUERY_PROPERTY 제어코드와  
STORAGE_ACCESS_ALIGNMENT_DESCRIPTOR 구조체의  
BytesPerPhysicalSector 멤버의 사용을 통해 물리 섹터 사이즈를 구할 수 있다. 

    Windows Server 2003 과 XP 에서는  
    STORAGE_ACCESS_ALIGNMENT_DESCRIPTOR 가 지원되지 않는다.

섹터 align 버퍼를 얻기 위해 VirtualAlloc 함수를 사용할 수 있다.

- VertualAlloc 은 메모리를 시스템페이지의 정수배의 사이즈로 align 되도록 메모리를 할당한다.  
x64 나 x86 에서는 4,096 바이트이며, Itanium-기반 시스템에서는 8,192 이다.  
더 자세한 정보는 GetSystemInfo 함수를 통해 얻을 수 있다.
- 직접 접근하는 저장소의 일반적인 섹터사이즈는 512 ~ 4,096 byte 이며, CD-ROM 에서는 2,048 바이트.
- 페이지/섹터사이즈 모두 2의 거듭제곱. 

섹터사이즈가 페이지사이즈보다 큰 경우는 적기 때문에,  
대부분의 경우 page 에 align 된 메모리는 sector 에 대해서도 align 되어있다.

수동으로 align 된 메모리버퍼를 얻는 또하나의 방법은 _aligned_malloc 함수를 사용하는 것이다.  
수동으로 align 된 버퍼를 사용하는 방법은 WriteFile 절의 예제코드를 살펴보라. 