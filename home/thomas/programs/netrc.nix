{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.netrc;

in
{
  options = {
    profile = {
      programs = {
        netrc = {
          enable = mkEnableOption "Netrc";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    homeage = {
      file."netrc" = {
        source = ../secrets/netrc.age;
        symlinks = [ "${config.home.homeDirectory}/.netrc" ];
        owner = "thomas";
        group = "users";
        mode = "0600";
      };
    };
  };
}
