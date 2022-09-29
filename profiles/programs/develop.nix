{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.develop;

  python = pkgs.python39.withPackages (p: with p; [
    ansible-core
    ansible-doctor
    # ansible-later
    ansible-lint
    boto3
    botocore
    hcloud
    passlib
    requests
    yamllint
  ]);

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
        python

        php80
        php80Packages.composer

        nodejs-16_x
        yarn

        act
        awscli2
        eksctl
        git-chglog
        gopass
        graphviz
        httpie
        ipcalc
        ngrok
        pwgen
        reflex
        shellcheck
        sops
        terraform
        terragrunt
        upx
      ];
    };
  };
}
