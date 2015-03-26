---
layout: post
title: "pillow生成缩略图"
date: "2015-03-26 15:35"
category: "python"
--- 


* 安装
{% highlight bash %}
sudo pip install Pillow
{% endhighlight %}

* 示例
{% highlight python %}
from PIL import Image

im = Image.open("logo.png")
im.thumbnail((32, 32))
im.save("thumbnail.png", "png")
{% endhighlight %}

pillow文档地址
{% highlight text %}
http://pillow.readthedocs.org/index.html
{% endhighlight %}


