{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.ghtoken;

in
{
  options = {
    profile = {
      programs = {
        ghtoken = {
          enable = mkEnableOption "GHToken";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    # home-manager.users."${config.profile.username}" = let
    #   ghtokenPath = config.age.secrets."users/thomas/ghtoken".path;
    # in { config, ... }: {
    #   home = {
    #     file = {
    #       ".ghtoken" = {
    #         source = ghtokenPath;
    #       };
    #     };
    #   };
    # };

    # age.secrets."users/thomas/ghtoken" = {
    #   file = ../../../secrets/users/thomas/ghtoken.age;
    #   owner = "thomas";
    #   group = "users";
    # };
  };
}
