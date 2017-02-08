#!/bin/sh
#
# Purpose: Identify target system

set -x

id
cat /proc/version # || die "ERROR: /proc filesystem not mounted"
cat /proc/cmdline

cat /proc/cpuinfo
cat /proc/meminfo
cat /proc/uptime

cat /proc/mounts
cat /proc/mtd
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

# SCRIPT="TODO"
# [ "${SCRIPT}" != "" ]

# EOF