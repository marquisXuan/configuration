#!/bin/bash

# 安装 zsh
yum -y install zsh

# 修改 zsh 配置文件
sed -i -e '/#/d' ~/.zshrc
sed -i -e '/^\s*$/d' ~/.zshrc

echo "接下来请手动执行脚本中的相关命令"
# 安装 oh-my-zsh
sh -c "$(curl -fsSL http://git.oschina.net/yangchendong/oh-my-zsh/raw/master/tools/install.sh)"


######## 执行后会卡住。手动执行下面的命令。还不会去中断
# 安装插件
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting && sed -i -e 's/fg=8/fg=6/g' ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh && sed -i -e 's/^plugins=(.*)$/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/g' ~/.zshrc && source ~/.zshrc