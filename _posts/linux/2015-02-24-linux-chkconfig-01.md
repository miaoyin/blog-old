---
layout: post
title: "服务chkconfig不支持"
date: "2015-02-24 21:15"
category: "linux"
--- 

自定义脚本启动脚本，放在/etc/init.d/目录下. 并使用chkconfig设置为开机启动. 出现了"服务echo_msg，不支持chkconfig"

原因是chkconfig对脚本格式有要求，必须在脚本开头添加chkconfig描述
{% highlight bash %}
#!/bin/bash
#chkconfig:2345 61 61
#description: echo_msg开机测试
{% endhighlight %}
* 第一行，指明脚本解释程序
* 第二行chkconfig，2345指定脚本运行等级，61和61指定启动和关闭序号
* 第三行description 描述信息

