{ pkgs, lib, config, options, ... }:
with lib;

{
  imports = [
    ./browser.nix
    ./mail.nix
    ./password.nix
    ./steam.nix
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
