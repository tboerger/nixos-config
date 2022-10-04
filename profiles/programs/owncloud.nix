{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.owncloud;

in
{
  options = {
    profile = {
      programs = {
        owncloud = {
          enable = mkEnableOption "ownCloud";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        owncloud-client
      ];
    };
  };
}
