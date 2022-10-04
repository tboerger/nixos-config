{ pkgs, lib, config, options, ... }:

{
  imports = [
    ./alacritty.nix
    ./autorandr.nix
    ./dircolors.nix
    ./git.nix
    ./rofi.nix
    ./ssh.nix
    ./starship.nix
    ./vscode.nix
    ./zsh.nix
  ];
}
