{ pkgs, lib, config, options, ... }:

let
  cfg = config.personal.services.timesyncd;

in
{
  options = with lib; {
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

  config = with lib; mkIf cfg.enable {
      services = {
        timesyncd = {
          enable = true;
        };
      };
    };
}
