#!/bin/sh
# ================================================================================
# Purpose: Identify target system
#
# Usage:
#     curl <raw_url> | sh -x &>identify.txt
# ================================================================================

id
whoami
w
who

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

systemctl --version
ps axfw
netstat -nta

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