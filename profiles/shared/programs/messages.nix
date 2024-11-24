{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.messages;

in
{
  options = {
    profile = {
      programs = {
        messages = {
          enable = mkEnableOption "Messages";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        discord
        element-desktop
        ferdium
        mattermost-desktop
        revolt-desktop
        rocketchat-desktop
        signal-desktop
        skypeforlinux
        slack
        teams-for-linux
        telegram-desktop
        whatsapp-for-linux
      ];
    };
  };
}
