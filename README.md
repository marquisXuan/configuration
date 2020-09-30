# 常用的配置文件

> 包含但不仅包含软件配置文件 -.-

```txt
├── README.md
└── linux
    ├── install ===================================================== 安装
    │   └── centos-7 ================================================ Centos7系统
    │       ├── base.sh ============================================= 基础脚本
    │       ├── docker ============================================== Docker相关的配置
    │       │   ├── README.md ======================================= 说明文档
    │       │   ├── docker-mysql.sh ================================= Docker-Mysql安装脚本
    │       │   ├── docker-nginx.sh ================================= Docker-Nginx安装脚本
    │       │   ├── docker-spring-boot.sh =========================== Docker-Spring-Boot安装脚本
    │       │   └── docker.sh  ====================================== Docker环境安装脚本
    │       └── system  ============================================= 系统初始化
    │           └── install.sh ====================================== wget git vim screen
    |           ├── zsh&oh-my-zsh.sh ================================ zsh oh-my-zsh
    |── bash.sh ===================================================== 入口
    └── vimrc ======================================================= vim配置
```

## vimrc

```shell
:set nu
:noh
set ignorecase
set shortmess=atI
syntax on
autocmd InsertLeave * se nocul
set ruler
set showcmd
set foldenable
set foldmethod=manual
set autowrite
set cursorline
set confirm
set autoindent
set cindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
set smarttab
set hlsearch
set incsearch
set enc=utf-8
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
set langmenu=zh_CN.UTF-8
set showmatch
set smartindent
```

### 使用方式

#### Method 1.

```shell
cat vimrc > ~/.vimrc
```

#### Method 2.

```shell
./base.sh
```

