{ pkgs, lib, config, options, inputs, ... }:
with lib;

{
  config = {
    environment = {
      systemPackages = with pkgs; [
        coreutils
        git
        gnumake
        gomplate
        htop
        hub
        hwinfo
        jq
        lsof
        minio-client
        nmap
        p7zip
        pciutils
        rsync
        s3cmd
        silver-searcher
        tmux
        tree
        vim
        wget
        yq
      ];
    };
  };
}
