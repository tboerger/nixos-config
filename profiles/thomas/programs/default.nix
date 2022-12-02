{ pkgs, lib, config, options, ... }:

{
  imports = [
    ./alacritty.nix
    ./autorandr.nix
    ./dircolors.nix
    ./git.nix
    ./hacking.nix
    ./kustomize.nix
    ./minio.nix
    ./ssh.nix
    ./starship.nix
    ./vscode.nix
    ./zsh.nix
  ];
}
