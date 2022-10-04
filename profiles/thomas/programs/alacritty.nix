{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.alacritty;

in
{
  options = {
    profile = {
      programs = {
        alacritty = {
          enable = mkEnableOption "Alacritty";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    home-manager.users."${config.profile.username}" = { config, ... }: {
      programs = {
        alacritty = {
          enable = true;

          settings = {
            env = {
              TERM = "xterm-256color";
              WINIT_X11_SCALE_FACTOR = "1";
            };

            window = {
              padding = {
                x = 5;
                y = 5;
              };
            };

            scrolling = {
              history = 100000;
            };

            font = {
              size = 14.0;

              normal = {
                family = "DejaVu Sans Mono";
              };
            };

            # key_bindings = [
            #   {
            #     key = "K";
            #     mods = "Control";
            #     action = "ClearHistory";
            #   }
            # ];

            colors = {
              primary = {
                background = "0x002b36";
                foreground = "0x839496";
              };

              normal = {
                black = "0x073642";
                red = "0xdc322f";
                green = "0x859900";
                yellow = "0xb58900";
                blue = "0x268bd2";
                magenta = "0xd33682";
                cyan = "0x2aa198";
                white = "0xeee8d5";
              };

              bright = {
                black = "0x002b36";
                red = "0xcb4b16";
                green = "0x586e75";
                yellow = "0x657b83";
                blue = "0x839496";
                magenta = "0x6c71c4";
                cyan = "0x93a1a1";
                white = "0xfdf6e3";
              };
            };
          };
        };
      };
    };
  };
}
