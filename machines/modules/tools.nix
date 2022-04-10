{ pkgs, lib, config, options, inputs, ... }:

{
  config = with lib; {
    environment = {
      systemPackages = with pkgs; [
        coreutils
        gnumake
        htop
        jq
        nmap
        rsync
        tmux
        tree
        vim
        wget
        yq

        inputs.agenix.defaultPackage.x86_64-linux
      ];
    };
  };
}
