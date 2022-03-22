{ pkgs, lib, config, options, ... }:

let
  cfg = config.my.modules.acme;

in

{
  options = with lib; {
    my = {
      modules = {
        acme = {
          enable = mkEnableOption ''
            Whether to enable acme module
          '';
        };
      };
    };
  };

  config = with lib;
    mkIf cfg.enable {
      security = {
        acme = {
          acceptTerms = true;

          defaults = {
            email = "hostmaster@boerger.ws";
          };

          certs = {
            "home.boerger.ws" = {
              domain = "*.home.boerger.ws";
              dnsProvider = "cloudflare";
              credentialsFile = config.age.secrets.acme.path;
            };
          };
        };
      };

      age.secrets.acme = {
        file = ../../secrets/acme.age;
        owner = "acme";
      };
    };
}
