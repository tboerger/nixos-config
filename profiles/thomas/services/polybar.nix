{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.services.polybar;

in
{
  options = {
    profile = {
      services = {
        polybar = {
          enable = mkEnableOption "Polybar";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    home-manager.users."${config.profile.username}" = { config, ... }: {
      services = {
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
      };
    };
  };
}
