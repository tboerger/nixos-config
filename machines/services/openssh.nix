{ pkgs, lib, config, options, ... }:

let
  cfg = config.personal.services.openssh;

in
{
  options = with lib; {
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

  config = with lib; mkIf cfg.enable {
      services = {
        openssh = {
          enable = true;
          permitRootLogin = "yes";
        };
      };
    };
}
