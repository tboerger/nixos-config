{ pkgs, lib, config, options, ... }:

{
  imports = [
    ./dircolors.nix
    ./lsd.nix
    ./neovim.nix
    ./readline.nix
    ./starship.nix
    ./zsh.nix
  ];

  options = with lib; {
    profile = {
      programs = { };
    };
  };
}
