---
layout: post
title: "django-restful请求的访问限制"
date: "2015-07-22 15:11"
category: "django"
---

## login_required无效

用django的restful写成的请求处理，使用auth模块中装饰器进行访问限制，出现request无user属性的错误.

```python
from django.views.generic import View
from django.contrib.auth.decorators import login_required

class TaskQueue(View):
    '''
    执行中的任务
    '''
    def __init__(self):
        self.manager = TaskQueueManager()

    def get(self, request):
        '''
        >> c.get("/task/queue/").content
        '''
        records = self.manager.list()
        return {"success": True, "msg": "", "data": records}

    @login_required
    def delete(self, request):
        '''
        >> c.delete("/task/queue/", json.dumps({"ids": [14]})).content
        '''
        params = json.loads(request.body)
        for id in params["ids"]:
            self.manager.delete(id)
        return {"success": True, "msg": ""}
```

## 查找原因

从django里拿到源码，调试后，发现View对象被赋给了装饰器的request.

```python
def user_passes_test(test_func, login_url=None, redirect_field_name=REDIRECT_FIELD_NAME):
    """
    Decorator for views that checks that the user passes the given test,
    redirecting to the log-in page if necessary. The test should be a callable
    that takes the user object and returns True if the user passes.
    """

    def decorator(view_func):
        @wraps(view_func, assigned=available_attrs(view_func))
        # view对象传给料request
        def _wrapped_view(request, *args, **kwargs):
            if test_func(request.user):
                return view_func(request, *args, **kwargs)
            path = request.build_absolute_uri()
            resolved_login_url = resolve_url(login_url or settings.LOGIN_URL)
            # If the login url is the same scheme and net location then just
            # use the path as the "next" url.
            login_scheme, login_netloc = urlparse(resolved_login_url)[:2]
            current_scheme, current_netloc = urlparse(path)[:2]
            if ((not login_scheme or login_scheme == current_scheme) and
                    (not login_netloc or login_netloc == current_netloc)):
                path = request.get_full_path()
            from django.contrib.auth.views import redirect_to_login
            return redirect_to_login(
                path, resolved_login_url, redirect_field_name)
        return _wrapped_view
    return decorator


def login_required(function=None, redirect_field_name=REDIRECT_FIELD_NAME, login_url=None):
    """
    Decorator for views that checks that the user is logged in, redirecting
    to the log-in page if necessary.
    """
    actual_decorator = user_passes_test(
        lambda u: u.is_authenticated(),
        login_url=login_url,
        redirect_field_name=redirect_field_name
    )
    if function:
        return actual_decorator(function)
    return actual_decorator
```


## 自定义login_required

解决的办法是进行自定义. 将user_passes_test和login_required拿出来，作如下修改

```python
...
# 加上self
def _wrapped_view(self, request, *args, **kwargs):
    if test_func(request.user):
        # 加上self
        return view_func(self, request, *args, **kwargs)
...

```


