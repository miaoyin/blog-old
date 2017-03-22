---
layout: post
title: "subprocess.Popen的参数close_fds=True与stdin/stdout/stderr不能共存"
date: "2017-03-17 18:31"
category: ["python", "windows"]
tag: "subprocess"
---


- 运行命令

```
subprocess.Popen(cmd, close_fds=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
```

- 出现错误

```
ValueError: close_fds is not supported on Windows platforms if you redirect stdin/stdout/stderr
```

- 原因

```
在windows上subprocess.Popen的参数close_fds=True与stdin/stdout/stderr不能共存
```

* close_fds=True表示子进程将不会继承父进程的输入、输出、错误管道。
* windows上不能将close_fds设置为True同时重定向子进程的标准输入、输出与错误(stdin, stdout, stderr)
