---
layout: post
title: "利用setuptools的entry_point参数实现模块动态导入"
date: "2015-07-06 14:20"
category: "python"
---

setuptools提供了entry_points参数，允许在安装时，动态导入模块. 下面是简单示例.

* 目录结构  
建立如下文件

```bash
➜  book  tree
.
├── book
│   ├── add.py
│   ├── __init__.py
│   ├── remove.py
│   └── update.py
└── setup.py
```

* add.py内容  
remove.py、update.py与add.py相同

```python
def make():
    print "add"
```

* setup.py内容

```python
from setuptools import setup, find_packages

setup(
    name = "book",
    version = "0.1",
    packages = find_packages(),
    entry_points={
        "book":[
            "add=book.add:make",  #add=模块:函数/类
            "update=book.update:make",
            "remove=book.remove:make",
        ]
    }
)
```

* 编译成egg包

```bash
python setup.py bdist_egg
```

* 安装到系统路径  
上面编译命令可以不用，直接用install安装

```bash
python setup.py install
```

* 用法

```
from pkg_resources import iter_entry_points

for r in iter_entry_points("book"):
    m = r.load()
    m()
```

