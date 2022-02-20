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

## Prepare

## Asgard

### Bootstrap

```console
sudo nix-shell --packages nixUnstable

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
sudo nix-shell --packages nixUnstable

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
