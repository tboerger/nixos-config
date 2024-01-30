# nixos-config

[![Build](https://github.com/tboerger/nixos-config/actions/workflows/build.yml/badge.svg)](https://github.com/tboerger/nixos-config/actions/workflows/build.yml)

Provisioning for my NixOS systems based on [Nix][nix].

## Prepare

Copy `/etc/ssh/ssh_host_ed25519_key.pub` into [secrets](./secrets/secrets.nix)
and rekey the secrets via [agenix][agenix]. After pushing the rekeyed secrets
execute the commands below.

## Desktops

Generally after the installation I'm cloning this repository somewhere onto the
desktop machine and just execute `make switch` within that repository to apply
updates, if this is not the case I can always execute the following command to
get the latest changes pulled in:

```console
nixos-rebuild switch --flake github:tboerger/nixos-config#hostname
```

### Anubis

```console
sudo loadkeys de
sudo nix-shell --packages nixUnstable

nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko --flake github:tboerger/nixos-config#anubis

mkdir -p /mnt/etc/ssh
cp /etc/ssh/ssh_host_* /mnt/etc/ssh/
nixos-install --no-root-password --root /mnt --flake github:tboerger/nixos-config#anubis
```

### Chnum

```console
sudo loadkeys de
sudo nix-shell --packages nixUnstable

nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko --flake github:tboerger/nixos-config#chnum

mkdir -p /mnt/etc/ssh
cp /etc/ssh/ssh_host_* /mnt/etc/ssh/
nixos-install --no-root-password --root /mnt --flake github:tboerger/nixos-config#chnum
```

## Servers

To apply updates for servers this repository should be updated to the latest
version, after that it is possible to use `deploy-rs` to upgrade the deployment
with a command like this:

```console
nix run github:serokell/deploy-rs github:tboerger/nixos-config#hostname
```

### Asgard

```console
sudo loadkeys de
sudo nix-shell --packages nixUnstable

nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko --flake github:tboerger/nixos-config#asgard

mkdir -p /mnt/etc/ssh
cp /etc/ssh/ssh_host_* /mnt/etc/ssh/
nixos-install --no-root-password --root /mnt --flake github:tboerger/nixos-config#asgard
```

### Utgard

```console
sudo loadkeys de
sudo nix-shell --packages nixUnstable

nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko --flake github:tboerger/nixos-config#utgard

mkdir -p /mnt/etc/ssh
cp /etc/ssh/ssh_host_* /mnt/etc/ssh/
nixos-install --no-root-password --root /mnt --flake github:tboerger/nixos-config#utgard
```

### Vanaheim

```console
sudo loadkeys de
sudo nix-shell --packages nixUnstable

nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko --flake github:tboerger/nixos-config#vanaheim

mkdir -p /mnt/etc/ssh
cp /etc/ssh/ssh_host_* /mnt/etc/ssh/
nixos-install --no-root-password --root /mnt --flake github:tboerger/nixos-config#vanaheim
```

### Yggdrasil

```console
sudo loadkeys de
sudo nix-shell --packages nixUnstable

mount /dev/disk/by-label/NIXOS_SD /mnt

mkdir -p /mnt/etc/ssh
cp /etc/ssh/ssh_host_* /mnt/etc/ssh/
nixos-install --no-root-password --root /mnt --flake github:tboerger/nixos-config#yggdrasil
```

## Finish

Finally after I have setup the whole system I usually copy the remaining
credentials from my securely stored USB stick to get access to my SSH keys and
Gnupg keys if this is required on the machine. It should not be required for
servers.

### SSH

```console
mkdir -p ${HOME}/.ssh/
cp /media/$(whoami)/secrets/ssh/id_* ${HOME}/.ssh/
chown -R $(id -u):$(id -g) ${HOME}/.ssh
chmod u=rw,g=,o= ${HOME}/.ssh/id_*
```

### Gnupg

```console
for FILE in /media/$(whoami)/secrets/gpg/*.asc; do
    gpg --import ${FILE}
done
```

## Security

If you find a security issue please contact thomas@webhippie.de first.

## Contributing

Fork -> Patch -> Push -> Pull Request

## Authors

-   [Thomas Boerger](https://github.com/tboerger)

## License

Apache-2.0

## Copyright

```console
Copyright (c) 2021 Thomas Boerger <thomas@webhippie.de>
```

[nix]: https://nixos.org/manual/nix/stable/
[agenix]: https://github.com/ryantm/agenix
