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
          enable = mkEnableOption "Printing" // {
            default = true;
          };
        };
      };
    };
  };

  config = mkIf cfg.enable {
    services = {
      printing = {
        enable = true;

        drivers = [
          (pkgs.writeTextDir "share/cups/model/kmC35np.ppd" (builtins.readFile ./kmC35np.ppd))
        ];
      };
    };
  };
}
