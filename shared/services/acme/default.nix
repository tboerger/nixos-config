{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.personal.services.acme;

in
{
  options = {
    personal = {
      services = {
        acme = {
          enable = mkEnableOption "Acme";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    security = {
      acme = {
        acceptTerms = true;

        defaults = {
          reloadServices = [ "nginx" ];
        };

        certs = {
          "boerger.ws" = {
            email = "hostmaster@boerger.ws";
            extraDomainNames = [ "*.boerger.ws" ];
            dnsProvider = "cloudflare";
            credentialsFile = config.age.secrets."services/acme/credentials".path;
          };
        };
      };
    };

    age.secrets."services/acme/credentials" = {
      file = ../../../secrets/services/acme/credentials.age;
      owner = "acme";
    };
  };
}
