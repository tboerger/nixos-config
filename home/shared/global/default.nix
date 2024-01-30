{ pkgs, lib, config, options, ... }:

{
  # nixpkgs = {
  #   config = {
  #     allowUnfree = true;
  #     allowUnfreePredicate = (_: true);
  #   };

  #   overlays = [
  #     (import ../../../overlays)
  #   ];
  # };

  homeage = {
    identityPaths = [ "~/.ssh/id_ed25519" ];
    installationType = "systemd";
  };

  programs = {
    home-manager = {
      enable = true;
    };
  };

  systemd = {
    user = {
      startServices = "sd-switch";
    };
  };
}
