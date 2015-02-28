---
layout: post
title: "chkconfig配置开机启动"
date: "2015-02-24 21:15"
category: "linux"
--- 


### 新建脚本
{% highlight bash %}
touch /etc/init.d/echo_msg
{% endhighlight %}

* 添加内容
{% highlight text %}
#!/bin/zsh
#chkconfig:2345 61 61
#description:runing echo
echo "I am runing"  > /home/wyq/start.txt
{% endhighlight %}
前三行是chkconfig的格式，不可以省略，否则会出现"服务echo_msg，chkconfig不支持". 

### 赋予执行权限
{% highlight bash %}
chmod a+x echo_msg
{% endhighlight %}

### 加入chkconfig列表
{% highlight bash %}
chkconfig --add echo_msg
{% endhighlight %}

### 设置开机启动
{% highlight bash %}
chkconfig echo_msg on
{% endhighlight %}

重启系统之后, 在/home/wyq目录下发现start.txt文件，表示启动成功.


