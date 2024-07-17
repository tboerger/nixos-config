{ pkgs, config, lib, ... }:
with lib;

{
  networking = {
    useHostResolvConf = mkForce false;

    firewall = {
      enable = true;
      allowedTCPPorts = [

      ];
    };
  };

  services = {
    resolved = {
      enable = true;
    };
  };
}
