{ pkgs, lib, config, options, inputs, ... }:
with lib;

{
  config = {
    environment = {
      systemPackages = with pkgs; [
        coreutils
        dig
        file
        git
        gnumake
        gomplate
        htop
        hub
        hwinfo
        jq
        lsof
        nix-index
        nmap
        p7zip
        pciutils
        rsync
        s3cmd
        silver-searcher
        tldr
        tmux
        tree
        unzip
        vim
        wget
        yq
      ];
    };
  };
}
