---
layout: post
title: "查看windows磁盘剩余空间"
date: "2017-03-22 22:00"
category: ["storage"]
tags: ["windows", "powershell"]
---

在powershell中运行Get-Volume

```
PS C:\Users\Administrator> Get-Volume

DriveLetter FileSystemLabel FileSystem DriveType HealthStatus OperationalStatus SizeRemaining      Size
----------- --------------- ---------- --------- ------------ ----------------- -------------      ----
G                           NTFS       Fixed     Healthy      OK                    320.86 GB 372.61 GB
            系统保留        NTFS       Fixed     Healthy      OK                    301.87 MB    350 MB
C                           NTFS       Fixed     Healthy      OK                    881.36 GB 931.17 GB
                            NTFS       Fixed     Healthy      OK                    931.31 GB 931.51 GB
```
