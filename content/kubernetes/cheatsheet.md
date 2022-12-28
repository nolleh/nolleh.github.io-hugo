---
title: "Cheatsheet"
date: 2022-08-05T16:22:31+09:00
draft: true
categories: ["kubernetes"]
tags: ["cheatsheet", "k8s", "devops", "kubernetes"]
---

## CronJobs

수동 실행

```
kubectl create job -n {namespace} --from=cronjob/{name} {job-name}
```

