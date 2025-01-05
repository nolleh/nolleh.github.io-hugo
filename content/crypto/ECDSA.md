---
title: "ECDSA"
date: 2020-01-30T18:28:50+09:00
Categories: ["암호학"]
Tags: ["암호학", "CRYPTO"]
Author: "nolleh"
---

# ECDSA

ref. https://m.blog.naver.com/aepkoreanet/221178375642

ec (타원곡선) 을 이용한 기술들의 집합 - ECC,  
이중에 디지털서명 관련 기술이 ECDSA

## Terms

> - 유한체  
>   집합에 속해있는 원소의 수가 한정되어 있고 덧셈, 곱셈에 대해 닫혀있는 집합
>   - 유한체 F 표기법  
>     원소의 개수가 p 인 유한체 F 는 `Fp` 혹은 `GF(p)` 로 표기
>   - 유한체 상에 정의된 타원 곡선  
>     `E(Fp)`
>   - 암호학에서 사용되는 유한체

        - Prime Field
        원소의 개수가 소수

ECC 사용시 타원 곡선을 정의하는 domain parameter 를 정의해야함.
(p, a, b, G, n, h) 를 정의해야하는건데, 여러 표준단체에서 Field Size 에 맞는 타원곡선에 대한 파라미터 발표.

- p : Modulo Prime Number
- a : 타원곡선 방정식에서 사용되는 계수
- b : 타원곡선 방정식에서 사용되는 계수
- Base point 또는 Generator Point, G 는 `E(Fp)` 에 속해있는 point
- n : the order of point G (G 를 n번 더하면 무한원점이 되는값 : nG = ∞)
- H : cofactor

타원 곡선이란, 타원 곡선 방정식을 만족하는 집합을 곡선 그래프로 표시한 것

y^2 = x^3 + ax + b

secp256k1 곡선의 경우 a = 0, b = 7 을 사용

![](https://mblogthumb-phinf.pstatic.net/MjAxODAxMDVfMjA3/MDAxNTE1MTIwNzU2Mzg4.-O3OYGeOa7qhb3XL4zNeyVTUu-QztZOTNCB5usfDlzsg.WQ_YS2FHvXxbrzIKQ0FBFvJBdf90Zj7x5JuNwEVKWH8g.JPEG.aepkoreanet/secpcurve.jpg?type=w2)

## ECC 의 privateKey 와 publicKey

> - Private Key d : P 보다 적은 소수 (Prime) 로, 난수 생성기로 생성
> - Public Key Q : Q(x, y) = d x G(x0, y0)

## ECDSA 와 secp256k1

ECDSA 의 파라메터로 secp256k1 curve 를 사용
secp256k1

sec - standard for Efficient Cryptography  
p - parameter p over Fp  
256 - field size p 의 bit 수  
k - koblitz curve 변형  
1 - sequence number

### Domain Parameter

```
T = (p,a,b,G,n,h)

p :  FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFC2F

a :  00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000

b :  00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000007

G :  02 79BE667E F9DCBBAC 55A06295 CE870B07 029BFCDB 2DCE28D9 59F2815B 16F81798

  또는

G : 04 79BE667E F9DCBBAC 55A06295 CE870B07 029BFCDB 2DCE28D9 59F2815B 16F81798 483ADA77 26A3C465 5DA4FBFC 0E1108A8 FD17B448 A6855419 9C47D08F FB10D4B8

N :  FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFE BAAEDCE6 AF48A03B BFD25E8C D0364141

h : 01
```

## 서명은 어떻게 이루어지는가 ?

https://ko.wikipedia.org/wiki/%ED%83%80%EC%9B%90%EA%B3%A1%EC%84%A0_DSA

domain parameter 로 (CURVE, g, n) 을 사용한다.

- Curve : 타원곡선의 체 (field) 와 여기 사용된 수식.
- g : 타원 곡선의 기준점 (base point). 해당 타원곡선의 생성원(generator) 이다.
- n : g 의 차수이다. n X g = 0 이며, 반드시 소수여야한다. 보통 충분히 큰 소수를 사용한다.

privateKey, d 생성. - RNG 로 생성된 무작위로 선택된 1~ n-1 사이의 정수  
publicKey, Q 생성 - Q = dg 를 만족하는 정수. (g 를 d 번 더한 값)

서명 프로세스

필요한 것: `E(Fp)`, d, Q, m

```
1. e = H(m). 메시지를 해쉬하고 이를 e 라고 한다.
2. z = Ln(e) e 의 binary 값에서 왼쪽으로부터 n 번째 까지 잘라낸 값을 z 라고 한다. (left most n'th bit)
3. 암호학적으로 안전한 난수 k 를 [1, n-1] 사이에서 무작위로 선택한다.
4. 곡선 위의 점 (x1, y1) = k * g 를 계산한다.
    - 타원곡선에서의 덧셈은, 결국 다시 점이 된다.
    - 위 k * g 는 g 를 k 번 더하는 것을 의미하고, 결국 점이 된다.
5. r = x1 (mod n) 을 계산 한다. r 이 0 인 경우, k 를 다시 선택한다.
6. s = k^(-1)(z + rd) (mod n) 을 계산. s = 0 이면 3 으로 되돌아가 다른 k 를 선택, 순서대로 진행한다.

완성된 서명은 (r, s) 이다.
```

![](https://wikimedia.org/api/rest_v1/media/math/render/svg/d2ae87d5c9d298c4339595d4308963c17257e228)

검증 프로세스

필요한 것: `E(Fp)`, (r,s), m

```
- 곡선위의 점 인증
1. Q =/= O (identity element)
2. Q 가 곡선 위의 점인지
3. n x Q = O 인지 확인

- 서명 유효성 인증
1. r,s 가 1부터 n-1 사이의 정수인지 확인.
2. e = H(m) 을 계산.
3. z 계산
4. w = s^(-1)(mod n) 계산, u1 = zw, u2 = rw (mod n) 계산
5. shamir's trick 을 사용해서 (x1, y1) = u1 x g + u2 x Q 를 계산. (x1, y1) = O 이면 무효
6. r = x1 (mod n) 일때만 유효.
```

즉, 서명 프로세스는 타원 곡선에서 새로운 k 와 (x1, y1) 을 구한 후

## ECDSA 시그니쳐에서 어떻게 public key 를 복원할 수 있는가 ?

[stack exchange link](https://crypto.stackexchange.com/questions/18105/how-does-recovering-the-public-key-from-an-ecdsa-signature-work)

ECDSA signature (r,s)

사실 곡선과 사용된 해쉬 함수, 서명된 메시지 원본을 알고 있더라도
signature 로부터 public key 를 recover 하는 것은 불가능하다.

그러나, signature 와 원본 메시지, 곡선에 대한 정보로 두개의 public key 를 생성하는게 가능하다.
(이 중에 private key 가 사용된 public key 가 있을 것)

동작 원리는 다음과 같다.

- R 과 R' x 좌표로 r 값을 갖는 좌표를 찾는다.
- r^-1 을 연산하는데, 이는 시그니쳐의 r 의 곱셈 역원이다. (mod n)
- z 메시지 해쉬의 하위 n bit 인 z 를 연산한다.

public key 는 `r^(−1)(sR−zG) and r^(−1)(sR′−zG)` 가 된다.
