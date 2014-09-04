---
layout: post
title:  "Welcome to Jekyll!"
date:   2014-03-27 16:30:29
categories: python
---

You'll find this post in your `_posts` directory - edit this post and re-build (or run with the `-w` switch) to see your changes!
To add new posts, simply add a file in the `_posts` directory that follows the convention: YYYY-MM-DD-name-of-post.ext.

Jekyll also offers powerful support for code snippets:

{% highlight ruby %}
def print_hi(name)
  puts "Hi, #{name}"
end
print_hi('Tom')
#=> prints 'Hi, Tom' to STDOUT.
{% endhighlight %}

Check out the [Jekyll docs][jekyll] for more info on how to get the most out of Jekyll. File all bugs/feature requests at [Jekyll's GitHub repo][jekyll-gh].

[jekyll-gh]: https://github.com/mojombo/jekyll
[jekyll]:    http://jekyllrb.com

Setex方式
标题1
=
标题2
---

Atx方式
# 标题1
## 标题2
### 标题3

> 这是一个引用，
> 这里没有换行，
> 这里换行了。
>> 内部嵌套

<pre>
<code class="python">
def main():
    pass
<code>
</pre>

{% highlight python linenos %}
def main():
    pass
{% endhighlight %}

<h4>Category</h4>
<ul>
    {% for category in site.categories%}
        <li>
            <a href="/categories/{{category | first}}" title="view all posts">{{category | first}} {{category | last |size}}</a>
        </li>
    {% endfor %}
</ul>


{% for category in site.categories %}
<h2>{{ category | first }}(<span>{{ category | last | size }}</span>)</h2>
<ul class="arc-list">
{% for post in category.last %}
<li>
    {{ post.date | date:"%Y/%m/%d"}}
    <a href="{{site.baseurl}}/{{ post.url }}">{{ post.title }}</a>
</li>
{% endfor %}
</ul>
{% endfor %}

