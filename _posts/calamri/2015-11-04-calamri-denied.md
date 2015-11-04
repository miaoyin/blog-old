---
layout: post
title: "calmari日志提示OperationalError Permission denied"
date: "2015-11-04 10:50"
category: "calamri"
---

### 问题

在fedora22系统中部署calmari，使用calamari-ctl initialize启动calamari后，访问浏览器，浏览器提示500。查看日志文件/var/log/calmari/httpd_error.log，得到以下内容。

```
[Tue Nov 03 19:42:01.210895 2015] [wsgi:error] [pid 8586] [remote 127.0.0.1:168] mod_wsgi (pid=8586): Exception occurred processing WSGI script '/opt/calamari/conf/calamari.wsgi'.
[Tue Nov 03 19:42:01.210915 2015] [wsgi:error] [pid 8586] [remote 127.0.0.1:168] Traceback (most recent call last):
[Tue Nov 03 19:42:01.210931 2015] [wsgi:error] [pid 8586] [remote 127.0.0.1:168]   File "/opt/calamari/venv/lib/python2.7/site-packages/django/core/handlers/wsgi.py", line 255, in __call__
[Tue Nov 03 19:42:01.211007 2015] [wsgi:error] [pid 8586] [remote 127.0.0.1:168]     response = self.get_response(request)
[Tue Nov 03 19:42:01.211018 2015] [wsgi:error] [pid 8586] [remote 127.0.0.1:168]   File "/opt/calamari/venv/lib/python2.7/site-packages/django/core/handlers/base.py", line 178, in get_response
[Tue Nov 03 19:42:01.211032 2015] [wsgi:error] [pid 8586] [remote 127.0.0.1:168]     response = self.handle_uncaught_exception(request, resolver, sys.exc_info())
[Tue Nov 03 19:42:01.211040 2015] [wsgi:error] [pid 8586] [remote 127.0.0.1:168]   File "/opt/calamari/venv/lib/python2.7/site-packages/django/core/handlers/base.py", line 220, in handle_uncaught_exception
[Tue Nov 03 19:42:01.211050 2015] [wsgi:error] [pid 8586] [remote 127.0.0.1:168]     if resolver.urlconf_module is None:
[Tue Nov 03 19:42:01.211056 2015] [wsgi:error] [pid 8586] [remote 127.0.0.1:168]   File "/opt/calamari/venv/lib/python2.7/site-packages/django/core/urlresolvers.py", line 342, in urlconf_module
[Tue Nov 03 19:42:01.211066 2015] [wsgi:error] [pid 8586] [remote 127.0.0.1:168]     self._urlconf_module = import_module(self.urlconf_name)
[Tue Nov 03 19:42:01.211080 2015] [wsgi:error] [pid 8586] [remote 127.0.0.1:168]   File "/opt/calamari/venv/lib/python2.7/site-packages/django/utils/importlib.py", line 35, in import_module
[Tue Nov 03 19:42:01.211091 2015] [wsgi:error] [pid 8586] [remote 127.0.0.1:168]     __import__(name)
[Tue Nov 03 19:42:01.211097 2015] [wsgi:error] [pid 8586] [remote 127.0.0.1:168]   File "/opt/calamari/venv/lib/python2.7/site-packages/calamari_web-0.1-py2.7.egg/calamari_web/urls.py", line 20, in <module>
[Tue Nov 03 19:42:01.211109 2015] [wsgi:error] [pid 8586] [remote 127.0.0.1:168]     url(r'^api/v1/', include('calamari_rest.urls.v1')),
[Tue Nov 03 19:42:01.211115 2015] [wsgi:error] [pid 8586] [remote 127.0.0.1:168]   File "/opt/calamari/venv/lib/python2.7/site-packages/django/conf/urls/__init__.py", line 25, in include
[Tue Nov 03 19:42:01.211125 2015] [wsgi:error] [pid 8586] [remote 127.0.0.1:168]     urlconf_module = import_module(urlconf_module)
[Tue Nov 03 19:42:01.211131 2015] [wsgi:error] [pid 8586] [remote 127.0.0.1:168]   File "/opt/calamari/venv/lib/python2.7/site-packages/django/utils/importlib.py", line 35, in import_module
[Tue Nov 03 19:42:01.211139 2015] [wsgi:error] [pid 8586] [remote 127.0.0.1:168]     __import__(name)
[Tue Nov 03 19:42:01.211145 2015] [wsgi:error] [pid 8586] [remote 127.0.0.1:168]   File "/opt/calamari/venv/lib/python2.7/site-packages/calamari_rest_api-0.1-py2.7.egg/calamari_rest/urls/v1.py", line 3, in <module>
[Tue Nov 03 19:42:01.211156 2015] [wsgi:error] [pid 8586] [remote 127.0.0.1:168]     import calamari_rest.views.v1
[Tue Nov 03 19:42:01.211162 2015] [wsgi:error] [pid 8586] [remote 127.0.0.1:168]   File "/opt/calamari/venv/lib/python2.7/site-packages/calamari_rest_api-0.1-py2.7.egg/calamari_rest/views/v1.py", line 33, in <module>
[Tue Nov 03 19:42:01.211171 2015] [wsgi:error] [pid 8586] [remote 127.0.0.1:168]     from graphite.render.datalib import fetchData
[Tue Nov 03 19:42:01.211177 2015] [wsgi:error] [pid 8586] [remote 127.0.0.1:168]   File "/opt/calamari/venv/lib/python2.7/site-packages/graphite/render/datalib.py", line 20, in <module>
[Tue Nov 03 19:42:01.211187 2015] [wsgi:error] [pid 8586] [remote 127.0.0.1:168]     from graphite.storage import STORE, LOCAL_STORE
[Tue Nov 03 19:42:01.211192 2015] [wsgi:error] [pid 8586] [remote 127.0.0.1:168]   File "/opt/calamari/venv/lib/python2.7/site-packages/graphite/storage.py", line 7, in <module>
[Tue Nov 03 19:42:01.211201 2015] [wsgi:error] [pid 8586] [remote 127.0.0.1:168]     from graphite.remote_storage import RemoteStore
[Tue Nov 03 19:42:01.211207 2015] [wsgi:error] [pid 8586] [remote 127.0.0.1:168]   File "/opt/calamari/venv/lib/python2.7/site-packages/graphite/remote_storage.py", line 8, in <module>
[Tue Nov 03 19:42:01.211216 2015] [wsgi:error] [pid 8586] [remote 127.0.0.1:168]     from graphite.util import unpickle
[Tue Nov 03 19:42:01.211221 2015] [wsgi:error] [pid 8586] [remote 127.0.0.1:168]   File "/opt/calamari/venv/lib/python2.7/site-packages/graphite/util.py", line 71, in <module>
[Tue Nov 03 19:42:01.211230 2015] [wsgi:error] [pid 8586] [remote 127.0.0.1:168]     defaultUser = User.objects.get(username='default')
[Tue Nov 03 19:42:01.211235 2015] [wsgi:error] [pid 8586] [remote 127.0.0.1:168]   File "/opt/calamari/venv/lib/python2.7/site-packages/django/db/models/manager.py", line 143, in get
[Tue Nov 03 19:42:01.211245 2015] [wsgi:error] [pid 8586] [remote 127.0.0.1:168]     return self.get_query_set().get(*args, **kwargs)
[Tue Nov 03 19:42:01.211251 2015] [wsgi:error] [pid 8586] [remote 127.0.0.1:168]   File "/opt/calamari/venv/lib/python2.7/site-packages/django/db/models/query.py", line 382, in get
[Tue Nov 03 19:42:01.211259 2015] [wsgi:error] [pid 8586] [remote 127.0.0.1:168]     num = len(clone)
[Tue Nov 03 19:42:01.211265 2015] [wsgi:error] [pid 8586] [remote 127.0.0.1:168]   File "/opt/calamari/venv/lib/python2.7/site-packages/django/db/models/query.py", line 90, in __len__
[Tue Nov 03 19:42:01.211272 2015] [wsgi:error] [pid 8586] [remote 127.0.0.1:168]     self._result_cache = list(self.iterator())
[Tue Nov 03 19:42:01.211282 2015] [wsgi:error] [pid 8586] [remote 127.0.0.1:168]   File "/opt/calamari/venv/lib/python2.7/site-packages/django/db/models/query.py", line 301, in iterator
[Tue Nov 03 19:42:01.211290 2015] [wsgi:error] [pid 8586] [remote 127.0.0.1:168]     for row in compiler.results_iter():
[Tue Nov 03 19:42:01.211295 2015] [wsgi:error] [pid 8586] [remote 127.0.0.1:168]   File "/opt/calamari/venv/lib/python2.7/site-packages/django/db/models/sql/compiler.py", line 775, in results_iter
[Tue Nov 03 19:42:01.211305 2015] [wsgi:error] [pid 8586] [remote 127.0.0.1:168]     for rows in self.execute_sql(MULTI):
[Tue Nov 03 19:42:01.211310 2015] [wsgi:error] [pid 8586] [remote 127.0.0.1:168]   File "/opt/calamari/venv/lib/python2.7/site-packages/django/db/models/sql/compiler.py", line 839, in execute_sql
[Tue Nov 03 19:42:01.211318 2015] [wsgi:error] [pid 8586] [remote 127.0.0.1:168]     cursor = self.connection.cursor()
[Tue Nov 03 19:42:01.211324 2015] [wsgi:error] [pid 8586] [remote 127.0.0.1:168]   File "/opt/calamari/venv/lib/python2.7/site-packages/django/db/backends/__init__.py", line 326, in cursor
[Tue Nov 03 19:42:01.211333 2015] [wsgi:error] [pid 8586] [remote 127.0.0.1:168]     cursor = util.CursorWrapper(self._cursor(), self)
[Tue Nov 03 19:42:01.211339 2015] [wsgi:error] [pid 8586] [remote 127.0.0.1:168]   File "/opt/calamari/venv/lib/python2.7/site-packages/django/db/backends/postgresql_psycopg2/base.py", line 182, in _cursor
[Tue Nov 03 19:42:01.211348 2015] [wsgi:error] [pid 8586] [remote 127.0.0.1:168]     self.connection = Database.connect(**conn_params)
[Tue Nov 03 19:42:01.211354 2015] [wsgi:error] [pid 8586] [remote 127.0.0.1:168]   File "/opt/calamari/venv/lib/python2.7/site-packages/psycopg2/__init__.py", line 167, in connect
[Tue Nov 03 19:42:01.211363 2015] [wsgi:error] [pid 8586] [remote 127.0.0.1:168]     conn = _connect(dsn, connection_factory=connection_factory, async=async)
[Tue Nov 03 19:42:01.211376 2015] [wsgi:error] [pid 8586] [remote 127.0.0.1:168] OperationalError: could not connect to server: Permission denied
[Tue Nov 03 19:42:01.211380 2015] [wsgi:error] [pid 8586] [remote 127.0.0.1:168] \tIs the server running on host "localhost" (127.0.0.1) and accepting
[Tue Nov 03 19:42:01.211383 2015] [wsgi:error] [pid 8586] [remote 127.0.0.1:168] \tTCP/IP connections on port 5432?
```

### 方法

原因可能是postgresql自身访问限制、用户权限问题，检查后均被排除。查询资料得知，访问权限被selinux限制了。

第一种方法是设置selinux去掉访问限制

```
sudo setsebool -P httpd_can_network_connect_db on
```

第二种方法是关闭selinux

编辑/etc/selinux/config，将参数配为禁用，再重启系统。

```
SELINUX=disabled
```

### 相关命令

```
getsebool -a 查看selinux控制项
```


