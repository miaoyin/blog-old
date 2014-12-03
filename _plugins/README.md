这是一个用于[Jekyll](https://github.com/mojombo/jekyll)的youku、tudou嵌入插件。

This is a plugin meant for [Jekyll](https://github.com/mojombo/jekyll).

用例：

Example use:

将youku.rb和/或tudou.rb文件拷贝至`_plugins`目录下，然后在文章中输入以下代码即可嵌入。

Easily embed a YouTube video. Just drop these files in your `_plugins directory.

```
{% youku XNTc2ODk1NjI0 %}
{% tudou XNTc2ODk1NjI0 %}
```
你还可以定义播放器的宽度和高度。如果你不提供，将使用默认值560 x 420。

You can also specify a height and width. If you do not, it defaults to 560 x 420.

```
{% youku XNTc2ODk1NjI0 500 400 %}
{% tudou XNTc2ODk1NjI0 500 400 %}
```
基于[Generate YouTube Embed (tag) by joelverhagen](https://gist.github.com/joelverhagen/1805814)制作。

Based on [Generate YouTube Embed (tag) by joelverhagen](https://gist.github.com/joelverhagen/1805814)