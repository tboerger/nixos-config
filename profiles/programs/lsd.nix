{ pkgs, lib, config, options, ... }:

let
  cfg = config.profile.programs.lsd;

in
{
  options = with lib; {
    profile = {
      programs = {
        lsd = {
          enable = mkEnableOption "Lsd" // {
            default = true;
          };
        };
      };
    };
  };

  config = with lib; mkIf cfg.enable {
    home-manager.users."${config.profile.username}" = { config, ... }: {
      programs = {
        lsd = {
          enable = true;
          enableAliases = true;
        };
      };
    };
  };
}
