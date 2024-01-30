{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.personal.services.haveged;

in
{
  options = {
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

  config = mkIf cfg.enable {
    services = {
      haveged = {
        enable = true;
      };
    };
  };
}
