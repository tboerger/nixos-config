{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.personal.programs.password;

in
{
  options = {
    personal = {
      programs = {
        password = {
          enable = mkEnableOption "Password";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        pwgen
      ];
    };

    programs = {
      _1password = {
        enable = true;
      };

      _1password-gui = {
        enable = true;
      };
    };
  };
}
