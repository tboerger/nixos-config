{ pkgs, lib, config, options, ... }:

{
  imports = [
    ./clockify.nix
    ./develop.nix
    ./direnv.nix
    ./feh.nix
    ./fzf.nix
    ./gnupg.nix
    ./golang.nix
    ./kube.nix
    ./lens.nix
    ./lsd.nix
    ./minecraft.nix
    ./neovim.nix
    ./readline.nix
    ./tmux.nix
    ./zathura.nix
  ];

  options = with lib; {
    profile = {
      programs = { };
    };
  };
}
