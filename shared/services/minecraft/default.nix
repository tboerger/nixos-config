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
    # containers = {
    #   bromance = {
    #     autoStart = true;
    #     privateNetwork = true;
    #     hostAddress = "192.168.100.10";
    #     localAddress = "192.168.100.11";

    #     config = { config, pkgs, ... }: {
    #       nixpkgs = {
    #         config = {
    #           allowUnfree = true;
    #         };
    #       };

    #       services = {
    #         minecraft-server = {
    #           enable = true;
    #           package = pkgs.minecraft-server;
    #           openFirewall = true;
    #           eula = true;
    #           declarative = true;
    #           jvmOpts = "-Xmx2048M -Xms2048M";

    #           whitelist = {
    #             mompelz = "e640f53a-44a1-4d6d-89b4-988b649cbb6d";
    #           };

    #           serverProperties = {
    #             motd = "Welcome to Bromance!";
    #             white-list = true;
    #           };
    #         };
    #       };

    #       networking = {
    #         firewall = {
    #           enable = true;
    #         };
    #       };

    #       systemd = {
    #         tmpfiles = {
    #           rules = [
    #             "d /var/lib/minecraft 700 minecraft minecraft -"
    #           ];
    #         };
    #       };

    #       environment.etc."resolv.conf".text = "nameserver 1.1.1.1";
    #       system.stateVersion = "22.05";
    #     };

    #     bindMounts = {
    #       "/var/lib/minecraft" = {
    #         hostPath = "/var/lib/bromance/";
    #         isReadOnly = false;
    #       };
    #     };

    #     forwardPorts = [{
    #       containerPort = 25565;
    #       hostPort = 25575;
    #       protocol = "tcp";
    #     }];
    #   };

    #   owntech = {
    #     autoStart = true;
    #     privateNetwork = true;
    #     hostAddress = "192.168.100.20";
    #     localAddress = "192.168.100.21";

    #     config = { config, pkgs, ... }: {
    #       nixpkgs = {
    #         config = {
    #           allowUnfree = true;
    #         };
    #       };

    #       services = {
    #         minecraft-server = {
    #           enable = true;
    #           package = pkgs.minecraft-server;
    #           openFirewall = true;
    #           eula = true;
    #           declarative = true;
    #           jvmOpts = "-Xmx2048M -Xms2048M";

    #           whitelist = {
    #             mompelz = "e640f53a-44a1-4d6d-89b4-988b649cbb6d";
    #           };

    #           serverProperties = {
    #             motd = "Welcome to ownTech!";
    #             white-list = true;
    #           };
    #         };
    #       };

    #       networking = {
    #         firewall = {
    #           enable = true;
    #         };
    #       };

    #       systemd = {
    #         tmpfiles = {
    #           rules = [
    #             "d /var/lib/minecraft 700 minecraft minecraft -"
    #           ];
    #         };
    #       };

    #       environment.etc."resolv.conf".text = "nameserver 1.1.1.1";
    #       system.stateVersion = "22.05";
    #     };

    #     bindMounts = {
    #       "/var/lib/minecraft" = {
    #         hostPath = "/var/lib/owntech/";
    #         isReadOnly = false;
    #       };
    #     };

    #     forwardPorts = [{
    #       containerPort = 25565;
    #       hostPort = 25585;
    #       protocol = "tcp";
    #     }];
    #   };
    # };
  };
}
