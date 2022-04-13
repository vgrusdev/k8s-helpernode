#!/bin/bash

HOSTNAME=helper2
# to generate MAC use command :
#
# MACADDR="52:54:00:$(dd if=/dev/urandom bs=512 count=1 2>/dev/null | md5sum | sed 's/^\(..\)\(..\)\(..\).*$/\1:\2:\3/')"; echo $MACADDR
#
MACI=52:54:00:5c:80:5b
MACE=52:54:00:70:69:37
DISKSIZE=50

virt-install -n k8s-${HOSTNAME} \
  --vcpus=2 --cpu host --check-cpu \
  --ram 2048 --arch=x86_64 \
  --network network=internal,model=virtio,mac=${MACI} \
  --network network=external,model=virtio,mac=${MACE} \
  --os-type linux --os-variant=centos8 \
  --disk path=/virt/images/k8s-${HOSTNAME}.qcow2,bus=virtio,size=${DISKSIZE} \
  --boot hd,menu=on \
  --location /virt/iso/CentOS-Stream-8-x86_64-latest-dvd1.iso \
  --initrd-inject ${HOSTNAME}-ks.cfg \
  --extra-args "console=ttyS0 xive=off inst.text inst.ks=file:/${HOSTNAME}-ks.cfg ifname=enp1s0:${MACI} ifname=enp2s0:${MACE}" \
  --controller type=scsi,model=virtio-scsi --serial pty \
  --nographics --console pty,target_type=virtio

