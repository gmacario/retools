#!/bin/sh
# ================================================================================
# Purpose: Identify target system
#
# Usage:
#     curl <raw_url> | sh -x &>identify.txt
#     wget -O- <raw_url> | sh -x &>identify.txt
# ================================================================================

# Identify system
date
hostname

cat /proc/version # || die "ERROR: /proc filesystem not mounted"
cat /proc/cmdline

cat /proc/cpuinfo
cat /proc/meminfo
cat /proc/uptime

# Identify logged users
id
w
whoami
who

# Identify storage partitions
cat /proc/mounts
cat /proc/mtd
fdisk -l
mount
df -h

# List installed kernel modules
lsmod

# Identify password and groups
ls -la /etc/passwd && cat /etc/passwd
ls -la /etc/shadow && cat /etc/shadow
ls -la /etc/group  && cat /etc/group

# List USB devices
lsusb

# Identify networking
ifconfig
ip address
ip route
iwconfig

# Identify distro
cat /etc/issue
cat /etc/os-release

# Identify running services
systemctl --version
ps axfw
netstat -nta

# Check if there are any tools for transferring files
which nc && nc --version
which curl && curl --version
which wget && wget

# Check shells
which sh && sh --version
which bash && bash --version
which mc && mc --version

# Check Python and pip
which python && python --version
which pip && pip --version

# Check NodeJS
which npm && npm --version

# Check Ruby and gem
which ruby && ruby --version
which gem && gem --version

# Inspect package configuration
if which dpkg; then
    dpkg -l
fi

# Inspect Docker configuration
if which docker; then
    docker --version
    docker info
    docker version
    docker images
    docker ps -a
fi
if which docker-compose; then
    docker-compose --version
fi

# Check GENIVI Persistence
ls -laR /Data
which persistence_client_library_test
which persistence_client_library_dbus_test

# Inspect SMACK configuration
if which smackctl; then
    smackctl --version
    smackctl status
    
    ls -la /sys/fs/smackfs
    for f in /sys/fs/smackfs/*; do echo "##### File: $f #####"; cat $f; echo ""; done
    
    ls -laR /etc/smack
    find /etc/smack -type f | while read f; do echo "##### File: $f #####"; cat $f; echo ""; done
fi

# EOF