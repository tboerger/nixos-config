{ pkgs, lib, config, options, ... }:
with lib;

{
  imports = [
    ./citrix
  ];

  options = {
    personal = {
      programs = {
        enable = mkEnableOption "Programs" // {
          default = true;
        };
      };
    };
  };
}
