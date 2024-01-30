{ pkgs, lib, config, options, fetchurl, ... }:
with lib;

let
  cfg = config.personal.services.tailscale;

in
{
  options = {
    personal = {
      services = {
        tailscale = {
          enable = mkEnableOption "Tailscale";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    services = {
      tailscale = {
        enable = true;
        authKeyFile = config.age.secrets."services/tailscale/authkey".path;
        openFirewall = true;
      };
    };

    age.secrets."services/tailscale/authkey" = {
      file = ../../secrets/services/tailscale/authkey.age;
    };
  };
}
