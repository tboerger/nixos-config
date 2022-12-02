{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.minio;

in
{
  options = {
    profile = {
      programs = {
        minio = {
          enable = mkEnableOption "Minio";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        minio-client
      ];
    };

    # home-manager.users."${config.profile.username}" = let
    #   minioPath = config.age.secrets."users/thomas/minio".path;
    # in { config, ... }: {
    #   home = {
    #     file = {
    #       ".mc/config.json" = {
    #         source = minioPath;
    #       };
    #     };
    #   };
    # };

    # age.secrets."users/thomas/minio" = {
    #   file = ../../../secrets/users/thomas/minio.age;
    #   owner = "thomas";
    #   group = "users";
    # };
  };
}
