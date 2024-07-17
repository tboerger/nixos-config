{ pkgs, config, lib, ... }:
with lib;

{
  networking = {
    useHostResolvConf = mkForce false;

    firewall = {
      enable = true;
      allowedTCPPorts = [
        80
      ];
    };
  };

  services = {
    resolved = {
      enable = true;
    };
  };
}
