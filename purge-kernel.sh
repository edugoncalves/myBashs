#!/usr/bin/env bash


dpkg --list | grep linux-image | awk '{print "status=" $1 "|kernel="  $2}' > kernel.list 
statusPattern="status=rc" 

while IFS= read -r line; do
 
  if    echo $line | grep -q $statusPattern; then
         kernel=$( echo "${line/status=rc|kernel=/""}" ) 
        sudo apt-get -y purge $kernel
  fi

done < kernel.list
