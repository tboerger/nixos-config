{ pkgs, lib, config, options, fetchurl, ... }:
with lib;

let
  cfg = config.personal.services.auth;
  hostAddress = "192.168.100.40";
  containerAddress = "192.168.100.41";

in
{
  options = {
    personal = {
      services = {
        auth = {
          enable = mkEnableOption "Auth";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    networking.firewall = {
      allowedTCPPorts = [ 636 ];
    };

    containers = {
      auth = {
        autoStart = true;
        privateNetwork = true;
        ephemeral = true;

        hostAddress = hostAddress;
        localAddress = containerAddress;

        forwardPorts = [{
          protocol = "tcp";
          hostPort = 636;
          containerPort = 636;
        }];

        bindMounts = {
          "/var/lib/acme" = {
            hostPath = "/var/lib/acme";
            isReadOnly = true;
          };
          "/var/lib/kanidm" = {
            hostPath = "/var/lib/kanidm";
            isReadOnly = false;
          };
        };

        config = { config, pkgs, ... }: {
          system = {
            stateVersion = "23.11";
          };

          systemd = {
            tmpfiles = {
              rules = [ "d /var/lib/kanidm 0700 kanidm kanidm" ];
            };
          };

          environment = {
            systemPackages = with pkgs; [
              sqlite
            ];
          };

          services = {
            resolved = {
              enable = true;
            };

            kanidm = {
              enableServer = true;

              serverSettings = {
                bindaddress = "0.0.0.0:8443";
                ldapbindaddress = "0.0.0.0:636";
                domain = "auth.boerger.ws";
                origin = "https://auth.boerger.ws";
                log_level = "info";
                tls_key = "/var/lib/acme/boerger.ws/key.pem";
                tls_chain = "/var/lib/acme/boerger.ws/fullchain.pem";
              };

              enableClient = true;

              clientSettings = {
                uri = "https://auth.boerger.ws";
              };
            };
          };

          networking = {
            useHostResolvConf = mkForce false;

            firewall = {
              enable = true;
              allowedTCPPorts = [ 636 8443 ];
            };
          };

          ids.uids = {
            acme = 400;
          };

          ids.gids = {
            acme = 400;
          };

          users = {
            users = {
              acme = {
                home = "/var/lib/acme";
                group = "acme";
                isSystemUser = true;
                uid = config.ids.uids.acme;
              };

              kanidm = {
                extraGroups = [
                  "acme"
                ];
              };
            };
          };

          users.groups = {
            acme = {
              gid = config.ids.gids.acme;
            };
          };
        };
      };
    };

    personal = {
      services = {
        acme = {
          enable = true;
        };

        webserver = {
          enable = true;

          hosts = [
            {
              domain = "auth.boerger.ws";
              proxy = "https://${containerAddress}:8443";
            }
          ];
        };
      };
    };
  };
}
