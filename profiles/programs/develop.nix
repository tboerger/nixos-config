{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.develop;

  # ansible-doctor = pkgs.ansible-doctor.overrideAttrs (final: prev: {
  #   postPatch = ''
  #     substituteInPlace pyproject.toml \
  #       --replace 'version = "0.0.0"' 'version = "${prev.version}"' \
  #       --replace 'colorama = "9.4.5"' 'colorama = "*"'
  #   '';
  # });

  # python = pkgs.python39.withPackages (p: with p; [
  #   ansible-core
  #   ansible-doctor
  #   ansible-later
  #   ansible-lint
  #   boto3
  #   botocore
  #   hcloud
  #   passlib
  #   requests
  #   yamllint
  # ]);

in
{
  options = {
    profile = {
      programs = {
        develop = {
          enable = mkEnableOption "Develop";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        # python

        act
        # ansible-doctor
        ansible-later
        ansible-lint
        awscli2
        eksctl
        git-chglog
        gopass
        graphviz
        hcloud
        httpie
        ipcalc
        ngrok
        pwgen
        reflex
        shellcheck
        sops
        upx
        yamllint

        # checkov
        terraform
        terragrunt
        tflint
        tfsec

        nodejs-16_x
        yarn
      ];
    };
  };
}
