{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.kube;

in
{
  options = {
    profile = {
      programs = {
        kube = {
          enable = mkEnableOption "Kube";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        argocd
        chart-testing
        clusterctl
        helm-docs
        jsonnet
        jsonnet-bundler
        k9s
        kind
        krew
        kubectl
        kubectl-images
        nur.repos.tboerger.kubectl-ktop
        nur.repos.tboerger.kubectl-neat
        nur.repos.tboerger.kubectl-oomd
        nur.repos.tboerger.kubectl-pexec
        nur.repos.tboerger.kubectl-realname-diff
        nur.repos.tboerger.kubectl-resource-versions
        nur.repos.tboerger.kubectl-view-secret
        nur.repos.tboerger.kubectl-whoami
        kubectx
        kubelogin
        kubernetes-helm
        kustomize
        kustomize-sops
        sonobuoy
        stern
        yamale
      ];
    };
  };
}
