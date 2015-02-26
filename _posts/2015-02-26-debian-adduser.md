---
layout: post
title: "debian创建用户没有宿主目录"
date: "2015-02-26 15:19"
category: "linux"
tags: "debian"
--- 

在debian系统中，以useradd创建用户，默认不会创建密码和宿主目录. debian建议用adduser创建用户，它会提示创建初始密码和目录.
{% highlight bash %}
root@xxxx:/home# adduser wyq
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
	LANGUAGE = (unset),
	LC_ALL = (unset),
	LC_CTYPE = "zh_CN.UTF-8",
	LANG = "en_US.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
Adding user `pkadmin' ...
Adding new group `wyq' (1003) ...
Adding new user `wyq' (1002) with group `wyq' ...
Creating home directory `/home/wyq' ...
Copying files from `/etc/skel' ...
Enter new UNIX password: 
Retype new UNIX password: 
passwd: password updated successfully
Changing the user information for wyq
Enter the new value, or press ENTER for the default
	Full Name []:       
	Room Number []: 
	Work Phone []: 
	Home Phone []: 
	Other []: 
Is the information correct? [Y/n] y
{% endhighlight %}

