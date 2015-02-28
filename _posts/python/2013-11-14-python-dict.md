---
layout: post
title: "将[{},{}]转为dict"
date: "2013-11-14 21:31"
category: "python"
---

经常遇到一种需求，需要把从数据库取出的数据，转为dict对象([{}, {},...]-->dict)。
{% highlight bash linenos %}
rs = [{"user_id":111, "name":"abc"}, {"user_id":123, "name":"edf"}]
print dict(map(lambda r:[r["user_id"], r], rs))
>>{111: {'user_id': 111, 'name': 'abc'}, 123: {'user_id': 123, 'name': 'edf'}}
{% endhighlight %}
上面看起来比较啰嗦，换一种写法

{% highlight python linenos %}
print dict([r["user_id"], r] for r in rs)
{% endhighlight %}

更简洁的写法
{% highlight python linenos %}
{r['user_id'] : r for r in rs}
{% endhighlight %}
 
