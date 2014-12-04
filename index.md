---
layout: index 
title: 妙音's blog
---

<div id="home">
  <ul class="posts">
    {% for post in site.posts %}
    <li><span>{{ post.date | date:"%Y-%m-%d" }}</span> &raquo;
    <a href="{{site.baseurl}}{{ post.url }}">{{ post.title }}</a></li>
    {% endfor %}
  </ul>
</div>


<nav>
  <ul class="pagination">
    <li><a href="#">&laquo;</a></li>
    <li><a href="#">1</a></li>
    <li><a href="#">2</a></li>
    <li><a href="#">3</a></li>
    <li><a href="#">4</a></li>
    <li><a href="#">5</a></li>
    <li><a href="#">&raquo;</a></li>
  </ul>
</nav>
