{ pkgs, lib, config, options, ... }:

let
  cfg = config.my.modules.boot;

in

{
  options = with lib; {
    my = {
      modules = {
        boot = {
          enable = mkEnableOption ''
            Whether to enable boot module
          '';
        };
      };
    };
  };

  config = with lib;
    mkIf cfg.enable {
      boot = {
        kernelPackages = pkgs.linuxPackages_latest;
        cleanTmpDir = true;

        loader = {
          efi = {
            canTouchEfiVariables = true;
          };

          systemd-boot = {
            enable = true;
            consoleMode = "2";
            editor = false;
          };
        };
      };
    };
}
