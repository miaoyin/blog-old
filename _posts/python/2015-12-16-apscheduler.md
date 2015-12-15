---
layout: post
title: "apscheduler提示maximum错误"
date: "2015-12-16 03:31"
category: "python"
tag: "apscheduler"
---

# 起因

在tornado中用apscheduler实现计划任务，出现错误提示

```
2015-12-04 19:10:22,227 - apscheduler.scheduler - WARNING - Execution of job "TaskHandle.progress_job (trigger: date[2015-12-04 19:10:22 CST], next run at: 2015-12-04 19:10:22 CST)" skipped: maximum number of running instances reached (1)
```

# 分析

缺乏资料，所以根据提示，分析apscheduler源码

* 记录异常位置

在源码目录下，搜索关键字maxinum，找到记录异常的位置

```
#apscheduler/schedulers/base.py
if run_times:
    try:
        executor.submit_job(job, run_times)
    except MaxInstancesReachedError:
        self._logger.warning(
            'Execution of job "%s" skipped: maximum number of running instances reached (%d)',
            job, job.max_instances)
    except:
        self._logger.exception('Error submitting job "%s" to executor "%s"', job, job.executor)
```

* 异常抛出位置

继续看submit_job函数，找到异常抛出位置

```
#apscheduler/executors/base.py
def submit_job(self, job, run_times):
    """
    Submits job for execution.

    :param Job job: job to execute
    :param list[datetime] run_times: list of datetimes specifying when the job should have been run
    :raises MaxInstancesReachedError: if the maximum number of allowed instances for this job has been reached
    """

    assert self._lock is not None, 'This executor has not been started yet'
    with self._lock:
        if self._instances[job.id] >= job.max_instances:
            raise MaxInstancesReachedError(job)

        self._do_submit_job(job, run_times)
        self._instances[job.id] += 1
```

* _instances变量作用

在submit_job(提交任务)时加1，在_run_job_success(任务运行成功)时减1。 当self._instances[job.id]大于job.max_instances抛出异常。
max_instances默认值为1，它表示id相同的任务实例数。

# 解决

设置max_instances参数

```
sched.add_job(child_job, max_instances=10, trigger=DateTrigger(), id="123")
```

# 重现脚本

```
import time
import tornado.ioloop
from apscheduler.triggers.date import DateTrigger
from apscheduler.schedulers.tornado import TornadoScheduler

sched = TornadoScheduler()

def child_job():
    print "start"
    time.sleep(60)
    print "end"

def main_job():
    sched.add_job(child_job, trigger=DateTrigger(), id="123")

sched.add_job(main_job, 'interval', seconds=5)

sched.start()
tornado.ioloop.IOLoop.instance().start()

```

* 输出
```
job_id: 7279209ab6c2498698f2117bb97e18a1, instances: 0, max_instances: 1
job_id: 123, instances: 0, max_instances: 1
start
job_id: 7279209ab6c2498698f2117bb97e18a1, instances: 0, max_instances: 1
job_id: 123, instances: 1, max_instances: 1
WARNING:apscheduler.scheduler:Execution of job "child_job (trigger: date[2015-12-07 15:27:11 CST], next run at: 2015-12-07 15:27:11 CST)" skipped: maximum number of running instances reached (1)
job_id: 7279209ab6c2498698f2117bb97e18a1, instances: 0, max_instances: 1
```


