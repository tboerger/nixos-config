{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.services.mopidy;

in
{
  options = {
    profile = {
      services = {
        mopidy = {
          enable = mkEnableOption "Mopidy";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        ymuse
      ];
    };

    home-manager.users."${config.profile.username}" = { config, ... }: {
      programs = {
        ncmpcpp = {
          enable = true;
        };
      };

      services = {
        mopidy = {
          enable = true;

          extensionPackages = with pkgs; [
            mopidy-iris
            mopidy-jellyfin
            mopidy-mpd
            mopidy-tunein
          ];

          # extraConfigFiles = [
          #   config.age.secrets."services/mopidy/jellyfin".path
          # ];
        };
      };
    };

    # age.secrets."services/mopidy/jellyfin" = {
    #   file = ../../secrets/services/mopidy/jellyfin.age;
    #   owner = config.profile.username;
    # };
  };
}
