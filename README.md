# nixos-config

[![Build](https://github.com/tboerger/nixos-config/actions/workflows/build.yml/badge.svg)](https://github.com/tboerger/nixos-config/actions/workflows/build.yml)

Provisioning for my NixOS systems based on [Nix][nix].

## Prepare

Copy `/etc/ssh/ssh_host_ed25519_key.pub` into [secrets](./secrets/secrets.nix)
and rekey the secrets via [agenix][agenix], you could also just execute
`ssh-keyscan ip_or_fqdn` to fetch the current public keys. After pushing the
rekeyed secrets execute the commands below.

## Asgard

### Bootstrap

```console
sudo loadkeys de
sudo nix-shell --packages nixUnstable

nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko --flake github:tboerger/nixos-config#asgard

mkdir -p /mnt/etc/ssh
cp /etc/ssh/ssh_host_* /mnt/etc/ssh/
nixos-install --no-root-password --root /mnt --flake github:tboerger/nixos-config#asgard
```

### Updates

```console
nix run github:serokell/deploy-rs github:tboerger/nixos-config#asgard
```

## Utgard

### Bootstrap

```console
sudo loadkeys de
sudo nix-shell --packages nixUnstable

nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko --flake github:tboerger/nixos-config#utgard

mkdir -p /mnt/etc/ssh
cp /etc/ssh/ssh_host_* /mnt/etc/ssh/
nixos-install --no-root-password --root /mnt --flake github:tboerger/nixos-config#utgard
```

### Updates

```console
nix run github:serokell/deploy-rs github:tboerger/nixos-config#utgard
```

## Vanaheim

### Bootstrap

```console
sudo loadkeys de
sudo nix-shell --packages nixUnstable

nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko --flake github:tboerger/nixos-config#vanaheim

mkdir -p /mnt/etc/ssh
cp /etc/ssh/ssh_host_* /mnt/etc/ssh/
nixos-install --no-root-password --root /mnt --flake github:tboerger/nixos-config#vanaheim
```

### Updates

```console
nix run github:serokell/deploy-rs github:tboerger/nixos-config#vanaheim
```

## Yggdrasil

### Bootstrap

```console
sudo loadkeys de
sudo nix-shell --packages nixUnstable

mount /dev/disk/by-label/NIXOS_SD /mnt

mkdir -p /mnt/etc/ssh
cp /etc/ssh/ssh_host_* /mnt/etc/ssh/
nixos-install --no-root-password --root /mnt --flake github:tboerger/nixos-config#yggdrasil
```

### Updates

```console
nix run github:serokell/deploy-rs github:tboerger/nixos-config#yggdrasil
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
