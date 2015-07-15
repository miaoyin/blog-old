---
layout: post
title: "如何得到yum的rpm包"
date: "2015-07-15 17:38"
category: "linux"
tags: "yum"
---

* 安装yum-utils

```
yum -y install yum-utils
```

* 下载rpm

```
yumdownloader proxychains
```
得到proxychains-3.1-16.fc22.i686.rpm 、proxychains-3.1-16.fc22.x86_64.rpm两个文件

* 下载源码

```
yumdownloader --source proxychains
```
得到文件proxychains-3.1-16.fc22.src.rpm
