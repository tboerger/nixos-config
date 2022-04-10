{ pkgs, lib, config, options, ... }:

let
  cfg = config.personal.services.unifi;

in
{
  options = with lib; {
    personal = {
      services = {
        unifi = {
          enable = mkEnableOption "Unifi";

          domain = mkOption {
            description = ''
              Domain to access the service
            '';
            type = types.str;
            default = "unifi.home.boerger.ws";
          };
        };
      };
    };
  };

  config = with lib; mkIf cfg.enable {
    services = {
      unifi = {
        enable = true;
        unifiPackage = pkgs.unifi;
        openPorts = false;
      };
    };

    networking = {
      firewall = {
        allowedTCPPorts = [ 8080 8880 8843 6789 ];
        allowedUDPPorts = [ 3478 5514 10001 1900 ];
        allowedUDPPortRanges = [ { from = 5656; to = 5699; } ];
      };
    };

    personal = {
      services = {
        webserver = {
          enable = true;

          hosts = [{
            domain = cfg.domain;
            proxy = "https://localhost:8443";
          }];
        };
      };
    };
  };
}
