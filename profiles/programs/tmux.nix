{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.tmux;

in
{
  options = {
    profile = {
      programs = {
        tmux = {
          enable = mkEnableOption "Tmux" // {
            default = true;
          };
        };
      };
    };
  };

  config = mkIf cfg.enable {
    home-manager.users."${config.profile.username}" = { config, ... }: {
      programs = {
        tmux = {
          enable = true;
          clock24 = true;

          tmuxinator = {
            enable = true;
          };
        };
      };
    };
  };
}
