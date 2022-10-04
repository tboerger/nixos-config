{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.onepassword;

in
{
  options = {
    profile = {
      programs = {
        onepassword = {
          enable = mkEnableOption "1Password";
        };
      };
    };
  };

  config = mkIf cfg.enable {
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
