---
title: "Some Additional Useful Techniques"
date: 2024-01-04T21:38:12+09:00
draft: false
---

$RANDOM: environment variable for 

- performing security-related tasks
- Reinitializing storage devices
- Erasing and/or obscuring existing data
- Generating meaningless data to be used for tests

## How the Kernel Generates Random Numbers

Some servers have hardware random number generators that take as input different types of noise signals,
such as thermal noise and photoelectric effect. A transducer converts this noise into an electric signal, which is again converted into a digital number by an A-D converter.

```mermaid
flowchart LR
noise["noise signal(thermal noise, photoelectric effect)"]-->|transducer|electric[electric signal]-->|A-D converter|digit[digital number]
```

However,most common computers do not contain such specialized hardware and,  
instead, rely on events created during booting to create the raw data needed.

Regardless of which of these tow sources is used, the system maintains a so-called `entropy pool` of these diginal numbers/randoms bits.  
random numbers created from this entropy pool

Linux kernel offers...
- /dev/random
- /dev/urandom

which draw on the entropy pool to provide random numbers which are drawn from the estimated number of bits of noise in the entropy pool.   

/dev/urandom is faster compared with /dev/random which is used where very high-quality randomness is required (such as a one-time pad or key generation)


/dev/random is blocked and does not generate any number until additional environmental noise is gathered when the entropy pool is empty, whereas /dev/urandom reuses the internal pool to produce more pseudo-random bits


