#!/bin/bash

groupDocker=$(cat /etc/group | grep docker | wc -l | awk '{print $0}')
num=0

echo $groupDocker
echo $num

if test "$groupDocker" -eq 0 ; then
  echo "相等"
  else
  echo "不相等"
  fi