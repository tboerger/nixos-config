{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.personal.programs.browser;

in
{
  options = {
    personal = {
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
