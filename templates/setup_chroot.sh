#!/bin/bash

export CHROOT_PATH=/opt/mychroot

echo $CHROOT_PATH > /root/hej.txt
echo $(ldd /usr/bin/bash | awk '{print $3}'|grep "^/") >> /root/hej.txt
echo $(ls /root) >> /root/hej.txt

