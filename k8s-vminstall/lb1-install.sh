#!/bin/bash

HOSTNAME=lb1
# to generate MAC use command :
#
# MACADDR="52:54:00:$(dd if=/dev/urandom bs=512 count=1 2>/dev/null | md5sum | sed 's/^\(..\)\(..\)\(..\).*$/\1:\2:\3/')"; echo $MACADDR
#
MACI=52:54:00:8a:c9:3e
MACE=52:54:00:71:6f:5d
DISKSIZE=50

virt-install -n k33-${HOSTNAME} \
  --vcpus=2 --cpu host --check-cpu \
  --ram 2048 --arch=x86_64 \
  --network network=internal33,model=virtio,mac=${MACI} \
  --network network=external,model=virtio,mac=${MACE} \
  --os-type linux --os-variant=centos-stream8 \
  --disk path=../images/k33-${HOSTNAME}.qcow2,bus=virtio,size=${DISKSIZE} \
  --boot hd,menu=on \
  --location ../iso/CentOS-Stream-8-x86_64-latest-dvd1.iso \
  --initrd-inject ${HOSTNAME}-ks.cfg \
  --extra-args "console=ttyS0 xive=off inst.text inst.ks=file:/${HOSTNAME}-ks.cfg ifname=enp1s0:${MACI} ifname=enp2s0:${MACE}" \
  --controller type=scsi,model=virtio-scsi --serial pty \
  --nographics --console pty,target_type=virtio

