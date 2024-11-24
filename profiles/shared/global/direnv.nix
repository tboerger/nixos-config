{ pkgs, lib, config, options, ... }:

{
  programs = {
    direnv = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;

      nix-direnv = {
        enable = true;
      };
    };
  };
}
