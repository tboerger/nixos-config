{ pkgs, config, lib, ... }:
with lib;

{
  networking = {
    useHostResolvConf = mkForce false;

    firewall = {
      enable = true;
      allowedTCPPorts = [
        2342
      ];
    };
  };

  services = {
    resolved = {
      enable = true;
    };
  };
}
