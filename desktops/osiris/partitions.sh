#!/usr/bin/env bash
set -eo pipefail

if [ "${EUID}" -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi

while true; do
    read -p "Are you sure you want to wipe all partitions? " awnser

    case ${awnser} in
        [Yy]*)
            break
            ;;
        [Nn]*)
            exit
            ;;
        *)
            echo "Please answer yes or no!"
            ;;
    esac
done

echo "----> Remove previous VGs"
vgchange -an

for VG in $(vgs --noheadings 2>/dev/null | sed -e 's/^[[:space:]]*//' | cut -d" " -f 1); do
    vgremove -y ${VG} 2>/dev/null
done

echo "----> Remove previous PVs"
for PV in $(pvs --noheadings 2>/dev/null | sed -e 's/^[[:space:]]*//' | cut -d" " -f 1); do
    pvremove -y ${PV} 2>/dev/null
done

echo "----> Drop existing partitions"
for DISK in pci-0000:00:1f.2-ata-1.0; do
    sgdisk --zap-all /dev/disk/by-path/${DISK}
    sgdisk -og /dev/disk/by-path/${DISK}
done

echo "-----> Wait for cleanup"
sleep 3
sync

echo "-----> Create sda partitions"
parted -a opt --script /dev/disk/by-path/pci-0000:00:14.1-ata-1 \
    mklabel gpt \
    mkpart primary fat32 0% 1GB \
    set 1 esp on \
    name 1 boot \
    mkpart primary 1GB 100% \
    set 2 lvm on \
    name 2 system

echo "-----> Reload partition table"
partprobe

echo "-----> Wait for partitions"
sleep 3
sync

echo "-----> Create data pv"
pvcreate /dev/disk/by-partlabel/system

echo "-----> Create data vg"
vgcreate system /dev/disk/by-partlabel/system

echo "-----> Create swap volume"
lvcreate -y --size $(cat /proc/meminfo | grep MemTotal | cut -d':' -f2 | sed 's/ //g') --name swap system

echo "-----> Create root volume"
lvcreate -y --size 20G --name root system

echo "-----> Create nix volume"
lvcreate -y --size 50G --name nix system

echo "-----> Create home volume"
lvcreate -y --size 50G --name home system

echo "-----> Enable swap partition"
mkswap -L swap /dev/system/swap
swapon /dev/system/swap

echo "-----> Create root filesystem"
mkfs.ext4 -L root /dev/system/root

echo "-----> Mount root filesystem"
mkdir -p /mnt
mount -t ext4 /dev/system/root /mnt

echo "-----> Create nix filesystem"
mkfs.ext4 -L nix /dev/system/nix

echo "-----> Mount nix filesystem"
mkdir -p /mnt/nix
mount -t ext4 /dev/system/nix /mnt/nix

echo "-----> Create home filesystem"
mkfs.ext4 -L home /dev/system/home

echo "-----> Mount home filesystem"
mkdir -p /mnt/home
mount -t ext4 /dev/system/home /mnt/home

echo "-----> Create boot filesystem"
mkfs.vfat -F32 -n boot /dev/disk/by-partlabel/boot

echo "-----> Mount boot filesystem"
mkdir -p /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot
