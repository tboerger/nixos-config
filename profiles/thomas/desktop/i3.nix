{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.desktop.i3;

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

    music = [ ];

    mail = [
      {
        exec = "mailspring";
        class = "mailspring";
      }
    ];

    chat = [
      {
        exec = "discord";
        class = "discord";
      }
      {
        exec = "element-desktop";
        class = "element";
      }
      {
        exec = "mattermost-desktop";
        class = "mattermost";
      }
      {
        exec = "rocketchat-desktop";
        class = "rocket.chat";
      }
      {
        exec = "signal-desktop";
        class = "signal";
      }
      {
        exec = "skypeforlinux";
        class = "skype";
      }
      {
        exec = "slack";
        class = "slack";
      }
      {
        exec = "teams";
        class = "microsoft teams";
      }
      {
        exec = "tdekstop";
        class = "telegram-desktop";
      }
      {
        exec = "whatsapp-for-linux";
        class = "whatsapp-for-linux";
      }
    ];
  };

in
{
  options = {
    profile = {
      desktop = {
        i3 = {
          enable = mkEnableOption "i3";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    profile = {
      services = {
        blueman = {
          enable = true;
        };
        caffeine = {
          enable = true;
        };
        flameshot = {
          enable = true;
        };
        nmapplet = {
          enable = true;
        };
      };
    };

    services = {
      xserver = {
        windowManager = {
          i3 = {
            enable = true;
            package = pkgs.i3-gaps;
          };
        };
      };
    };

    home-manager.users."${config.profile.username}" = { config, ... }: {
      home = {
        packages = with pkgs; [
          betterlockscreen
          deadd-notification-center
          feh
          gnome.nautilus
          gucharmap
          libnotify
          lxappearance
          playerctl
          scrot
          xclip
        ];
      };

      programs = {
        rofi = {
          enable = true;

          font = "DejaVu Sans Mono 14";
          terminal = "wezterm";
          theme = "solarized";

          plugins = with pkgs; [
            rofi-calc
            rofi-file-browser
            rofi-mpd
            rofi-power-menu
            rofi-pulse-select
            rofi-systemd
            rofi-vpn
          ];

          extraConfig = {
            modi = "window,drun,ssh";
          };
        };
      };

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

        polybar = {
          enable = true;
          script = "polybar general &";

          package = pkgs.polybar.override {
            i3Support = true;
            mpdSupport = true;
            iwSupport = true;
            pulseSupport = true;
            githubSupport = true;
          };

          settings =
            let
              icons = {
                powerOff = "";
                xmark = "";
                microchip = "";
                memory = "";
                batteryBolt = "";
                batteryHalf = "";
                batteryFull = "";
                batteryExclamation = "";
                volumeHigh = "";
                volumeSlash = "";
                wifi = "";
                wifiSlash = "";
                ethernet = "";
                calendar = "";
                clock = "";

                terminal = "";
                code = "";
                chrome = "";
                envelope = "";
                music = "";
                comment = "";
                question = "?";
              };

              fonts = {
                font-0 = "DejaVu Sans Mono:size=14:style=Regular;0";
                font-1 = "Font Awesome 6 Free Solid:size=12:style=Solid;-1";
                font-2 = "FontAwesome:size=12:style=Regular;-2";
              };

            in
            {
              "colors" = {
                background = "#002b36";
                background-alt = "#073642";
                foreground = "#93a1a1";
                foreground-alt = "#eee8d5";
                primary = "#ffb52a";
                secondary = "#e60053";
                alert = "#bd2c40";
                red = "#dc322f";
              };

              "bar/general" = fonts // {
                width = "100%";
                height = 43;
                radius = 0;

                fixed-center = true;

                background = "\${colors.background}";
                foreground = "\${colors.foreground}";

                line-size = 3;
                line-color = "#f00";

                border-size = 5;
                border-color = "#000000";

                padding-left = 0;
                padding-right = 2;

                module-margin-left = 2;
                module-margin-right = 2;

                modules-left = "i3";
                modules-center = "";
                modules-right = "cpu memory volume wireless wired battery date";

                tray-position = "right";
                tray-padding = 2;
                tray-background = "#0063ff";

                wm-restack = "i3";
                scroll-up = "i3wm-wsnext";
                scroll-down = "i3wm-wsprev";
              };

              "module/i3" = {
                type = "internal/i3";
                strip-wsnumbers = true;

                ws-icon-0 = "1;${icons.terminal}";
                ws-icon-1 = "2;${icons.code}";
                ws-icon-2 = "3;${icons.chrome}";
                ws-icon-3 = "4;${icons.envelope}";
                ws-icon-4 = "5;${icons.music}";
                ws-icon-5 = "6;${icons.comment}";
                ws-icon-6 = "7:${icons.question}";
                ws-icon-7 = "8:${icons.question}";
                ws-icon-8 = "9:${icons.question}";
                ws-icon-default = "${icons.question}";

                label-mode = "%mode%";
                label-mode-padding = 2;
                label-mode-underline = "\${colors.foreground}";
                # label-mode-background = "#e60053";

                label-focused = "%icon%";
                label-focused-padding = 4;
                label-focused-underline = "\${colors.foreground}";
                # label-focused-foreground = "#ffffff";
                # label-focused-background = "#3f3f3f";

                label-unfocused = "%icon%";
                label-unfocused-padding = 4;
                label-unfocused-underline = "\${colors.foreground}";

                label-visible = "%icon%";
                label-visible-padding = 4;
                label-visible-underline = "\${colors.foreground}";

                label-urgent = "%icon%";
                label-urgent-padding = 4;
                label-urgent-underline = "\${colors.foreground}";
                # label-urgent-foreground = "#000000";
                # label-urgent-background = "#bd2c40";

                label-separator = "";
                label-separator-padding = 0;
                label-separator-underline = "\${colors.foreground}";
                # label-separator-foreground = "#ffb52a";
              };

              "module/cpu" = {
                type = "internal/cpu";
                format = "${icons.microchip}  <label>";
                format-underline = "\${colors.foreground}";
                label = "%percentage%%";
                label-warn = "%percentage%%";
              };

              "module/memory" = {
                type = "internal/memory";
                format = "${icons.memory}  <label>";
                format-underline = "\${colors.foreground}";
                label = "%percentage_used%%";
                label-warn = "%percentage_used%%";
              };

              "module/volume" = {
                type = "internal/pulseaudio";
                use-ui-max = true;

                format-volume = "${icons.volumeHigh}  <label-volume>";
                format-volume-underline = "\${colors.foreground}";
                label-volume = "%percentage%%";

                format-muted = "${icons.volumeHigh}  <label-muted>";
                format-muted-underline = "\${colors.secondary}";
                label-muted = "%percentage%%";
              };

              "module/wireless" = {
                type = "internal/network";
                interface = "wlp2s0";
                interface-type = "wireless";

                format-connected = "${icons.wifi}  <label-connected>";
                format-connected-underline = "\${colors.foreground}";
                label-connected = "%signal%%";

                format-disconnected = "${icons.wifiSlash}  <label-disconnected>";
                format-disconnected-underline = "\${colors.secondary}";
                label-disconnected = "N/A";
              };

              "module/wired" = {
                type = "internal/network";
                interface = "enp0s25";
                interface-type = "wired";

                format-connected = "${icons.ethernet}  <label-connected>";
                format-connected-underline = "\${colors.foreground}";
                label-connected = "%ifname%";

                format-disconnected = "${icons.ethernet}  <label-disconnected>";
                format-disconnected-underline = "\${colors.secondary}";
                label-disconnected = "N/A";
              };

              "module/battery" = {
                type = "internal/battery";
                full-at = 98;
                low-at = 10;
                battery = "CMB1";
                adapter = "ADP1";

                format-full = "${icons.batteryFull}  <label-full>";
                format-full-underline = "\${colors.foreground}";
                label-full = "%percentage%%";

                format-charging = "${icons.batteryBolt}  <label-charging>";
                format-charging-underline = "\${colors.foreground}";
                label-charging = "%percentage%%";

                format-discharging = "${icons.batteryHalf}  <label-discharging>";
                format-discharging-underline = "\${colors.foreground}";
                label-discharging = "%percentage%%";

                format-low = "${icons.batteryExclamation}  <label-low>";
                format-low-underline = "\${colors.secondary}";
                label-low = "%percentage%%";
              };

              "module/date" = {
                type = "internal/date";

                date = "";
                date-alt = "${icons.calendar}  %Y-%m-%d ";

                time = "${icons.clock}  %H:%M";
                time-alt = "${icons.clock}  %H:%M:%S";

                format-prefix = "";
                format-prefix-foreground = "\${colors.foreground-alt}";
                format-underline = "\${colors.foreground}";

                label = "%date%%time%";
              };
            };
        };

        gnome-keyring = {
          enable = true;
        };
      };

      xsession = {
        enable = true;

        windowManager = {
          i3 = {
            enable = true;
            package = pkgs.i3-gaps;

            config = {
              bars = mkDefault [ ];
              modes = mkDefault { };

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
                  command = "feh --no-fehbg --bg-scale $HOME/.wallpapers/tower.jpg";
                  always = false;
                  notification = false;
                }
                {
                  command = "betterlockscreen --update $HOME/.wallpapers/tower.jpg";
                  always = false;
                  notification = false;
                }
                {
                  command = "systemctl --user restart polybar";
                  always = true;
                  notification = false;
                }
                # {
                #   command = "systemctl --user restart dunst";
                #   always = true;
                #   notification = false;
                # }
                {
                  command = "systemctl --user restart udiskie";
                  always = true;
                  notification = false;
                }
                {
                  command = "systemctl --user restart nm-applet";
                  always = true;
                  notification = false;
                }
                {
                  command = "systemctl --user restart blueman-applet";
                  always = true;
                  notification = false;
                }

                {
                  command = "deadd-notification-center";
                  always = false;
                  notification = false;
                }

                # {
                #   command = "clockify";
                #   always = false;
                #   notification = false;
                # }
              ] ++ (map (i: { command = i.exec; notification = false; }) programs.term) ++ (map (i: { command = i.exec; notification = false; }) programs.editor) ++ (map (i: { command = i.exec; notification = false; }) programs.browser) ++ (map (i: { command = i.exec; notification = false; }) programs.mail) ++ (map (i: { command = i.exec; notification = false; }) programs.music) ++ (map (i: { command = i.exec; notification = false; }) programs.chat);

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

              keybindings = {
                "XF86AudioPlay" = "exec --no-startup-id playerctl play-pause";
                "XF86AudioPrev" = "exec --no-startup-id playerctl previous";
                "XF86AudioNext" = "exec --no-startup-id playerctl next";
                "XF86AudioStop" = "exec --no-startup-id playerctl stop";

                "XF86AudioRaiseVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +5%";
                "XF86AudioLowerVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -5%";
                "XF86AudioMute" = "exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle";
                "XF86AudioMicMute" = "exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle";

                "XF86MonBrightnessUp" = "exec --no-startup-id light -A 5";
                "XF86MonBrightnessDown" = "exec --no-startup-id light -U 5";

                "--release Print" = "exec --no-startup-id scrot";
                "--release Shift+Print" = "exec --no-startup-id scrot -u";
                "--release Ctrl+Print" = "exec --no-startup-id scrot -s";

                "Mod4+d" = "exec --no-startup-id rofi -show drun";
                "Mod4+Return" = "exec wezterm";
                "Mod4+Shift+q" = "kill";

                "Mod4+Left" = "focus left";
                "Mod4+Down" = "focus down";
                "Mod4+Up" = "focus up";
                "Mod4+Right" = "focus right";

                "Mod4+Shift+Left" = "move left";
                "Mod4+Shift+Down" = "move down";
                "Mod4+Shift+Up" = "move up";
                "Mod4+Shift+Right" = "move right";

                "Mod4+h" = "split h";
                "Mod4+v" = "split v";
                "Mod4+f" = "fullscreen toggle";

                "Mod4+s" = "layout stacking";
                "Mod4+w" = "layout tabbed";
                "Mod4+e" = "layout toggle split";

                "Mod4+Shift+Space" = "floating toggle";
                "Mod4+Space" = "focus mode_toggle";

                "Mod4+1" = "workspace number 1";
                "Mod4+2" = "workspace number 2";
                "Mod4+3" = "workspace number 3";
                "Mod4+4" = "workspace number 4";
                "Mod4+5" = "workspace number 5";
                "Mod4+6" = "workspace number 6";
                "Mod4+7" = "workspace number 7";
                "Mod4+8" = "workspace number 8";
                "Mod4+9" = "workspace number 9";

                "Mod4+Shift+1" = "move container to workspace number 1";
                "Mod4+Shift+2" = "move container to workspace number 2";
                "Mod4+Shift+3" = "move container to workspace number 3";
                "Mod4+Shift+4" = "move container to workspace number 4";
                "Mod4+Shift+5" = "move container to workspace number 5";
                "Mod4+Shift+6" = "move container to workspace number 6";
                "Mod4+Shift+7" = "move container to workspace number 7";
                "Mod4+Shift+8" = "move container to workspace number 8";
                "Mod4+Shift+9" = "move container to workspace number 9";

                "Mod4+Shift+c" = "reload";
                "Mod4+Shift+r" = "restart";
              };
            };

            extraConfig = ''
              set $power "[l]ock log[o]ut [s]uspend [h]ibernate [r]eboot [p]oweroff"

              mode $power {
                  bindsym l exec betterlockscreen --lock dim; mode "default"
                  bindsym o exec i3-msg exit; mode "default"
                  bindsym s exec systemctl suspend; mode "default"
                  bindsym h exec systemctl hibernate; mode "default"
                  bindsym r exec systemctl reboot; mode "default"
                  bindsym p exec systemctl poweroff; mode "default"

                  bindsym Return mode "default"
                  bindsym Escape mode "default"
                  bindsym Mod4+n mode "default"
              }

              mode "resize" {
                  bindsym Left resize shrink width 10 px or 10 ppt
                  bindsym Down resize grow height 10 px or 10 ppt
                  bindsym Up resize shrink height 10 px or 10 ppt
                  bindsym Right resize grow width 10 px or 10 ppt

                  bindsym Return mode "default"
                  bindsym Escape mode "default"
                  bindsym Mod4+r mode "default"
              }

              bindsym Mod4+n mode $power
              bindsym Mod4+r mode "resize"
            '';
          };
        };
      };
    };
  };
}
