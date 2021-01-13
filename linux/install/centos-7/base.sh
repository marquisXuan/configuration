#!/bin/bash

./system/install.sh
./docker/docker.sh
./docker/docker-nginx.sh
./docker/docker-mysql.sh
./docker/docker-spring-boot.sh
./system/zsh/oh-my-zsh.sh
