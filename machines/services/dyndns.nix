{ pkgs, lib, config, options, ... }:

let
  cfg = config.personal.services.dyndns;

in
{
  options = with lib; {
    personal = {
      services = {
        dyndns = {
          enable = mkEnableOption "DynDNS";
        };
      };
    };
  };

  config = with lib; mkIf cfg.enable {
    services = {
      godns = {
        enable = true;
        package = pkgs.master.godns;

        settings = {
          provider = "Cloudflare";
          email = "thomas@webhippie.de";
          password_file = config.age.secrets."services/dyndns/password".path;
          resolver = "1.1.1.1";
          domains = [{
            domain_name = "boerger.ws";
            sub_domains = [
              "home"
              "*.home"
            ];
          }];
        };
      };
    };

    age.secrets."services/dyndns/password" = {
      file = ../../secrets/services/dyndns/password.age;
      owner = "godns";
    };
  };
}
