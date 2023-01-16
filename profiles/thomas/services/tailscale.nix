{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.services.tailscale;

  mkTrayService = lib.recursiveUpdate {
    Install.WantedBy = ["tray.target"];
    Unit.After = ["tray.target"];
  };

in
{
  options = {
    profile = {
      services = {
        tailscale = {
          enable = mkEnableOption "Tailscale";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        nur.repos.tboerger.tailscale-systray
      ];
    };

    home-manager.users."${config.profile.username}" = { config, ... }: {
      systemd = {
        user = {
          services = {
            "tailscale-tray" = mkTrayService {
              Unit = {
                Description = "Tailscale indicator for system tray";
              };
              Service = {
                ExecStartPre = "${pkgs.coreutils-full}/bin/sleep 5";
                ExecStart = "${pkgs.nur.repos.tboerger.tailscale-systray}/bin/tailscale-systray";
              };
            };
          };
        };
      };
    };
  };
}
