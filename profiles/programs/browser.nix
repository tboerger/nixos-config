{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.browser;

in
{
  options = {
    profile = {
      programs = {
        browser = {
          enable = mkEnableOption "Browser";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        firefox
        google-chrome
      ];
    };
  };
}
