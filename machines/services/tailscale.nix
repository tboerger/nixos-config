{ pkgs, lib, config, options, fetchurl, ... }:
with lib;

let
  cfg = config.personal.services.tailscale;

in
{
  options = {
    personal = {
      services = {
        tailscale = {
          enable = mkEnableOption "Tailscale";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    networking = {
      firewall = {
        checkReversePath = "loose";
      };
    };

    services = {
      tailscale = {
        enable = true;
      };
    };

    systemd.services.tailscaled-autoconnect = {
      description = "Automatic connection for Tailscale";

      after = [ "network-pre.target" "tailscale.service" ];
      wants = [ "network-pre.target" "tailscale.service" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig.Type = "oneshot";

      script = ''
        sleep 3

        STATUS="$(${pkgs.tailscale}/bin/tailscale status -json | ${pkgs.jq}/bin/jq -r .BackendState)"
        if [ $\{STATUS\} = "Running" ]; then
          exit 0
        fi

        ${pkgs.tailscale}/bin/tailscale up --auth-key file:${config.age.secrets."services/tailscale/authkey".path}
      '';
    };

    age.secrets."services/tailscale/authkey" = {
      file = ../../secrets/services/tailscale/authkey.age;
    };
  };
}
