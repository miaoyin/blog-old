---
layout: post
title: "chkconfig简介"
date: "2015-02-24 21:38"
category: "linux"
--- 

chkconfig是一种简单的命令行工具，用于帮助管理员对/etc/rc[0-6].d目录层次下的众多的符号链接进行直接操作。

### 语法
{% highlight text %}
chkconfig --list [name]
chkconfig --add name
chkconfig --del name
chkconfig [--level levels] name <on|off|reset>
chkconfig [--level levels] name
{% endhighlight %}

--list 显示系统服务的运行状态(on或off)  
--add  增加系统服务  
--del  删除系统服务  
--level 指定系统服务在哪个执行等级中开启或关闭  
      等级0表示：表示关机  
      等级1表示：单用户模式  
      等级2表示：无网络连接的多用户命令行模式  
      等级3表示：有网络连接的多用户命令行模式  
      等级4表示：不可用  
      等级5表示：带图形界面的多用户模式  
      等级6表示：重新启动  

### 基本用法

* 查询当前所有自动启动的服务
{% highlight text %}
chkconfig --list 
chkconfig --list [name] //查询特定服务
{% endhighlight %}

* 开机启动开启/关闭
{% highlight bash %}
chkconfig httpd on/off
{% endhighlight %}

* 指定服务运行等级
{% highlight bash %}
chkconfig --level 35 httpd on/off
{% endhighlight %}
设定httpd在等级3和5为开机运行服务.

* 新增服务
{% highlight bash %}
chkconfig --add httpd
{% endhighlight %}
加入到chkconfig列表

* 删除服务
{% highlight bash %}
chkconfig --del httpd
{% endhighlight %}
从chkconfig列表移除服务



