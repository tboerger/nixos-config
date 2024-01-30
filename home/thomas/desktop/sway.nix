{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.desktop.sway;

  programs = {
    term = [
      {
        exec = "wezterm";
        class = "WezTerm";
      }
    ];

    editor = [
      {
        exec = "code";
        class = "code";
      }
    ];

    browser = [
      {
        exec = "google-chrome-stable";
        class = "google-chrome";
      }
    ];

    music = [
      {
        exec = "shortwave";
        class = "shortwave";
      }
    ];

    mail = [
      {
        exec = "mailspring";
        class = "mailspring";
      }
    ];

    chat = [ ];
  };

in
{
  options = {
    profile = {
      desktop = {
        sway = {
          enable = mkEnableOption "Sway";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        scrot
        wl-clipboard
      ];
    };

    programs = {
      feh = {
        enable = true;
      };
      wlogout = {
        enable = true;
      };
      wpaperd = {
        enable = true;
      };

      rofi = {
        enable = true;
        package = pkgs.rofi-wayland;

        font = "DejaVu Sans Mono 14";
        terminal = "${pkgs.wezterm}/bin/wezterm";
        theme = "solarized";

        plugins = with pkgs; [
          rofi-calc
          rofi-file-browser
          rofi-power-menu
          rofi-pulse-select
          rofi-systemd
          rofi-vpn
        ];

        extraConfig = {
          modi = "window,drun,ssh";
        };
      };

      swaylock = {
        enable = true;

        settings = {
          scaling = "fill";
          image = "${config.home.homeDirectory}/.wallpapers/light.jpg";
        };
      };

      waybar = {
        enable = true;

        # settings = {
        #   general = {
        #     position = "top";
        #   };
        # };
      };
    };

    services = {
      gnome-keyring = {
        enable = true;
      };
      caffeine = {
        enable = true;
      };
      blueman-applet = {
        enable = true;
      };
      clipman = {
        enable = true;
      };
      network-manager-applet = {
        enable = true;
      };
      playerctld = {
        enable = true;
      };
      flameshot = {
        enable = true;
      };

      kanshi = {
        enable = true;
      };
      swayidle = {
        enable = true;
      };
      swayosd = {
        enable = true;
      };

      # mako = {
      #   enable = true;
      # };

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

    wayland = {
      windowManager = {
        sway = {
          enable = true;

          config = {
            terminal = "${pkgs.wezterm}/bin/wezterm";

            bars = mkDefault [ ];
            # modes = mkDefault { };

            fonts = {
              size = 14.0;

              names = [
                "DejaVu Sans Mono"
              ];
            };

            floating = {
              modifier = "Mod4";
            };

            assigns = {
              "1" = map (i: { class = i.class; }) programs.term;
              "2" = map (i: { class = i.class; }) programs.editor;
              "3" = map (i: { class = i.class; }) programs.browser;
              "4" = map (i: { class = i.class; }) programs.mail;
              "5" = map (i: { class = i.class; }) programs.music;
              "6" = map (i: { class = i.class; }) programs.chat;
            };

            startup = [
              {
                command = "feh --no-fehbg --bg-scale ${config.home.homeDirectory}/.wallpapers/tower.jpg";
                always = false;
              }
              {
                command = "systemctl --user restart waybar";
                always = true;
              }
              {
                command = "systemctl --user restart dunst";
                always = true;
              }
              {
                command = "systemctl --user restart udiskie";
                always = true;
              }
              {
                command = "systemctl --user restart nm-applet";
                always = true;
              }
              {
                command = "systemctl --user restart blueman-applet";
                always = true;
              }
            ] ++ (map (i: { command = i.exec; }) programs.term) ++ (map (i: { command = i.exec; }) programs.editor) ++ (map (i: { command = i.exec; }) programs.browser) ++ (map (i: { command = i.exec; }) programs.mail) ++ (map (i: { command = i.exec; }) programs.music) ++ (map (i: { command = i.exec; }) programs.chat);

            gaps = {
              smartGaps = true;
              inner = 12;
            };

            colors = {
              focused = {
                border = "#002b36";
                background = "#586e75";
                text = "#fdf6e3";
                indicator = "#268bd2";
                childBorder = "#586e75";
              };

              focusedInactive = {
                border = "#002b36";
                background = "#073642";
                text = "#839496";
                indicator = "#073642";
                childBorder = "#073642";
              };

              unfocused = {
                border = "#002b36";
                background = "#073642";
                text = "#839496";
                indicator = "#073642";
                childBorder = "#073642";
              };

              urgent = {
                border = "#002b36";
                background = "#dc322f";
                text = "#fdf6e3";
                indicator = "#002b36";
                childBorder = "#dc322f";
              };
            };

            # keybindings = {
            #   "XF86AudioPlay" = "exec --no-startup-id playerctl play-pause";
            #   "XF86AudioPrev" = "exec --no-startup-id playerctl previous";
            #   "XF86AudioNext" = "exec --no-startup-id playerctl next";
            #   "XF86AudioStop" = "exec --no-startup-id playerctl stop";

            #   "XF86AudioRaiseVolume" = "exec swayosd-client --output-volume raise";
            #   "XF86AudioLowerVolume" = "exec swayosd-client --output-volume lower";
            #   "XF86AudioMute" = "exec swayosd-client --output-volume mute-toggle";
            #   "XF86AudioMicMute" = "exec swayosd-client --input-volume mute-toggle";

            #   "XF86MonBrightnessUp" = "exec swayosd-client --brightness raise";
            #   "XF86MonBrightnessDown" = "exec swayosd-client --brightness lower";

            #   "--release Print" = "exec ${pkgs.scrot}/bin/scrot";
            #   "--release Shift+Print" = "exec ${pkgs.scrot}/bin/scrot -u";
            #   "--release Ctrl+Print" = "exec ${pkgs.scrot}/bin/scrot -s";

            #   "Mod4+d" = "exec ${pkgs.rofi}/bin/rofi -show drun";
            #   "Mod4+Return" = "exec ${pkgs.wezterm}/bin/wezterm";
            #   "Mod4+Shift+q" = "kill";

            #   "Mod4+Left" = "focus left";
            #   "Mod4+Down" = "focus down";
            #   "Mod4+Up" = "focus up";
            #   "Mod4+Right" = "focus right";

            #   "Mod4+Shift+Left" = "move left";
            #   "Mod4+Shift+Down" = "move down";
            #   "Mod4+Shift+Up" = "move up";
            #   "Mod4+Shift+Right" = "move right";

            #   "Mod4+h" = "split h";
            #   "Mod4+v" = "split v";
            #   "Mod4+f" = "fullscreen toggle";

            #   "Mod4+s" = "layout stacking";
            #   "Mod4+w" = "layout tabbed";
            #   "Mod4+e" = "layout toggle split";

            #   "Mod4+Shift+Space" = "floating toggle";
            #   "Mod4+Space" = "focus mode_toggle";

            #   "Mod4+1" = "workspace number 1";
            #   "Mod4+2" = "workspace number 2";
            #   "Mod4+3" = "workspace number 3";
            #   "Mod4+4" = "workspace number 4";
            #   "Mod4+5" = "workspace number 5";
            #   "Mod4+6" = "workspace number 6";
            #   "Mod4+7" = "workspace number 7";
            #   "Mod4+8" = "workspace number 8";
            #   "Mod4+9" = "workspace number 9";

            #   "Mod4+Shift+1" = "move container to workspace number 1";
            #   "Mod4+Shift+2" = "move container to workspace number 2";
            #   "Mod4+Shift+3" = "move container to workspace number 3";
            #   "Mod4+Shift+4" = "move container to workspace number 4";
            #   "Mod4+Shift+5" = "move container to workspace number 5";
            #   "Mod4+Shift+6" = "move container to workspace number 6";
            #   "Mod4+Shift+7" = "move container to workspace number 7";
            #   "Mod4+Shift+8" = "move container to workspace number 8";
            #   "Mod4+Shift+9" = "move container to workspace number 9";

            #   "Mod4+Shift+c" = "reload";
            #   "Mod4+Shift+r" = "restart";
            # };

          };

          # extraConfig = ''
          #   set $power "[l]ock log[o]ut [s]uspend [h]ibernate [r]eboot [p]oweroff"

          #   mode $power {
          #       bindsym l exec ${pkgs.swaylock}/bin/swaylock; mode "default"
          #       bindsym o exec swaymsg exit; mode "default"
          #       bindsym s exec systemctl suspend; mode "default"
          #       bindsym h exec systemctl hibernate; mode "default"
          #       bindsym r exec systemctl reboot; mode "default"
          #       bindsym p exec systemctl poweroff; mode "default"

          #       bindsym Return mode "default"
          #       bindsym Escape mode "default"
          #       bindsym Mod4+n mode "default"
          #   }

          #   mode "resize" {
          #       bindsym Left resize shrink width 10 px or 10 ppt
          #       bindsym Down resize grow height 10 px or 10 ppt
          #       bindsym Up resize shrink height 10 px or 10 ppt
          #       bindsym Right resize grow width 10 px or 10 ppt

          #       bindsym Return mode "default"
          #       bindsym Escape mode "default"
          #       bindsym Mod4+r mode "default"
          #   }

          #   bindsym Mod4+n mode $power
          #   bindsym Mod4+r mode "resize"
          # '';

          swaynag = {
            enable = true;
          };
        };
      };
    };
  };
}
