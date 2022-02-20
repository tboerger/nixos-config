SHELL := bash

.PHONY: update
update:
	nix --extra-experimental-features "nix-command flakes" flake update

.PHONY: switch
switch:
	nixos-rebuild switch --flake .
