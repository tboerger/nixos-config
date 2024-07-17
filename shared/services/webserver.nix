{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.personal.services.webserver;

in
{
  options = {
    personal = {
      services = {
        webserver = {
          enable = mkEnableOption "Webserver";

          hosts = mkOption {
            description = ''
              List of hosts to configure
            '';
            type = types.listOf (types.submodule {
              options = {
                domain = mkOption {
                  type = types.str;
                  description = "Name of the domain";
                };
                domainOptions = mkOption {
                  type = types.attrs;
                  default = { };
                  description = "Custom options for domain";
                };
                proxy = mkOption {
                  type = types.nullOr types.str;
                  default = null;
                  description = "Optional proxy target";
                };
                proxyOptions = mkOption {
                  type = types.str;
                  default = "";
                  description = "Custom options for proxy";
                };
              };
            });
            default = [ ];
            example = [{
              domain = "dummy.boerger.ws";
              proxy = "http://localhost:8080";
              options = {
                locations = {
                  "/".extraConfig = ''
                    autoindex on;
                  '';
                };
              };
            }];
          };

          acmeHost = mkOption {
            description = ''
              Use this acme certificate chain
            '';
            type = types.str;
            default = "boerger.ws";
          };
        };
      };
    };
  };

  config = mkIf cfg.enable {
    networking.firewall = {
      allowedTCPPorts = [ 80 443 ];
    };

    services = {
      nginx = {
        enable = true;

        recommendedTlsSettings = true;
        recommendedGzipSettings = true;
        recommendedOptimisation = true;
        recommendedProxySettings = true;

        virtualHosts = builtins.listToAttrs
          (map
            (elem: {
              name = elem.domain;
              value = {
                useACMEHost = cfg.acmeHost;
                forceSSL = true;
                locations = {
                  "/" = mkIf (builtins.hasAttr "proxy" elem) {
                    proxyPass = elem.proxy;
                    extraConfig = (
                      elem.proxyOptions or ''
                        proxy_http_version 1.1;
                        proxy_set_header Upgrade $http_upgrade;
                        proxy_set_header Connection $http_connection;
                        proxy_set_header X-Forwarded-Ssl on;
                      ''
                    );
                  };
                };
              } // (elem.domainOptions or { });
            })
            config.personal.services.webserver.hosts) // {
          "boerger.ws" = {
            useACMEHost = cfg.acmeHost;
            addSSL = true;
            forceSSL = false;
            default = true;
            root = "/var/empty";
          };
        };
      };
    };

    users = {
      users = {
        nginx = {
          extraGroups = [
            "acme"
          ];
        };
      };
    };

    personal = {
      services = {
        acme = {
          enable = true;
        };
      };
    };
  };
}
