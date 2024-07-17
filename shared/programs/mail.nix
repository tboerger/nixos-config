{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.personal.programs.mail;

in
{
  options = {
    personal = {
      programs = {
        mail = {
          enable = mkEnableOption "Mail";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        # betterbird
        mailspring
      ];
    };

    # nixpkgs = {
    #   config = {
    #     permittedInsecurePackages = [
    #       "mailspring-1.13.3"
    #     ];
    #   };
    # };
  };
}
