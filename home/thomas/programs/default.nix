{ pkgs, lib, config, options, ... }:

{
  imports = [
    ./autorandr.nix
    ./git.nix
    ./github.nix
    ./gopass.nix
    ./minio.nix
    ./netrc.nix
    ./ssh.nix
    ./vscode.nix
  ];
}
