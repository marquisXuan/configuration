# 基于 Docker 的安装脚本



## 目录树

```txt
docker
            ├── README.md
            ├── docker-mysql.sh
            ├── docker-nginx.sh
            └── docker.sh
```

## docker.sh

> 创建了一个默认网桥，nginx-network 

## docker-nginx.sh

> 基于 docker 的 nginx 安装脚本
>
> 默认安装在**/srv/docker/nginx**目录下

### 开放端口

- 80

- 443

## docker-mysql.sh

> 基于 docker 的 mysql 安装脚本
>
> 默认安装在**/srv/docker/mysql**目录下

### 开放端口

- 33060

### 用户名

- root
- Docker-mysql-123456