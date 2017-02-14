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
which id && id
which w && w
which whoami && whoami
which who && who

# Identify storage partitions
cat /proc/mounts
cat /proc/mtd
which fdisk && fdisk -l
which mount && mount
which df && df -h

# List installed kernel modules
which lsmod && lsmod

# Identify password and groups
ls -la /etc/passwd && cat /etc/passwd
ls -la /etc/shadow && cat /etc/shadow
ls -la /etc/group  && cat /etc/group

# Identify distro
cat /etc/issue
cat /etc/os-release

# List USB devices
which lsusb && lsusb

# Identify networking
which ifconfig && ifconfig
which ip && ip address && ip route
which ifconfig && iwconfig

# Identify running services
ps axfw || ps
which systemctl && systemctl --version && systemctl --no-pager
which netstat && netstat -nta

# Check if there are any tools for transferring files
which nc && nc
which curl && curl --version
which scp && scp
which ssh && ssh -V
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
which dpkg && dpkg -l

# Inspect Docker configuration
if which docker; then
    docker --version
    docker version
    docker info
    docker images
    docker ps -a
fi
if which docker-compose; then
    docker-compose --version
fi

# Check GENIVI Persistence
ls -laR /Data
if which persistence_client_library_test; then
    persistence_client_library_test
fi
if which persistence_client_library_dbus_test; then
    echo TODO: persistence_client_library_dbus_test
fi

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