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

# Check if there are any tools for transferring files
which nc
which curl
which wget

# URL="https://gist.githubusercontent.com/gmacario/53f7f82078132c1d12d25d25053a0ad0/raw/41d7a5da798d6e92bf47b1a8104884e9872890ad/sys-identify.sh"
if which curl; then 
    FETCHER=curl
elif which wget; then
    FETCHER="wget -O-"
elif which nc; then
    echo TODO: Use netcat as a poor-man fetcher
fi
[ "${FETCHER}" != "" ] && [ "${URL}" != "" ] && ${FETCHER} ${URL} | sh

# Identify running services
systemctl --version
ps axfw
netstat -nta

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

# EOF