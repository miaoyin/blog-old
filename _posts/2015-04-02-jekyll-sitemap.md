---
layout: post
title: "启动jekyll出现undefined method `relative_path`"
date: "2015-03-27 13:36"
category: "jekyll"
--- 
安装jekyll-sitemap后，启动jekyll出现下面错误

* 错误信息
{% highlight bash %}
➜  blog git:(master) jekyll serve -P 8080  -w --trace 
Configuration file: /home/wyq/blog/_config.yml
            Source: /home/wyq/blog
       Destination: /home/wyq/blog/_site
      Generating... /usr/local/share/gems/gems/jekyll-sitemap-0.8.1/lib/jekyll-sitemap.rb:28:in `block in html_files': undefined method `relative_path' for #<Jekyll::StaticFile:0x00000000777a68> (NoMethodError)
	from /usr/local/share/gems/gems/jekyll-sitemap-0.8.1/lib/jekyll-sitemap.rb:28:in `select'
	from /usr/local/share/gems/gems/jekyll-sitemap-0.8.1/lib/jekyll-sitemap.rb:28:in `html_files'
	from /usr/local/share/gems/gems/jekyll-sitemap-0.8.1/lib/jekyll-sitemap.rb:18:in `generate'
	from /usr/local/share/gems/gems/jekyll-1.5.0/lib/jekyll/site.rb:227:in `block in generate'
	from /usr/local/share/gems/gems/jekyll-1.5.0/lib/jekyll/site.rb:226:in `each'
	from /usr/local/share/gems/gems/jekyll-1.5.0/lib/jekyll/site.rb:226:in `generate'
	from /usr/local/share/gems/gems/jekyll-1.5.0/lib/jekyll/site.rb:38:in `process'
	from /usr/local/share/gems/gems/jekyll-1.5.0/lib/jekyll/command.rb:18:in `process_site'
	from /usr/local/share/gems/gems/jekyll-1.5.0/lib/jekyll/commands/build.rb:23:in `build'
	from /usr/local/share/gems/gems/jekyll-1.5.0/lib/jekyll/commands/build.rb:7:in `process'
	from /usr/local/share/gems/gems/jekyll-1.5.0/bin/jekyll:97:in `block (2 levels) in <top (required)>'
	from /usr/local/share/gems/gems/commander-4.1.6/lib/commander/command.rb:180:in `call'
	from /usr/local/share/gems/gems/commander-4.1.6/lib/commander/command.rb:180:in `call'
	from /usr/local/share/gems/gems/commander-4.1.6/lib/commander/command.rb:155:in `run'
	from /usr/local/share/gems/gems/commander-4.1.6/lib/commander/runner.rb:422:in `run_active_command'
	from /usr/local/share/gems/gems/commander-4.1.6/lib/commander/runner.rb:82:in `run!'
	from /usr/local/share/gems/gems/commander-4.1.6/lib/commander/delegates.rb:8:in `run!'
	from /usr/local/share/gems/gems/commander-4.1.6/lib/commander/import.rb:10:in `block in <top (required)>'
{% endhighlight %}

* 查看jekyll版本  
查到原因，可能是jekyll版本太旧. 先看看自己的jekyll版本
{% highlight bash %}
➜  blog git:(master) jekyll -v
jekyll 1.5.0
{% endhighlight %}

* 升级jekyll
{% highlight bash %}
➜  blog git:(master) sudo gem install jekyll
{% endhighlight %}

升级之后jekyll版本为2.5.3，重新启动jekyll，运行正常.

