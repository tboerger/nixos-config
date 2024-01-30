{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.terraform;

in
{
  options = {
    profile = {
      programs = {
        terraform = {
          enable = mkEnableOption "Terraform";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        terraform
        terraform-docs
        tflint
        tfsec
      ];
    };
  };
}
