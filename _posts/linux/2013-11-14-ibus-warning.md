---
layout: post
title: "IBUS-WARNING **: Process Key Event failed: Timeout was reached"
date: "2013-11-14 07:10"
category: "linux"
tags: ["ibus"]
---

在gvim中ibus敲字时，偶尔会在n秒之后才显示到屏幕，反应死慢。控制台会看到下面的错误信息.
{% highlight bash %}
(gvim:77687): IBUS-WARNING **: Process Key Event failed: Timeout was reached。
{% endhighlight %}

暂时无法搞清具体原因，所以用重启ibus的笨办法解决。

* 杀死ibus进程
{% highlight bash %}
ps -ef |grep ibus-daemon
{% endhighlight %}
找到进程，然后kill掉

* 启动 ibus
{% highlight bash %}
ibus-daemon -d -x -r
{% endhighlight %}
-d 作为后台程序运行

-x 执行ibus XIM服务

-r 替换老进程
