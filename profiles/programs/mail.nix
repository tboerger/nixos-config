{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.mail;

in
{
  options = {
    profile = {
      programs = {
        mail = {
          enable = mkEnableOption "Mail";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        nur.repos.tboerger.freelook
        mailspring
      ];
    };
  };
}
