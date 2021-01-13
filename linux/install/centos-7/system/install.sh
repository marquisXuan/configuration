#!/bin/bash

# 下载 wget git vim screen
yum -y install wget git vim screen

# 修改软件源
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.bak
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
yum clean all && yum makecache && yum update -y

# 配置vim
echo 'OnNldCBudQo6bm9oCnNldCBpZ25vcmVjYXNlCnNldCBzaG9ydG1lc3M9YXRJCnN5bnRheCBvbgphdXRvY21kIEluc2VydExlYXZlICogc2Ugbm9jdWwKc2V0IHJ1bGVyCnNldCBzaG93Y21kCnNldCBmb2xkZW5hYmxlCnNldCBmb2xkbWV0aG9kPW1hbnVhbApzZXQgYXV0b3dyaXRlCnNldCBjdXJzb3JsaW5lCnNldCBjb25maXJtCnNldCBhdXRvaW5kZW50CnNldCBjaW5kZW50CnNldCB0YWJzdG9wPTQKc2V0IHNvZnR0YWJzdG9wPTQKc2V0IHNoaWZ0d2lkdGg9NApzZXQgbm9leHBhbmR0YWIKc2V0IHNtYXJ0dGFiCnNldCBobHNlYXJjaApzZXQgaW5jc2VhcmNoCnNldCBlbmM9dXRmLTgKc2V0IGZlbmNzPXV0Zi04LHVjcy1ib20sc2hpZnQtamlzLGdiMTgwMzAsZ2JrLGdiMjMxMixjcDkzNgpzZXQgbGFuZ21lbnU9emhfQ04uVVRGLTgKc2V0IHNob3dtYXRjaApzZXQgc21hcnRpbmRlbnQK' | base64 -d >~/.vimrc
