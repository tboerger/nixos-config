{ pkgs, lib, config, options, fetchurl, ... }:
with lib;

let
  cfg = config.personal.services.minecraft;

in
{
  options = {
    personal = {
      services = {
        minecraft = {
          enable = mkEnableOption "Minecraft";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    networking = {
      firewall = {
        allowedTCPPorts = [ 25565 ];
      };
    };

    virtualisation = {
      oci-containers = {
        containers = {
          minecraft-boergers = {
            hostname = "minecraft";
            image = "ghcr.io/crafthippie/boergers:1.1.2";
            autoStart = true;
            workdir = "/var/lib/minecraft/boergers";

            environment = {
              MINECRAFT_DIFFICULTY = "1";
              MINECRAFT_MAX_PLAYERS = "20";
              MINECRAFT_MAXHEAP = "4096M";
              MINECRAFT_MOTD = "Welcome to the Boergers";
              MINECRAFT_WHITE_LIST = "true";
            };

            ports = [
              "25565:25565"
              "127.0.0.1:8123:8123"
            ];

            volumes = [
              "/var/lib/minecraft/boergers:/var/lib/minecraft"
            ];
          };
        };
      };
    };

    personal = {
      services = {
        webserver = {
          enable = true;

          hosts = [
            {
              domain = "minecraft.boerger.ws";
              proxy = "http://localhost:8123";
            }
          ];
        };
      };
    };
  };
}
