#!/bin/bash


for i in master{1..3} worker{1..2}
do
  echo -ne "${i}  \t" ; virsh dumpxml k33-${i} | grep "mac address" | cut -d\' -f2
done

