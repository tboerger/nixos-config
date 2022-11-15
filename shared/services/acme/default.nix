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
          email = "hostmaster@boerger.ws";
        };

        certs = {
          "boerger.ws" = {
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
