{ pkgs, lib, config, options, ... }:

let
  cfg = config.personal.services.haveged;

in
{
  options = with lib; {
    personal = {
      services = {
        haveged = {
          enable = mkEnableOption "Haveged" // {
            default = true;
          };
        };
      };
    };
  };

  config = with lib; mkIf cfg.enable {
      services = {
        haveged = {
          enable = true;
        };
      };
    };
}
