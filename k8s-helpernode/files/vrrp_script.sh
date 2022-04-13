#!/bin/bash

# /bin/kill -0 `cat /run/haproxy.pid`
# echo abc

/usr/bin/pidof $1
ret=$?

# echo $(date "+%Y-%m-%d %T") returning $ret >>/tmp/pidof_$1.log

exit $ret

