# nixos-config

[![Build](https://github.com/tboerger/nixos-config/actions/workflows/build.yml/badge.svg)](https://github.com/tboerger/nixos-config/actions/workflows/build.yml)

Provisioning for my NixOS systems based on [Nix][nix].

## Secrets

Generally all secrets are encrypted with [agenix][agenix], so make sure to copy
the SSH keys from the `secrets` stick with these commands:

```console
mkdir -p $HOME/.ssh
cp /mnt/secrets/ssh/id_* $HOME/.ssh/
chmod u=rw,g=,o= $HOME/.ssh/id_*
```

## Chnum

### Bootstrap

Copy `/etc/ssh/ssh_host_ed25519_key.pub` into [secrets](./secrets/secrets.nix)
and rekey the secrets via [agenix][agenix]. After pushing the regkeyed secrets
execute these commands:

```console
sudo loadkeys de
sudo nix-shell --packages nixUnstable

mkdir ~/.ssh
cp /mnt/secrets/ssh/id_ed25519* ~/.ssh
chmod u=rw,g=,o= ~/.ssh/id_*

bash -c "$(curl -fsSL https://raw.githubusercontent.com/tboerger/nixos-config/master/scripts/chnum-partitions)"
nixos-install --root /mnt --flake github:tboerger/nixos-config#chnum
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

```console
sudo loadkeys de
sudo nix-shell --packages nixUnstable

mkdir ~/.ssh
cp /mnt/secrets/ssh/id_ed25519* ~/.ssh
chmod u=rw,g=,o= ~/.ssh/id_*

bash -c "$(curl -fsSL https://raw.githubusercontent.com/tboerger/nixos-config/master/scripts/asgard-partitions)"
nixos-install --root /mnt --flake github:tboerger/nixos-config#asgard
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

```console
sudo loadkeys de
sudo nix-shell --packages nixUnstable

mkdir ~/.ssh
cp /mnt/secrets/ssh/id_ed25519* ~/.ssh
chmod u=rw,g=,o= ~/.ssh/id_*

bash -c "$(curl -fsSL https://raw.githubusercontent.com/tboerger/nixos-config/master/scripts/utgard-partitions)"
nixos-install --root /mnt --flake github:tboerger/nixos-config#utgard
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

```console
sudo loadkeys de
sudo nix-shell --packages nixUnstable

mkdir ~/.ssh
cp /mnt/secrets/ssh/id_ed25519* ~/.ssh
chmod u=rw,g=,o= ~/.ssh/id_*

mount /dev/disk/by-label/NIXOS_SD /mnt
nixos-install --root /mnt --flake github:tboerger/nixos-config#midgard
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
