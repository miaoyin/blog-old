---
layout: post
title: "如何配置django静态文件路径"
date: "2015-05-12 09:49"
category: "django"
---

django默认无法直接访问静态文件(js、css、images)，并且设置方法会与DEBUG相关

# DEBUG=True时
要在settings中的配置STATICFILES_DIRS参数. 如下

{% highlight python %}
# static目录url路径
STATIC_URL = '/static/'

#static目录磁盘路径
STATICFILES_DIRS = (
    os.path.join(BASE_DIR, 'mysite/static'),
)
{% endhighlight %}

# DEBUG=Flase时
在DEBUG=Flase时，不仅需要进行上面设置，而且要多加两处配置.

settings文件
{% highlight python %}
STATIC_ROOT = '/homew/wyq/mysite/mysite/static'
{% endhighlight %}

urls.py文件
{% highlight python %}
from django.conf import settings

if settings.DEBUG is False:
    urlpatterns += patterns('',
        url(r'^static/(?P<path>.*)$', 'django.views.static.serve', {
            'document_root': settings.STATIC_ROOT,
        }),
    )
{% endhighlight %}


