{ pkgs, lib, config, options, ... }:

{
  config = {
    boot = {
      kernelPackages = pkgs.linuxPackages;
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
