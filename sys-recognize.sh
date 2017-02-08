#!/bin/sh
#
# Purpose: Recognize target system

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

# EOF