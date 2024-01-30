{ pkgs, lib, config, options, ... }:

{
  imports = [
    ./act.nix
    ./authy.nix
    ./banking.nix
    ./clouds.nix
    ./develop.nix
    ./dircolors.nix
    ./direnv.nix
    ./fzf.nix
    ./gnupg.nix
    ./golang.nix
    ./gomplate.nix
    ./helm.nix
    ./joplin.nix
    ./jq.nix
    ./jsonnet.nix
    ./kubectl.nix
    ./kustomize.nix
    ./latex.nix
    ./lens.nix
    ./lsd.nix
    ./messages.nix
    ./minecraft.nix
    ./neovim.nix
    ./network.nix
    ./ngrok.nix
    ./nodejs.nix
    ./office.nix
    ./readline.nix
    ./shortwave.nix
    ./starship.nix
    ./terminal.nix
    ./terraform.nix
    ./tmux.nix
    ./wine.nix
    ./yed.nix
    ./yq.nix
    ./zathura.nix
  ];

  options = with lib; {
    profile = {
      programs = { };
    };
  };
}
