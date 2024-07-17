{ pkgs, config, lib, ... }:
with lib;

{
  services = {
    jellyfin = {
      enable = true;
      user = "media";
      group = "users";
    };
  };
}
