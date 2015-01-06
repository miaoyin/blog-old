---
layout: post
title: "angularjs过滤器(number)"
date: "2014-08-22 21:13"
category: "linux"
---

用来精确浮点数(指定小数点位数).
## 在html中用法
{% highlight text %}
{{ number_expression | number : fractionSize}}
{% endhighlight %}

## 在js中用法
{% highlight text %}
$filter('number')(number, fractionSize)
{% endhighlight %}

## 参数
* number 待精确的数字  
* factionSize(可选) 小数点后精确位数，默认值是3.（默认情况下保留的小数位数小于等于3. 比如: 1234-->1234；1234.56789-->1234.568；1234.56-->1234.56）  
##例子
{% highlight html%}
<!doctype html>
<html ng-app='demo'>
<meta charset='utf-8'>
<body>
<div ng-controller="ExampleController">
  输入数字: <input ng-model='val'><br>
  <!-- 默认格式 -->
  默认格式: <span id='number-default'>{{val | number}}</span><br>
  <!-- factionSize=0 -->
  保留0位: <span>{{val | number:0}}</span><br>
  <!--factionSize大于小数点位数 -->
  保留10位: <span>{{val | number:10}}</span><br>
  <!-- factionSize小于小数点位数-->
  保留2位: <span>{{val | number:2}}</span>
</div>
 
<script src="/static/lib/angular/angular.js"></script>
<script src="/static/lib/angular-resource/angular-resource.min.js"></script>
<script>
    var app = angular.module('demo', ['ngResource'])
    .controller('ExampleController', function($scope) {
        $scope.val = 1234.56789;
    });
</script>
</body>
</html>
{% endhighlight %}
 
显示结果
{% highlight text %}
输入数字: 1,234.56789
默认格式: 1,234.568
保留0位: 1,235
保留10位: 1,234.5678900000
保留2位: 1,234.57
{% endhighlight %}
 

