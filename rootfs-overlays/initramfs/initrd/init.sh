#!/bin/busybox sh
set -xe

mount -t devtmpfs none /dev
mount -t proc none /proc
mount -t sysfs none /sys

# Install all the busybox sym links
/bin/busybox --install

mount -t ext4 /dev/sda /mnt/ || /bin/busybox ash

# If it works then go ahead and try to enter the new root
mkdir -p /mnt/proc
mkdir -p /mnt/sys
mkdir -p /mnt/dev
mount -t proc none /mnt/proc
mount -t sysfs none /mnt/sys
mount -t devtmpfs none /mnt/dev

export PYTHONPATH=/usr/lib64/python2.7/site-packages

chroot /mnt /init

sync
halt -f
