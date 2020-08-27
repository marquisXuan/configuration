# 基于 Docker 的安装脚本



## 目录树

```txt
docker
            ├── README.md
            ├── docker-mysql.sh
            ├── docker-nginx.sh
            ├── docker-spring-boot.sh
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

## docker-spring-boot.sh

> 基于 Docker 的 SpringBoot 容器
>
> 日志路径可设置为 **/var/logs/java** 下，容器与宿主机已做好映射

### 使用方式

此脚本接收三个参数

#### 正常命令

```shell
java -jar -Dspring.profiles.active=环境 路径A/a.jar
```

#### 脚本命令

```shell
./docker-spring-boot.sh 路径A/a.jar 容器名称 环境名称
# ex:
./docker-spring-boot.sh /srv/docker/java/demo/a-demo-jar.jar a-demo test
# 则会启动一个名叫 a-demo 的容器
```

