{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.develop;

  ansible-doctor = pkgs.ansible-doctor.overrideAttrs (final: prev: {
    postPatch = prev.postPatch + ''
      substituteInPlace pyproject.toml \
        --replace 'colorama = "0.4.5"' 'colorama = "*"'
    '';
  });

  ansible-later = pkgs.ansible-later.overrideAttrs (final: prev: {
    postPatch = prev.postPatch + ''
      substituteInPlace pyproject.toml \
        --replace 'colorama = "0.4.5"' 'colorama = "*"'
    '';
  });

  checkov = pkgs.checkov.overrideAttrs (final: prev: {
    disabledTests = prev.disabledTests ++ [
      "test_file_with_class_attribute"
      "test_file_with_class_const"
      "test_dataclass_skip"
    ];
  });

  python310 = pkgs.python310.withPackages (p: with p; [
    ansible-core
    boto3
    botocore
    passlib
    requests
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
        python310

        ansible
        ansible-doctor
        ansible-later
        ansible-lint

        act
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

        checkov
        terraform
        terragrunt
        tflint
        tfsec

        nodejs-18_x
        yarn
      ];
    };
  };
}
