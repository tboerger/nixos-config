{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.desktop.i3;

  programs = {
    term = [
      {
        exec = "Alacritty";
        class = "Alacritty";
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
        exec = "thunderbird";
        class = "thunderbird";
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
        ];
      };

      services = {
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
                "Mod4+Return" = "exec alacritty";
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
