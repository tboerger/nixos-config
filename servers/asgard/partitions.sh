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

echo "----> Remove previous MDs"
mdadm --stop --scan || true
mkdir -p /etc/mdadm

echo 'AUTO -all
ARRAY <ignore> UUID=00000000:00000000:00000000:00000000' > /etc/mdadm/mdadm.conf

echo "----> Drop existing partitions"
for DISK in pci-0000:00:14.1-ata-1 pci-0000:00:11.0-ata-1.0 pci-0000:00:11.0-ata-2.0 pci-0000:00:11.0-ata-3.0 pci-0000:00:11.0-ata-4.0; do
    sgdisk --zap-all /dev/disk/by-path/${DISK}
    sgdisk -og /dev/disk/by-path/${DISK}
done

echo "-----> Wait for cleanup"
sleep 3
sync

echo "-----> Create sda partitions"
parted -a opt --script /dev/disk/by-path/pci-0000:00:14.1-ata-1 \
    mklabel gpt \
    mkpart primary 1MB 1GB \
    set 1 bios_grub on \
    name 1 boot \
    mkpart primary 1GB 100% \
    set 2 lvm on \
    name 2 system

echo "-----> Create sdb partitions"
parted -a opt --script /dev/disk/by-path/pci-0000:00:11.0-ata-1 \
    mklabel gpt \
    mkpart primary 1GB 100% \
    set 1 lvm on \
    name 1 tank1

echo "-----> Create sdc partitions"
parted -a opt --script /dev/disk/by-path/pci-0000:00:11.0-ata-2 \
    mklabel gpt \
    mkpart primary 1GB 100% \
    set 1 lvm on \
    name 1 tank2

echo "-----> Create sdd partitions"
parted -a opt --script /dev/disk/by-path/pci-0000:00:11.0-ata-3 \
    mklabel gpt \
    mkpart primary 1GB 100% \
    set 1 lvm on \
    name 1 tank3

echo "-----> Create sde partitions"
parted -a opt --script /dev/disk/by-path/pci-0000:00:11.0-ata-4 \
    mklabel gpt \
    mkpart primary 1GB 100% \
    set 1 lvm on \
    name 1 tank4

echo "-----> Reload partition table"
partprobe

echo "-----> Wait for partitions"
sleep 3
sync

echo "-----> Create raid0 volume"
echo yes | mdadm --create /dev/md0 --level=10 --raid-devices=4 --homehost=asgard --name=md0 /dev/disk/by-partlabel/tank1 /dev/disk/by-partlabel/tank2 /dev/disk/by-partlabel/tank3 /dev/disk/by-partlabel/tank4
wipefs -a /dev/md0
echo 0 > /proc/sys/dev/raid/speed_limit_max

echo "-----> Wait for raids"
sleep 3
sync

echo "-----> Create data pv"
pvcreate /dev/disk/by-partlabel/system

echo "-----> Create data vg"
vgcreate system /dev/disk/by-partlabel/system

echo "-----> Create tank pv"
pvcreate /dev/md0

echo "-----> Create tank vg"
vgcreate tank /dev/md0

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
mkfs.ext4 -L boot /dev/disk/by-partlabel/boot1

echo "-----> Mount boot filesystem"
mkdir -p /mnt/boot
mount /dev/disk/by-partlabel/boot1 /mnt/boot

#
# STORAGE
#

for PARTITION in ; do
    echo "-----> Create ${PARTITION} volume"
    lvcreate -y --size 5G --name ${PARTITION} system

    echo "-----> Create ${PARTITION} filesystem"
    mkfs.ext4 -L ${PARTITION} /dev/system/${PARTITION}

    echo "-----> Mount ${PARTITION} filesystem"
    mkdir /mnt/var/lib/${PARTITION}
    mount -t ext4 /dev/system/${PARTITION} /mnt/var/lib/${PARTITION}
done

echo "-----> Create shares volume"
lvcreate -y --size 10G --name shares tank

echo "-----> Create shares filesystem"
mkfs.ext4 -L shares /dev/tank/shares

echo "-----> Mount shares filesystem"
mkdir -p /mnt/var/lib/shares
mount -t ext4 /dev/tank/shares /mnt/var/lib/shares

echo "-----> Create photos volume"
lvcreate -y --size 100G --name photos tank

echo "-----> Create photos filesystem"
mkfs.ext4 -L photos /dev/tank/photos

echo "-----> Mount photos filesystem"
mkdir -p /mnt/var/lib/photos
mount -t ext4 /dev/tank/photos /mnt/var/lib/photos

echo "-----> Create videos volume"
lvcreate -y --size 100G --name videos tank

echo "-----> Create videos filesystem"
mkfs.ext4 -L videos /dev/tank/videos

echo "-----> Mount videos filesystem"
mkdir -p /mnt/var/lib/videos
mount -t ext4 /dev/tank/videos /mnt/var/lib/videos

echo "-----> Create printer volume"
lvcreate -y --size 10G --name printer tank

echo "-----> Create printer filesystem"
mkfs.ext4 -L printer /dev/tank/printer

echo "-----> Mount printer filesystem"
mkdir -p /mnt/var/lib/printer
mount -t ext4 /dev/tank/printer /mnt/var/lib/printer

echo "-----> Create backup volume"
lvcreate -y --size 1000G --name backup tank

echo "-----> Create backup filesystem"
mkfs.ext4 -L backup /dev/tank/backup

echo "-----> Mount backup filesystem"
mkdir -p /mnt/var/lib/backup
mount -t ext4 /dev/tank/backup /mnt/var/lib/backup
