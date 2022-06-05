{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.services.prowlarr;

in
{
  config = mkIf cfg.enable {
    systemd.services.prowlarr = {
      description = "Prowlarr";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = mkForce {
        Type = "simple";
        User = cfg.user;
        Group = cfg.group;
        ExecStart = "${cfg.package}/bin/Prowlarr -nobrowser -data='${cfg.dataDir}'";
        Restart = "on-failure";
      };
    };
  };
}
