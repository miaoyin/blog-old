---
layout: post
title: "angularjs指令名是怎么回事？"
date: "2014-08-12 12:06"
category: "angularjs"
---

## 疑惑
查了很多资料，对指令名的介绍都是一笔带过，只说是驼峰形式. 但是在实际使用时，经常遇到定义的指令名与指令标签对应不上的情况. 对指令名就感到非常疑惑. 定义时指令名是一种形式，使用时又是一种形式，两者怎么关联对应的？  

找不到资料，自己查查angular源码，一探究竟.  

## 分析源码
首先在angular.js文件，找到解析指令名的代码
{% highlight javascript %}
switch(nodeType) {
  case 1: /* Element */
    // use the node name: <directive>
    //此处是解析标签形式的指令
    addDirective(directives,
        directiveNormalize(nodeName_(node).toLowerCase()), 'E', maxPriority, ignoreDirective);
 
    // iterate over the attributes
    for (var attr, name, nName, ngAttrName, value, isNgAttr, nAttrs = node.attributes,
             j = 0, jj = nAttrs && nAttrs.length; j < jj; j++) {
      var attrStartName = false;
      var attrEndName = false;
 
      attr = nAttrs[j];
      if (!msie || msie >= 8 || attr.specified) {
        name = attr.name;
        value = trim(attr.value);
 
        // support ngAttr attribute binding
        ngAttrName = directiveNormalize(name);
        if (isNgAttr = NG_ATTR_BINDING.test(ngAttrName)) {
          name = snake_case(ngAttrName.substr(6), '-');
        }
 
        var directiveNName = ngAttrName.replace(/(Start|End)$/, '');
        if (ngAttrName === directiveNName + 'Start') {
          attrStartName = name;
          attrEndName = name.substr(0, name.length - 5) + 'end';
          name = name.substr(0, name.length - 6);
        }
 
        //此处是解析属性形式的指令名
        nName = directiveNormalize(name.toLowerCase());
        attrsMap[nName] = name;
        if (isNgAttr || !attrs.hasOwnProperty(nName)) {
            attrs[nName] = value;
            if (getBooleanAttrName(node, nName)) {
              attrs[nName] = true; // presence means true
            }
        }
        addAttrInterpolateDirective(node, directives, value, nName);
        addDirective(directives, nName, 'A', maxPriority, ignoreDirective, attrStartName,
                      attrEndName);
      }
    }
{% endhighlight %}
上面一处是解析标签形式的指令名，调用了directiveNormalize(nodeName_(node).toLowerCase())  
另一处是解析属性形式的指令名，调用了directiveNormalize(name.toLowerCase())  
两处都使用了toLowerCase()  
所以解析指令的**第一步：将指令名转为小写.**  
 
继续看directiveNormalize()函数
{% highlight javascript %}
var PREFIX_REGEXP = /^(x[\:\-_]|data[\:\-_])/i;
/**
 * Converts all accepted directives format into proper directive name.
 * All of these will become 'myDirective':
 *   my:Directive
 *   my-directive
 *   x-my-directive
 *   data-my:directive
 *
 * Also there is special case for Moz prefix starting with upper case letter.
 * @param name Name to normalize
 */
function directiveNormalize(name) {
  return camelCase(name.replace(PREFIX_REGEXP, ''));
}
{% endhighlight %}
它使用用了name.replace(PREFIX_REGEXP, '')，它的作用是去掉x和data开始的前缀
所以解析指令的 **第二步:去掉以x-和data-开头的前缀(例如 x- x: x_ data- data: data_ 忽略大小写)**  
 
 
再继续看camelCase()函数
{% highlight javascript %}
var SPECIAL_CHARS_REGEXP = /([\:\-\_]+(.))/g;
var MOZ_HACK_REGEXP = /^moz([A-Z])/;
var jqLiteMinErr = minErr('jqLite');
 
/**
 * Converts snake_case to camelCase.
 * Also there is special case for Moz prefix starting with upper case letter.
 * @param name Name to normalize
 */
function camelCase(name) {
  return name.
    replace(SPECIAL_CHARS_REGEXP, function(_, separator, letter, offset) {
      return offset ? letter.toUpperCase() : letter;
    }).
    replace(MOZ_HACK_REGEXP, 'Moz$1');
}
{% endhighlight %}
使用了两个replace替换字符，第二个replace不用管，重点看第一个replace，它是什么作用？

把它拿出来看看
{% highlight javascript %}
var SPECIAL_CHARS_REGEXP = /([\:\-\_]+(.))/g;
function camelCase(name) {
  return name.
    replace(SPECIAL_CHARS_REGEXP, function(_, separator, letter, offset) {
      console.log("_:" + _)
      console.log("separator:" + separator)
      console.log("letter:" + letter)
      return offset ? letter.toUpperCase() : letter;
    }).
}
console.log("----my-directive")
console.log(camelCase(my-directive));
 
console.log("----mydirective")
console.log(camelCase(my-directive));
 
console.log("----mydirectiveworld")
console.log(camelCase(my-directive));
/* 
输出内容
----my-directive
_:-d
separator:-d
letter:d
myDirective
 
----mydirective
mydirective
 
----mydirectiveworld
mydirectiveworld
*/
{% endhighlight %}
可以看到第一个replace作用是生成驼峰指令名
所以解析指令的**第三步：根据分割符(: - _)标记，将字符转换为驼峰形式**
 
关于replace函数的说明，可以看看这篇文章
http://yongqing.is-programmer.com/posts/56305.html
 
 
更多指令名与指令对应的示例
{% highlight text %}
以分割符"-"为例
mymenu --> mymenu   正确
mymenu --> myMenu   错误
mymenu --> my-Menu  错误
 
myMenu --> my-Menu  正确
myMenu --> myMenu   错误
myMenu --> mymenu   错误
 
MyMenu --> x-MyMenu 正确
MyMenu --> MyMenu   错误
MyMenu --> mymenu   错误
 
myProductsMenu --> my-Products-Menu   正确
myProductsMenu --> myProductsMenu     错误
myProductsMenu --> my-ProductsMenu    错误
{% endhighlight %}

## 总结
指令的匹配过程  
1. 将指令名转换为小写.  
2. 去掉以x-和data-开头的前缀(例如 x- x: x_ data- data: data_ 忽略大小写) 
3. 根据分割符(: - _)，转换为驼峰形式  
其实只要注意一点: 匹配过程以定义时的指令名为准，分割符是用来标识驼峰的(angular没有能力识别单词，分割符的一个作用是标识驼峰).  

