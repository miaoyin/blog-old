---
layout: post
title: "理解指令的restrict属性"
date: "2014-07-30 01:26"
category: "angularjs"
---

## restrcit属性说明
restrict: EACM中的任意一个之母。它是用来限制指令的声明格式的。
{% highlight bash %}
E - 元素名称：<my-directive></my-directive>
A - 属性： <div my-directive="exp"> </div>
C - 类名：<div class="my-directive: exp;"></div>
M - 注释： <!-- directive: my-directive exp -->
{% endhighlight %}
 
## 它做了什么
* 示例
{% highlight html %}
<html ng-app='app'>
<body>
    <hello> </hello>
    <div hello> </div>
    <div class="hello"> </div>
    <!-- directive: hello -->
</body>
 
<script src="bower_components/angular/angular.js"></script>
<script>
var appModule = angular.module('app', []);
appModule.directive('hello', function() {
    return {
        restrict: 'AEC',
        template: '<h3>Hi there</h3>',
        replace: true
    };
});
</script>
</html>
{% endhighlight %}
 
* 运行结果
{% highlight html %}
<h3>Hi there</h3>
<h3 hello>Hi there</h3>
<h3 class="hello">Hi there</h3>
<h3>Hi there</h3>
{% endhighlight %}
可以看到几种方式，做的事情一样，只有部分区别. 这些区别有什么作用，用在什么场合？
 
## 使用场合
* restrict=E时，浏览器无法识别指令的声明元素，那么可以知道这个指令一定是起 **替换作用** ，也就是说template一定有值.  
* restrict=A时，指令是以元素属性形式存在的，这个指令的作用则可以不是替换作用. 那么它可以做什么？ **以link方式操作dom**  
比如为元素聚焦
{% highlight html %}
<input type="input" focus/>
 
appModule.directive('focus', function() {
    return {
        restrict: 'A',
        link:function(scope, elem, attrs){
            $(elem).focus();
        }
    };
});
{% endhighlight %}
* restrict=C，则是在绑定指令的同时，指定它的css样式，让指令与样式同步.  
* restrict=M，则在一些场合非常有用，方便在注释与代码之间切换.  
 
