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
for DISK in pci-0000:00:1f.2-ata-3.0 pci-0000:00:1f.2-ata-4.0 pci-0000:00:1f.2-ata-5.0 pci-0000:00:1f.2-ata-6.0; do
    sgdisk --zap-all /dev/disk/by-path/${DISK}
    sgdisk -og /dev/disk/by-path/${DISK}
done

echo "-----> Wait for cleanup"
sleep 3
sync

echo "-----> Create sda partitions"
parted -a opt --script /dev/disk/by-path/pci-0000:00:1f.2-ata-3.0 \
    mklabel gpt \
    mkpart primary 1MB 1GB \
    set 1 bios_grub on \
    name 1 boot1 \
    mkpart primary 1GB 100% \
    set 2 lvm on \
    name 2 tank1

echo "-----> Create sdb partitions"
parted -a opt --script /dev/disk/by-path/pci-0000:00:1f.2-ata-4.0 \
    mklabel gpt \
    mkpart primary 1MB 1GB \
    set 1 bios_grub on \
    name 1 boot2 \
    mkpart primary 1GB 100% \
    set 2 lvm on \
    name 2 tank2

echo "-----> Create sdc partitions"
parted -a opt --script /dev/disk/by-path/pci-0000:00:1f.2-ata-5.0 \
    mklabel gpt \
    mkpart primary 1MB 1GB \
    set 1 bios_grub on \
    name 1 boot3 \
    mkpart primary 1GB 100% \
    set 2 lvm on \
    name 2 tank3

echo "-----> Create sdd partitions"
parted -a opt --script /dev/disk/by-path/pci-0000:00:1f.2-ata-6.0 \
    mklabel gpt \
    mkpart primary 1MB 1GB \
    set 1 bios_grub on \
    name 1 boot4 \
    mkpart primary 1GB 100% \
    set 2 lvm on \
    name 2 tank4

echo "-----> Reload partition table"
partprobe

echo "-----> Wait for partitions"
sleep 3
sync

echo "-----> Create raid0 volume"
echo yes | mdadm --create /dev/md0 --level=10 --raid-devices=4 --homehost=niflheim --name=md0 /dev/disk/by-partlabel/tank1 /dev/disk/by-partlabel/tank2 /dev/disk/by-partlabel/tank3 /dev/disk/by-partlabel/tank4
wipefs -a /dev/md0
echo 0 > /proc/sys/dev/raid/speed_limit_max

echo "-----> Wait for raids"
sleep 3
sync

echo "-----> Create data pv"
pvcreate /dev/md0

echo "-----> Create data vg"
vgcreate system /dev/md0

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

for PARTITION in acme nextcloud nzbget jellyfin radarr sonarr lidarr readarr bazarr prowlarr; do
    echo "-----> Create ${PARTITION} volume"
    lvcreate -y --size 5G --name ${PARTITION} system

    echo "-----> Create ${PARTITION} filesystem"
    mkfs.ext4 -L ${PARTITION} /dev/system/${PARTITION}

    echo "-----> Mount ${PARTITION} filesystem"
    mkdir /mnt/var/lib/${PARTITION}
    mount -t ext4 /dev/system/${PARTITION} /mnt/var/lib/${PARTITION}
done

echo "-----> Create downloads volume"
lvcreate -y --size 200G --name downloads system

echo "-----> Create downloads filesystem"
mkfs.ext4 -L downloads /dev/system/downloads

echo "-----> Mount downloads filesystem"
mkdir -p /mnt/var/lib/downloads
mount -t ext4 /dev/system/downloads /mnt/var/lib/downloads

echo "-----> Create movies volume"
lvcreate -y --size 2000G --name movies system

echo "-----> Create movies filesystem"
mkfs.ext4 -L movies /dev/system/movies

echo "-----> Mount movies filesystem"
mkdir -p /mnt/var/lib/movies
mount -t ext4 /dev/system/movies /mnt/var/lib/movies

echo "-----> Create shows volume"
lvcreate -y --size 2000G --name shows system

echo "-----> Create shows filesystem"
mkfs.ext4 -L shows /dev/system/shows

echo "-----> Mount shows filesystem"
mkdir -p /mnt/var/lib/shows
mount -t ext4 /dev/system/shows /mnt/var/lib/shows

echo "-----> Create books volume"
lvcreate -y --size 100G --name books system

echo "-----> Create books filesystem"
mkfs.ext4 -L books /dev/system/books

echo "-----> Mount books filesystem"
mkdir -p /mnt/var/lib/books
mount -t ext4 /dev/system/books /mnt/var/lib/books

echo "-----> Create music volume"
lvcreate -y --size 100G --name music system

echo "-----> Create music filesystem"
mkfs.ext4 -L music /dev/system/music

echo "-----> Mount music filesystem"
mkdir -p /mnt/var/lib/music
mount -t ext4 /dev/system/music /mnt/var/lib/music

echo "-----> Create bromance volume"
lvcreate -y --size 10G --name bromance system

echo "-----> Create bromance filesystem"
mkfs.ext4 -L bromance /dev/system/bromance

echo "-----> Mount bromance filesystem"
mkdir -p /mnt/var/lib/bromance
mount -t ext4 /dev/system/bromance /mnt/var/lib/bromance

echo "-----> Create owntech volume"
lvcreate -y --size 10G --name owntech system

echo "-----> Create owntech filesystem"
mkfs.ext4 -L owntech /dev/system/owntech

echo "-----> Mount owntech filesystem"
mkdir -p /mnt/var/lib/owntech
mount -t ext4 /dev/system/owntech /mnt/var/lib/owntech
