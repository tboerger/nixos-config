{ config, lib, pkgs, ... }:

{
  services = {
    thinkfan = {
      enable = true;
    };
  };

  systemd = {
    services = {
      thinkfan = {
        preStart = "
          /run/current-system/sw/bin/modprobe -r thinkpad_acpi && /run/current-system/sw/bin/modprobe thinkpad_acpi
        ";
      };
    };
  };
}
