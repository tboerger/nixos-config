{ pkgs, lib, config, options, ... }:

{
  imports = [
    ./autorandr.nix
    ./dircolors.nix
    ./ghtoken.nix
    ./git.nix
    ./hacking.nix
    ./kustomize.nix
    ./minio.nix
    ./netrc.nix
    ./ssh.nix
    ./starship.nix
    ./vscode.nix
    ./zsh.nix
  ];
}
