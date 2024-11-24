{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.kubectl;

in
{
  options = {
    profile = {
      programs = {
        kubectl = {
          enable = mkEnableOption "Kubectl";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    home = {
      shellAliases = {
        k = "kubectl";
        kunusedrs = "kubectl get replicaset -o jsonpath=\"{ .items[?(@.spec.replicas==0)].metadata.name }\"";
      };

      packages = with pkgs; [
        argocd
        clusterctl
        fluxcd
        grafana-loki
        k9s
        kind
        kubectl
        kubectx
        kubelogin-oidc
        kubevirt
        stern

        kubectl-get-all
        kubectl-images
        kubectl-ktop
        kubectl-neat
        kubectl-oomd
        kubectl-pexec
        kubectl-realname-diff
        kubectl-resource-versions
        kubectl-split-yaml
        kubectl-view-secret
        kubectl-whoami
      ];

      file = {
        ".local/bin/kubectl-ctx" = {
          source = "${pkgs.kubectx}/bin/kubectx";
          executable = true;
        };
        ".local/bin/kubectl-ns" = {
          source = "${pkgs.kubectx}/bin/kubens";
          executable = true;
        };
        ".local/bin/kubectl-virt" = {
          source = "${pkgs.kubevirt}/bin/virtctl";
          executable = true;
        };
      };
    };
  };
}
