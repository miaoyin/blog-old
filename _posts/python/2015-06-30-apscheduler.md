---
layout: post
title: "apscheduler定时任务"
date: "2015-06-30 16:50"
category: "python"
tags: ["apscheduler"]
---

使用apscheduler定时任务，可以使用interval任务+cron任务，interval定时更新cron配置信息，cron则实现作业计划。

# 通常用法
{% highlight python %}
from apscheduler.schedulers.blocking import BlockingScheduler
sched = BlockingScheduler()

def my_job():
    print 'hello world'

# 使用修饰器
@sched.scheduled_job('cron', id='my_job_id', second=10)
def hello():
    print "hello decorate"

# 轮循
sched.add_job(my_job, 'interval', seconds=5)
# 定时计划
sched.add_job(my_job, 'cron', second=5, minute=1, hour=12, day_of_week=2)
sched.start()
{% endhighlight %}

# 在tarnado中用法
{% highlight python %}
import tornado
from apscheduler.schedulers.tornado import TornadoScheduler
sched = TornadoScheduler()

def my_job():
    print sched.get_jobs()

sched.add_job(my_job, 'interval', seconds=5, id="1")
sched.start()

tornado.ioloop.IOLoop.instance().start()
{% endhighlight %}

# 任务触发器比较
很多情况下，任务是根据数据库调整触发时间，时间改变了，如何判断触发器是否变化？
生成新trigger然后，专程字符串比较比较
{% highlight python %}
# 触发器比较
str(job.trigger) != str(trigger)
# 修改触发器
sched.reschedule_job(job.id, trigger=trigger)
{% endhighlight %}

