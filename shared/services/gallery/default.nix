{ pkgs, lib, config, options, fetchurl, ... }:
with lib;

let
  cfg = config.personal.services.gallery;
  hostAddress = "192.168.100.20";
  containerAddress = "192.168.100.21";

in
{
  options = {
    personal = {
      services = {
        gallery = {
          enable = mkEnableOption "Gallery";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    system = {
      activationScripts = {
        makeGalleryDir = lib.stringAfter [ "var" ] ''
          mkdir -p /var/lib/photoprism /var/lib/photos /var/lib/videos
        '';
      };
    };

    containers = {
      gallery = {
        autoStart = true;
        privateNetwork = true;
        ephemeral = true;

        hostAddress = hostAddress;
        localAddress = containerAddress;

        bindMounts = {
          "/var/lib/photoprism" = {
            hostPath = "/var/lib/photoprism";
            isReadOnly = false;
          };
          "/var/lib/originals/photos" = {
            hostPath = "/var/lib/photos";
            isReadOnly = false;
          };
          "/var/lib/originals/videos" = {
            hostPath = "/var/lib/videos";
            isReadOnly = false;
          };

          "${config.age.secrets."services/gallery/password".path}" = {
            isReadOnly = true;
          };
        };

        config = { config, pkgs, ... }: {
          system = {
            stateVersion = "23.11";
          };

          imports = [
            ./networking.nix
            ./tmpfiles.nix
            ./photoprism.nix
          ];
        };
      };
    };

    personal = {
      services = {
        webserver = {
          enable = true;

          hosts = [
            {
              domain = "gallery.boerger.ws";
              proxy = "http://${containerAddress}:2342";
            }
          ];
        };
      };
    };

    age.secrets."services/gallery/password" = {
      file = ../../../secrets/services/gallery/password.age;
    };
  };
}
