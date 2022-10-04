{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.gnupg;

in
{
  options = {
    profile = {
      programs = {
        gnupg = {
          enable = mkEnableOption "GnuPG";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        pinentry
      ];
    };

    home-manager.users."${config.profile.username}" = { config, ... }: {
      programs = {
        gpg = {
          enable = true;
        };
      };

      services = {
        gpg-agent = {
          enable = true;
          enableSshSupport = true;
          enableZshIntegration = true;
        };
      };
    };

    programs = {
      gnupg = {
        agent = {
          enable = true;
          enableSSHSupport = true;
        };
      };
    };
  };
}
