#!/bin/sh
#
# Purpose: Identify target system

set -x

id
cat /proc/version # || die "ERROR: /proc filesystem not mounted"
cat /proc/cmdline

cat /proc/mounts
df -h

ifconfig
ip address
ip route
iwconfig

lsusb

which curl
which wget

# SCRIPT="TODO"
# [ "${SCRIPT}" != "" ]

ls -la /etc/passwd && cat /etc/passwd
ls -la /etc/shadow && cat /etc/shadow
ls -la /etc/group  && cat /etc/group

# EOF