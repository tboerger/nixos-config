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
