{
  pkgs,
  config,
  lib,
  ...
}:
with lib;

{
  services = {
    sabnzbd = {
      enable = true;
      user = "media";
      group = "users";
    };
  };
}
