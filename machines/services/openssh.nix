{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.personal.services.openssh;

in
{
  options = {
    personal = {
      services = {
        openssh = {
          enable = mkEnableOption "Openssh" // {
            default = true;
          };
        };
      };
    };
  };

  config = mkIf cfg.enable {
    services = {
      openssh = {
        enable = true;
        permitRootLogin = "yes";
      };
    };
  };
}
