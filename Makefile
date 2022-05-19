SHELL := bash

.PHONY: update
update:
	nix --extra-experimental-features "nix-command flakes" flake update

.PHONY: switch
switch:
	sudo NIXPKGS_ALLOW_UNFREE=1 nixos-rebuild switch --impure --flake .
