#!/bin/bash

# 下载 wget git vim screen
yum -y install wget git vim screen

# 修改软件源
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.bak
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
yum clean all && yum makecache && yum update -y

# 配置vim
cat ../../../vimrc > ~/.vimrc