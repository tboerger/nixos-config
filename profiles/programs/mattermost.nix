{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.mattermost;

in
{
  options = {
    profile = {
      programs = {
        mattermost = {
          enable = mkEnableOption "Mattermost";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        mattermost
      ];
    };
  };
}
