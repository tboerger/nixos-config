{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.personal.services.docker;

in
{
  options = {
    personal = {
      services = {
        docker = {
          enable = mkEnableOption "Docker";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        lazydocker
      ];
    };

    virtualisation = {
      docker = {
        enable = true;

        autoPrune = {
          enable = true;
          dates = "weekly";
        };
      };

      oci-containers = {
        backend = "docker";
      };
    };
  };
}
