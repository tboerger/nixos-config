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
    # home-manager.users."${config.profile.username}" = let
    #   netrcPath = config.age.secrets."users/thomas/netrc".path;
    # in { config, ... }: {
    #   home = {
    #     file = {
    #       "..netrc" = {
    #         source = netrcPath;
    #       };
    #     };
    #   };
    # };

    # age.secrets."users/thomas/netrc" = {
    #   file = ../../../secrets/users/thomas/netrc.age;
    #   owner = "thomas";
    #   group = "users";
    # };
  };
}
