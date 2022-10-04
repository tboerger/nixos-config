{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.services.frpc;

  configFile =
    pkgs.writeText "frpc.conf" (generators.toINI { } cfg.settings);

in
{
  options.services.frpc = {
    enable = mkEnableOption "frpc";

    user = mkOption {
      type = types.str;
      default = "frpc";
      description = ''
        User under which frpc runs.
      '';
    };

    group = mkOption {
      type = types.str;
      default = "frpc";
      description = ''
        Group under which frpc runs.
      '';
    };

    package = mkOption {
      type = types.package;
      default = pkgs.frp;
      defaultText = "pkgs.frp";
      description = ''
        The frp package to use.
      '';
    };

    token = mkOption {
      type = types.str;
      default = "";
      description = ''
        Path to token secret file.
      '';
    };

    settings = mkOption {
      description = ''
        Full settings for the client.
      '';
      type = types.attrsOf types.attrs;
      default = { };
      example = literalExpression ''
        common = {
          server_addr = "example.com";
          server_port = 7001;
        };
        http = {
          type = "tcp";
          local_ip = "127.0.0.1";
          local_port = 80;
        };
        https = {
          type = "tcp";
          local_ip = "127.0.0.1";
          local_port = 443;
        };
      '';
    };
  };

  config = mkIf cfg.enable {
    users.groups = mkIf (cfg.group == "frpc") {
      frpc = { };
    };

    users.users = mkIf (cfg.user == "frpc") {
      frpc = {
        group = cfg.group;
        shell = pkgs.bashInteractive;
        createHome = false;
        description = "frpc user";
        isSystemUser = true;
      };
    };

    systemd.services.frpc = {
      description = "FRP Client";
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];

      serviceConfig = {
        Type = "simple";
        User = cfg.user;
        Group = cfg.group;
        Restart = "on-failure";
        ExecStart = pkgs.writeShellScript "frpc.sh" ''
          set -eu
          export FRP_TOKEN=$(<${cfg.token})
          ${cfg.package}/bin/frpc -c ${configFile}
        '';
      };
    };
  };
}
