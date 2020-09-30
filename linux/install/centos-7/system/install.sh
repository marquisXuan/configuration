#!/bin/bash

# 下载 wget git vim screen
yum -y install wget git vim screen

# 修改软件源
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.bak
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
yum clean all && yum makecache && yum update -y

# 配置vim
cat ../../../vimrc > ~/.vimrc

# 安装 zsh
yum -y install zsh

# 安装 oh-my-zsh
sh -c "$(curl -fsSL http://git.oschina.net/yangchendong/oh-my-zsh/raw/master/tools/install.sh)"

# 修改 zsh 配置文件
sed -i -e '/#/d' ~/.zshrc
sed -i -e '/^\s*$/d' ~/.zshrc

# 安装插件
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting


sed -i -e 's/fg=8/fg=6/g' ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

sed -i -e 's/^plugins=(.*)$/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/g' ~/.zshrc 

source ~/.zshrc