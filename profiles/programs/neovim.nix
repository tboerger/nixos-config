{ pkgs, lib, config, options, ... }:

let
  cfg = config.profile.programs.neovim;

in
{
  options = with lib; {
    profile = {
      programs = {
        neovim = {
          enable = mkEnableOption "Neovim" // {
            default = true;
          };
        };
      };
    };
  };

  config = with lib; mkIf cfg.enable {
    home-manager.users."${config.profile.username}" = { config, ... }: {
      programs = {
        neovim = {
          enable = true;
        };
      };
    };
  };
}
