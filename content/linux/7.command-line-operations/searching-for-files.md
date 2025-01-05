---
title: "Searching For Files"
date: 2023-10-02T19:56:54+09:00
draft: false
categories: ["edx-linux"]
tags: ["edx", "Linux", "Kernel"]
---

A special shorthand notation can send anything written to file descriptor 2 (stderr) to the same place as file descriptor 1 (stdout): 2>&1.

$ do_something > all-output-file 2>&1

bash permits an easier syntax for the above:

$ do_something >& all-output-file

## in pipe...

$ command1 | command2 | command3

The above represents what we often call a pipeline, and allows Linux to combine the actions of several commands into one. This is extraordinarily efficient because command2 and command3 do not have to wait for the previous pipeline commands to complete before they can begin processing at the data in their input streams

## find ..

$ find -name "\*.swp" -exec rm {} ’;’

{} is placeholder the file name will fill
