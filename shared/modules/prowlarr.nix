{ config, pkgs, lib, ... }:
with lib;

let
  cfg = config.services.prowlarr;
in
{
  options = {
    services.prowlarr = {
      dataDir = mkOption {
        type = types.str;
        default = "/var/lib/prowlarr/.config/NzbDrone";
        description = lib.mdDoc "The directory where Prowlarr stores its data files.";
      };

      user = mkOption {
        type = types.str;
        default = "prowlarr";
        description = lib.mdDoc "User account under which Prowlarr runs.";
      };

      group = mkOption {
        type = types.str;
        default = "prowlarr";
        description = lib.mdDoc "Group under which Prowlarr runs.";
      };
    };
  };

  config = mkIf cfg.enable {
    ids.uids = {
      prowlarr = 328;
    };

    ids.gids = {
      prowlarr = 328;
    };

    systemd.tmpfiles.rules = [
      "d '${cfg.dataDir}' 0700 ${cfg.user} ${cfg.group} - -"
    ];

    systemd.services.prowlarr = {
      serviceConfig = {
        Type = "simple";
        User = cfg.user;
        Group = cfg.group;
        ExecStart = "${lib.getExe cfg.package} -nobrowser -data='${cfg.dataDir}'";
        Restart = "on-failure";
      };
    };

    users.users = mkIf (cfg.user == "prowlarr") {
      prowlarr = {
        group = cfg.group;
        home = cfg.dataDir;
        uid = config.ids.uids.prowlarr;
      };
    };

    users.groups = mkIf (cfg.group == "prowlarr") {
      prowlarr.gid = config.ids.gids.prowlarr;
    };
  };
}
