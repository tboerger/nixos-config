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
    age = {
      secrets = {
        netrc = {
          file = ../secrets/netrc.age;
          path = "${config.home.homeDirectory}/.netrc";
          mode = "0600";
        };
      };
    };
  };
}
