---
layout: post
title: "在用proxychains时, ping用不了怎么办"
date: "2014-01-16 10:49"
category: "linux"
tags: ["proxychains"]
---

一般用ping来测试网络是否连通. 在用proxychains代理时，发现ping用不了
{% highlight python linenos %}
[wyq@localhost ~]$ proxychains ping 135.32.9.98
ProxyChains-3.1 (http://proxychains.sf.net)
ERROR: ld.so: object 'libproxychains.so.3' from LD_PRELOAD cannot be preloaded: ignored.
PING 135.32.9.98 (135.32.9.98) 56(84) bytes of data.
{% endhighlight %}
proxychains支持的是socks，http, https协议.它们以tcp或者udp协议为基础. 所以proxychains只支持使用tcp或udp协议的程序. ping用的是ICMP协议，不以tcp或udp为基础，所以用不了。
 
有其它办法吗？
以tcp或udp为基础，测试网络是否可用的工具，比较好用的有wget

{% highlight python linenos %}
[wyq@localhost ~]$ proxychains wget 135.32.9.98
ProxyChains-3.1 (http://proxychains.sf.net)
--2014-01-16 09:44:57--  http://135.32.9.98/
正在连接 135.32.9.98:80... |S-chain|-<>-192.168.1.115:1080-<><>-135.32.9.98:80-<--denied
失败：拒绝连接。
{% endhighlight %}
虽然提示拒绝连接，但是输出信息，已能说明网络连通了.
 
wget本身简单易用，在这种情况下，用来测试网络是否可用，还是比较适合的。

