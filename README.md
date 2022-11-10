# nixos-config

[![Build](https://github.com/tboerger/nixos-config/actions/workflows/build.yml/badge.svg)](https://github.com/tboerger/nixos-config/actions/workflows/build.yml)

Provisioning for my NixOS systems based on [Nix][nix].

## Chnum

### Bootstrap

Copy `/etc/ssh/ssh_host_ed25519_key.pub` into [secrets](./secrets/secrets.nix)
and rekey the secrets via [agenix][agenix]. After pushing the rekeyed secrets
execute these commands:

```console
sudo loadkeys de
sudo nix-shell --packages nixUnstable

bash -c "$(curl -fsSL https://raw.githubusercontent.com/tboerger/nixos-config/master/scripts/chnum-partitions)"

mkdir -p /mnt/etc/ssh
cp /etc/ssh/ssh_host_* /mnt/etc/ssh/
nixos-install --no-root-password --root /mnt --flake github:tboerger/nixos-config#chnum
```

### Updates

If the repository had been cloned you could just execute `make switch`,
otherwise there is still this long option to update the deployment:

```console
nixos-rebuild switch \
    --flake github:tboerger/nixos-config#chnum
```

## Asgard

### Bootstrap

Copy `/etc/ssh/ssh_host_ed25519_key.pub` into [secrets](./secrets/secrets.nix)
and rekey the secrets via [agenix][agenix]. After pushing the rekeyed secrets
execute these commands:

```console
sudo loadkeys de
sudo nix-shell --packages nixUnstable

bash -c "$(curl -fsSL https://raw.githubusercontent.com/tboerger/nixos-config/master/scripts/asgard-partitions)"

mkdir -p /mnt/etc/ssh
cp /etc/ssh/ssh_host_* /mnt/etc/ssh/
nixos-install --no-root-password --root /mnt --flake github:tboerger/nixos-config#asgard
```

### Updates

If the repository had been cloned you could just execute `make switch`,
otherwise there is still this long option to update the deployment:

```console
nixos-rebuild switch \
    --flake github:tboerger/nixos-config#asgard
```

## Utgard

### Bootstrap

Copy `/etc/ssh/ssh_host_ed25519_key.pub` into [secrets](./secrets/secrets.nix)
and rekey the secrets via [agenix][agenix]. After pushing the rekeyed secrets
execute these commands:

```console
sudo loadkeys de
sudo nix-shell --packages nixUnstable

bash -c "$(curl -fsSL https://raw.githubusercontent.com/tboerger/nixos-config/master/scripts/utgard-partitions)"

mkdir -p /mnt/etc/ssh
cp /etc/ssh/ssh_host_* /mnt/etc/ssh/
nixos-install --no-root-password --root /mnt --flake github:tboerger/nixos-config#utgard
```

### Updates

If the repository had been cloned you could just execute `make switch`,
otherwise there is still this long option to update the deployment:

```console
nixos-rebuild switch \
    --flake github:tboerger/nixos-config#utgard
```

## Midgard

### Bootstrap

Copy `/etc/ssh/ssh_host_ed25519_key.pub` into [secrets](./secrets/secrets.nix)
and rekey the secrets via [agenix][agenix]. After pushing the rekeyed secrets
execute these commands:

```console
sudo loadkeys de
sudo nix-shell --packages nixUnstable

mount /dev/disk/by-label/NIXOS_SD /mnt

mkdir -p /mnt/etc/ssh
cp /etc/ssh/ssh_host_* /mnt/etc/ssh/
nixos-install --no-root-password --root /mnt --flake github:tboerger/nixos-config#midgard
```

### Updates

If the repository had been cloned you could just execute `make switch`,
otherwise there is still this long option to update the deployment:

```console
nixos-rebuild switch \
    --flake github:tboerger/nixos-config#midgard
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
