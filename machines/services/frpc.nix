{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.personal.services.frpc;

in
{
  options = {
    personal = {
      services = {
        frpc = {
          enable = mkEnableOption "FRP Client";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    services = {
      frpc = {
        enable = true;
        token = config.age.secrets."services/frpc/token".path;

        settings = {
          common = {
            server_addr = "frps.boerger.ws";
            server_port = 30601;
            token = "{{ .Envs.FRP_TOKEN }}";
            admin_addr = "127.0.0.1";
            admin_port = 7400;
            admin_user = "admin";
            admin_pwd = "admin";
            tls_enable = true;
          };
          http = {
            type = "tcp";
            local_ip = "127.0.0.1";
            local_port = 80;
            use_encryption = true;
            use_compression = true;
            remote_port = 8080;
            health_check_type = "tcp";
            health_check_timeout_s = 3;
            health_check_max_failed = 3;
            health_check_interval_s = 10;
          };
          https = {
            type = "tcp";
            local_ip = "127.0.0.1";
            local_port = 443;
            use_encryption = true;
            use_compression = true;
            remote_port = 8443;
            health_check_type = "tcp";
            health_check_timeout_s = 3;
            health_check_max_failed = 3;
            health_check_interval_s = 10;
          };
        };
      };
    };

    age.secrets."services/frpc/token" = {
      file = ../../secrets/services/frpc/token.age;
      owner = "frpc";
      group = "frpc";
    };
  };
}
