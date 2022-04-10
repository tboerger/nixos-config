{ pkgs, lib, config, options, ... }:

let
  cfg = config.personal.services.acme;

in
{
  options = with lib; {
    personal = {
      services = {
        acme = {
          enable = mkEnableOption "Acme";
        };
      };
    };
  };

  config = with lib; mkIf cfg.enable {
      security = {
        acme = {
          acceptTerms = true;
          email = "hostmaster@boerger.ws";

          certs = {
            "home.boerger.ws" = {
              extraDomainNames = ["*.home.boerger.ws"];
              dnsProvider = "cloudflare";
              credentialsFile = config.age.secrets."services/acme/credentials".path;
            };
          };
        };
      };

      age.secrets."services/acme/credentials" = {
        file = ../../secrets/services/acme/credentials.age;
        owner = "acme";
      };
    };
}
