{ config, pkgs, lib, ... }:
with lib;

let
  cfg = config.services.filebrowser;
  settingsFormat = pkgs.formats.json { };
in
{
  options = {
    services.filebrowser = {
      enable = mkEnableOption "Filebrowser";

      settings = mkOption rec {
        type = settingsFormat.type;
        apply = recursiveUpdate default;
        default = {
          address = "127.0.0.1";
          port = 8080;
          log = "stdout";
          database = "/var/lib/filebrowser/database.db";
        };
        example = {
          root = "/usr/share/filebrowser";
        };
        description = "Configuration for Filebrowser.";
      };

      openFirewall = mkOption {
        type = types.bool;
        default = false;
        description = "Open ports in the firewall for the Filebrowser interface.";
      };

      user = mkOption {
        type = types.str;
        default = "filebrowser";
        description = "User under which Filebrowser runs.";
      };

      group = mkOption {
        type = types.str;
        default = "filebrowser";
        description = "Group under which Filebrowser runs.";
      };

      package = mkOption {
        type = types.package;
        default = pkgs.filebrowser;
        defaultText = literalExpression "pkgs.filebrowser";
        description = "Filebrowser package to use.";
      };
    };
  };

  config = mkIf cfg.enable {
    ids.uids = {
      filebrowser = 327;
    };

    ids.gids = {
      filebrowser = 327;
    };

    systemd.tmpfiles.rules = [
      "d '${dirOf cfg.settings.database}' 0700 ${cfg.user} ${cfg.group} - -"
    ];

    systemd.services.filebrowser = {
      description = "Filebrowser";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        Type = "simple";
        User = cfg.user;
        Group = cfg.group;
        ExecStart = "${cfg.package}/bin/filebrowser --config ${settingsFormat.generate "filebrowser.json" cfg.settings}";
        Restart = "on-failure";
      };
    };

    networking.firewall = mkIf cfg.openFirewall {
      allowedTCPPorts = [ cfg.settings.port ];
    };

    users.users = mkIf (cfg.user == "filebrowser") {
      filebrowser = {
        group = cfg.group;
        home = dirOf cfg.settings.database;
        uid = config.ids.uids.filebrowser;
      };
    };

    users.groups = mkIf (cfg.group == "filebrowser") {
      filebrowser.gid = config.ids.gids.filebrowser;
    };
  };
}
