---
layout: post
title: "Building the main Guest Additions module [失败]"
date: "2013-12-27 19:03"
category: "virtualbox"
---

在安装virtualbox的增强功能时出现错误

```bash
Building the main Guest Additions module [失败]
```

查看日志找到原因，缺少依赖

```
Uninstalling modules from DKMS
Attempting to install using DKMS
 
Creating symlink /var/lib/dkms/vboxguest/4.3.6/source ->
                 /usr/src/vboxguest-4.3.6
 
DKMS: add completed.
Error! echo
Your kernel headers for kernel 3.12.5-302.fc20.x86_64 cannot be found at
/lib/modules/3.12.5-302.fc20.x86_64/build or /lib/modules/3.12.5-302.fc20.x86_64/source.
Failed to install using DKMS, attempting to install without
/tmp/vbox.0/Makefile.include.header:97: *** Error: unable to find the sources of your current Linux kernel. Specify KERN_DIR=<directory> and run Make again。 停止。
Creating user for the Guest Additions.
Creating udev rule for the Guest Additions kernel module.
```

安装缺少的模块

```bash
sudo yum install dkms kernel-devel
```
应该是在编译一些东西，可能需要先安装gcc

验证是否成功

```
sudo /etc/init.d/vboxadd setup
```

