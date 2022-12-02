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
updates, if this is not the case I can always execute
`nixos-rebuild switch --flake github:tboerger/nixos-config#name` to get the
latest changes pulled in.

### Anubis

```console
sudo loadkeys de
sudo nix-shell --packages nixUnstable

bash -c "$(curl -fsSL https://raw.githubusercontent.com/tboerger/nixos-config/master/desktops/anubis/partitions.sh)"

mkdir -p /mnt/etc/ssh
cp /etc/ssh/ssh_host_* /mnt/etc/ssh/
nixos-install --no-root-password --root /mnt --flake github:tboerger/nixos-config#anubis
```

### Chnum

```console
sudo loadkeys de
sudo nix-shell --packages nixUnstable

bash -c "$(curl -fsSL https://raw.githubusercontent.com/tboerger/nixos-config/master/desktops/chnum/partitions.sh)"

mkdir -p /mnt/etc/ssh
cp /etc/ssh/ssh_host_* /mnt/etc/ssh/
nixos-install --no-root-password --root /mnt --flake github:tboerger/nixos-config#chnum
```

### Osiris

```console
sudo loadkeys de
sudo nix-shell --packages nixUnstable

bash -c "$(curl -fsSL https://raw.githubusercontent.com/tboerger/nixos-config/master/desktops/osiris/partitions.sh)"

mkdir -p /mnt/etc/ssh
cp /etc/ssh/ssh_host_* /mnt/etc/ssh/
nixos-install --no-root-password --root /mnt --flake github:tboerger/nixos-config#osiris
```

## Servers

Currently I'm applying the updates manually by cloning the repository into the
machine and executing `make switch`, but on longterm it should also just work to
use the `deploy #name` command, at least if it's executed from a NixOS desktop.

### Asgard

```console
sudo loadkeys de
sudo nix-shell --packages nixUnstable

bash -c "$(curl -fsSL https://raw.githubusercontent.com/tboerger/nixos-config/master/servers/asgard/partitions.sh)"

mkdir -p /mnt/etc/ssh
cp /etc/ssh/ssh_host_* /mnt/etc/ssh/
nixos-install --no-root-password --root /mnt --flake github:tboerger/nixos-config#asgard
```

### Utgard

```console
sudo loadkeys de
sudo nix-shell --packages nixUnstable

bash -c "$(curl -fsSL https://raw.githubusercontent.com/tboerger/nixos-config/master/servers/utgard/partitions.sh)"

mkdir -p /mnt/etc/ssh
cp /etc/ssh/ssh_host_* /mnt/etc/ssh/
nixos-install --no-root-password --root /mnt --flake github:tboerger/nixos-config#utgard
```

### Midgard

```console
sudo loadkeys de
sudo nix-shell --packages nixUnstable

mount /dev/disk/by-label/NIXOS_SD /mnt

mkdir -p /mnt/etc/ssh
cp /etc/ssh/ssh_host_* /mnt/etc/ssh/
nixos-install --no-root-password --root /mnt --flake github:tboerger/nixos-config#midgard
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
