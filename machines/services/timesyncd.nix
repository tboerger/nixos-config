{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.personal.services.timesyncd;

in
{
  options = {
    personal = {
      services = {
        timesyncd = {
          enable = mkEnableOption "Timesyncd" // {
            default = true;
          };
        };
      };
    };
  };

  config = mkIf cfg.enable {
    services = {
      timesyncd = {
        enable = true;
      };
    };
  };
}
