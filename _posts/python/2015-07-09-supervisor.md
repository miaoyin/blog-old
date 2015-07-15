---
layout: post
title: "supervisor用法"
date: "2015-07-09 17:03"
category: "python"
tag: "supervisor"
---

以什么方式运行进程？将它做成服务，再以"service xxx start/stop"方式运行。
或者以"nohup xxx &"方式运行，需要停止时，先ps获得进程id，然后kill掉.
有什么好点的办法？supervisor正好解决这个问题。

* 安装

```
sudo pip install supervisor
```

* 创建配置文件

```
echo_supervisord_conf > /etc/supervisord.conf
```

* 取消注释

打开/etc/supervisord.conf，取消下面两行注释，并修改files内容.

```
[include]
files = /etc/supervisor/*.ini
```

* 新建配置目录

新建supervisor目录及test.ini文件

```
➜  /etc  tree supervisor
supervisor
└── test.ini
```

* 配置内容

test.init内容

```
[program:test]
command=python -m SimpleHTTPServer 8000
directory=/home/wyq/
```

* 运行

运行后，在浏览器访问8000端口

```
supervisord 
```

调试运行，此时需要先将test.ini中directory注释掉.

```
supervisord -d
```

supervisor也可指定配置文件

```
supervisord -c xxxx
```

* 查看日志

```
tail -f supervisord.conf
```

* 查看运行状态

```
➜  ~  supervisorctl status
test                             RUNNING   pid 4922, uptime 0:00:07
```

* 停止任务

启动与重启参数为start/restart

```
➜  ~  supervisorctl stop test
test: stopped
➜  ~  supervisorctl status   
test                             STOPPED   Jul 09 04:32 PM
```

* 停止

```
supervisorctl shutdown
```

