---
layout: post
title: "基于python的jQuery File Upload简单示例"
date: "2015-03-27 13:36"
category: "jquery"
tags: ["flask", "插件"]
--- 

找到个很不错的文件上传插件jQuery File Upload. 资料太少. 只能自己搭个环境，照着例子摸索. 奈何最简单的例子是基于php的，不熟. 自己弄了个基于python的例子.

* github
{% highlight bash %}
https://github.com/blueimp/jQuery-File-Upload
{% endhighlight %}

* 目录  
使用flask做了个简单web服务器，接收上传请求. 目录结构如下
{% highlight bash %}
➜  flask-demo  tree
.
├── app.py
├── static
│   ├── 123.txt
│   └── file-upload
│       ├── angularjs.html
│       ├── basic.html
│       ├── basic-plus.html
│       ├── blueimp-file-upload.jquery.json
│       ├── bower.json
│       ├── CONTRIBUTING.md
│       ├── cors
│       │   ├── postmessage.html
│       │   └── result.html
│       ├── css
│       │   ├── demo.css
│       │   ├── demo-ie8.css
│       │   ├── jquery.fileupload.css
│       │   ├── jquery.fileupload-noscript.css
│       │   ├── jquery.fileupload-ui.css
│       │   ├── jquery.fileupload-ui-noscript.css
│       │   └── style.css
│       ├── Gruntfile.js
│       ├── img
│       │   ├── loading.gif
│       │   └── progressbar.gif
│       ├── index.html
│       ├── jquery-ui.html
│       ├── js
│       │   ├── app.js
│       │   ├── cors
│       │   │   ├── jquery.postmessage-transport.js
│       │   │   └── jquery.xdr-transport.js
│       │   ├── jquery.fileupload-angular.js
│       │   ├── jquery.fileupload-audio.js
│       │   ├── jquery.fileupload-image.js
│       │   ├── jquery.fileupload-jquery-ui.js
│       │   ├── jquery.fileupload.js
│       │   ├── jquery.fileupload-process.js
│       │   ├── jquery.fileupload-ui.js
│       │   ├── jquery.fileupload-validate.js
│       │   ├── jquery.fileupload-video.js
│       │   ├── jquery.iframe-transport.js
│       │   ├── jquery.min.js
│       │   ├── main.js
│       │   └── vendor
│       │       └── jquery.ui.widget.js
│       ├── package.json
│       ├── README.md
│       ├── server
│       │   ├── gae-go
│       │   │   ├── app
│       │   │   │   └── main.go
│       │   │   ├── app.yaml
│       │   │   └── static
│       │   │       ├── favicon.ico
│       │   │       └── robots.txt
│       │   ├── gae-python
│       │   │   ├── app.yaml
│       │   │   ├── main.py
│       │   │   └── static
│       │   │       ├── favicon.ico
│       │   │       └── robots.txt
│       │   ├── node
│       │   │   ├── package.json
│       │   │   ├── public
│       │   │   │   └── files
│       │   │   │       └── thumbnail
│       │   │   ├── server.js
│       │   │   └── tmp
│       │   └── php
│       │       ├── files
│       │       ├── index.php
│       │       └── UploadHandler.php
│       ├── test
│       │   ├── index.html
│       │   └── test.js
│       └── test.html
└── templates
    └── index.html

23 directories, 57 files
{% endhighlight %}

* app.py
{% highlight python %}
#encoding=utf-8
from flask import Flask
from flask import request
from flask import abort, redirect, url_for
from flask import render_template
import json

app = Flask(__name__)


@app.route('/')
def index():
    return render_template('index.html')


@app.route('/upload', methods=['GET', 'POST'])
def upload_file():
    if request.method == 'POST':
        f = request.files['files[]']
        filename = f.filename
        minetype = f.content_type
        f.save('static/' + filename)
    return json.dumps({"files": [{"name": filename, "minetype": minetype}]})


if __name__ == '__main__':
    app.run(host="0.0.0.0", port=7000, debug=True)
{% endhighlight %}

* demo.html
{% highlight html %}
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<title>jQuery File Upload 示例</title>
</head>
<body>
<input id="fileupload" type="file" name="files[]" data-url="/upload" multiple>
<script src="/static/file-upload/js/jquery.min.js"></script>
<script src="/static/file-upload/js/vendor/jquery.ui.widget.js"></script>
<script src="/static/file-upload/js/jquery.iframe-transport.js"></script>
<script src="/static/file-upload/js/jquery.fileupload.js"></script>
<script>
$(function () {
    $('#fileupload').fileupload({
        dataType: 'json',
        done: function (e, data) {
            $.each(data.result.files, function (index, file) {
                $('<p/>').text(file.name).appendTo(document.body);
            });
        }
    });
});
</script>
</body> 
</html>
{% endhighlight %}
试了之后，确实很不错.


