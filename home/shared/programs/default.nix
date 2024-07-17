{ pkgs, lib, config, options, ... }:

{
  imports = [
    ./act.nix
    ./banking.nix
    ./citrix.nix
    ./clouds.nix
    ./develop.nix
    ./gnupg.nix
    ./golang.nix
    ./gomplate.nix
    ./graphics.nix
    ./helm.nix
    ./joplin.nix
    ./jq.nix
    ./jsonnet.nix
    ./kubectl.nix
    ./kustomize.nix
    ./latex.nix
    ./lens.nix
    ./messages.nix
    ./minecraft.nix
    ./network.nix
    ./ngrok.nix
    ./nodejs.nix
    ./office.nix
    ./shortwave.nix
    ./streaming.nix
    ./terminal.nix
    ./terraform.nix
    ./wine.nix
    ./yq.nix
    ./zathura.nix
  ];

  options = with lib; {
    profile = {
      programs = { };
    };
  };
}
