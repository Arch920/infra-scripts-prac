#!/bin/bash

set -e  # Exit on error, removed -x for cleaner logs

# Log all output
exec > >(tee -a /var/log/volume-setup.log) 2>&1

echo "Starting volume setup for device: ${DEVICE}"

# Activate volume groups
vgchange -ay

DEVICE_FS=`blkid -o value -s TYPE ${DEVICE} 2>/dev/null || echo ""`
if [ "`echo -n $DEVICE_FS`" == "" ] ; then 
  echo "Device ${DEVICE} not formatted, proceeding with setup..."
  
  # wait for the device to be attached
  DEVICENAME=`echo "${DEVICE}" | awk -F '/' '{print $3}'`
  DEVICEEXISTS=''
  while [[ -z $DEVICEEXISTS ]]; do
    echo "Checking for device $DEVICENAME"
    DEVICEEXISTS=`lsblk |grep "$DEVICENAME" |wc -l`
    if [[ $DEVICEEXISTS != "1" ]]; then
      echo "Device not found, waiting 15 seconds..."
      sleep 15
    fi
  done
  
  # make sure the device file in /dev/ exists
  count=0
  until [[ -e ${DEVICE} || "$count" == "60" ]]; do
   echo "Waiting for device file ${DEVICE} to appear..."
   sleep 5
   count=$(expr $count + 1)
  done
  
  if [[ ! -e ${DEVICE} ]]; then
    echo "ERROR: Device ${DEVICE} not found after 5 minutes"
    exit 1
  fi
  
  echo "Creating LVM setup..."
  pvcreate ${DEVICE}
  vgcreate data ${DEVICE}
  lvcreate --name volume1 -l 100%FREE data
  mkfs.ext4 /dev/data/volume1
  
  echo "LVM setup completed successfully"
else
  echo "Device ${DEVICE} already formatted with $DEVICE_FS"
fi

# Create mount point and add to fstab
mkdir -p /data

# Check if already in fstab
if ! grep -q "/dev/data/volume1" /etc/fstab; then
  echo '/dev/data/volume1 /data ext4 defaults 0 0' >> /etc/fstab
  echo "Added to /etc/fstab"
fi

# Mount the volume
if ! mountpoint -q /data; then
  mount /data
  echo "Volume mounted at /data"
else
  echo "Volume already mounted at /data"
fi

echo "Volume setup completed successfully"
