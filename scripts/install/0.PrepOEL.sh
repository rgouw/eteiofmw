#!/bin/bash
echo Installing packages required by the software
yum -q -y install compat-libcap1* compat-libstdc* libstdc* gcc-c++* ksh libaio-devel* dos2unix

echo Partitioning the newly added Binaries disk /dev/sdb
(
echo o # Create a new empty DOS partition table
echo n # Add a new partition
echo p # Primary partition
echo 1 # Partition number
echo   # First sector (Accept default: 1)
echo   # Last sector (Accept default: varies)
echo w # Write changes
) | fdisk /dev/sdb


echo Partitioning the newly added Installables disk /dev/sdc
(
echo o # Create a new empty DOS partition table
echo n # Add a new partition
echo p # Primary partition
echo 1 # Partition number
echo   # First sector (Accept default: 1)
echo   # Last sector (Accept default: varies)
echo w # Write changes
) | fdisk /dev/sdc

echo Formatting Binaries disk
mkfs.ext4 /dev/sdb1

echo Formatting Installables disk
mkfs.ext4 /dev/sdc1

echo Creating /app and mounting.
mkdir -p /app
mount /dev/sdb1 /app

echo Creating /Extracted/stage and mounting.
mkdir -p /Extracted/stage
mount /dev/sdc1 /Extracted/stage
chmod +r+x -R /Extracted

echo Creating /scripts and mount VB share
mkdir -p /scripts
mount -t vboxsf scripts /scripts
chmod +r+x -R /scripts

echo Adding the mount to /etc/fstab to mount these at startup
cp /etc/fstab /etc/fstab.org
echo /dev/sdb1               /app              ext4    defaults        1 2 >> /etc/fstab
echo /dev/sdc1               /Extracted/stage  ext4    defaults        1 2 >> /etc/fstab
echo mount -t vboxsf scripts /scripts >> /etc/rc.local
chmod +x /etc/rc.d/rc.local
