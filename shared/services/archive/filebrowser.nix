{ pkgs, config, lib, ... }:
with lib;

{
  services = {
    filebrowser = {
      enable = true;
      user = "media";
      group = "users";

      settings = {
        root = "/var/lib/music";
      };
    };
  };
}
