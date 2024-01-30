{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.personal.services.printing;

in
{
  options = {
    personal = {
      services = {
        printing = {
          enable = mkEnableOption "Printing";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    services = {
      printing = {
        enable = true;
        drivers = [ ];
      };
    };
  };
}
