---
layout: post
title: "如何配置django静态文件路径"
date: "2015-05-12 09:49"
category: "django"
---

django默认无法直接访问静态文件(js、css、images)。要settings中配置STATICFILES_DIRS参数. 例如：

{% highlight bash %}
# static目录url路径
STATIC_URL = '/static/'

#static目录磁盘路径
STATICFILES_DIRS = (
    os.path.join(BASE_DIR, 'mysite/static'),
)
{% endhighlight %}



