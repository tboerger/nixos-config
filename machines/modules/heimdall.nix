{ pkgs, lib, config, options, ... }:

let
  cfg = config.services.heimdall;

in
{
  options = with lib; {
    services.heimdall = {
      enable = mkEnableOption "Heimdall";
    };
  };

  # config = with lib; mkIf cfg.enable {
  #   environment = {
  #     systemPackages = with pkgs; [
  #       heimdall
  #     ];
  #   };
  # };
}
