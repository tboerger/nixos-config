{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.services.dunst;

in
{
  options = {
    profile = {
      services = {
        dunst = {
          enable = mkEnableOption "Dunst";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    home-manager.users."${config.profile.username}" = { config, ... }: {
      services = {
        dunst = {
          enable = true;

          iconTheme = {
            name = "Numix";
            package = pkgs.numix-icon-theme;
            size = "64x64";
          };

          settings = {
            global = {
              font = "DejaVu Sans Mono 14";
              frame_color = "#93a1a1";
              separator_color = "#93a1a1";
            };

            urgency_normal = {
              msg_urgency = "normal";
              background = "#586e75";
              foreground = "#93a1a1";
            };

            urgency_critical = {
              msg_urgency = "critical";
              background = "#dc322f";
              foreground = "#eee8d5";
            };

            urgency_low = {
              msg_urgency = "low";
              background = "#073642";
              foreground = "#657b83";
            };
          };
        };
      };
    };
  };
}
