{ pkgs, lib, config, options, ... }:

{
  imports = [
    ./develop.nix
    ./direnv.nix
    ./fzf.nix
    ./gnupg.nix
    ./golang.nix
    ./kube.nix
    ./lsd.nix
    ./minecraft.nix
    ./neovim.nix
    ./readline.nix
  ];

  options = with lib; {
    profile = {
      programs = { };
    };
  };
}
