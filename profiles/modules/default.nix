{ pkgs, lib, config, options, ... }:

{
  imports = [
    ./settings.nix

    ./dircolors.nix
    ./lsd.nix
    ./neovim.nix
    ./readline.nix
    ./starship.nix
    ./zsh.nix
  ];

  my = {
    modules = {
      dircolors = {
        enable = lib.mkDefault true;
      };

      lsd = {
        enable = lib.mkDefault true;
      };

      neovim = {
        enable = lib.mkDefault true;
      };

      readline = {
        enable = lib.mkDefault true;
      };

      starship = {
        enable = lib.mkDefault true;
      };

      zsh = {
        enable = lib.mkDefault true;
      };
    };
  };
}
