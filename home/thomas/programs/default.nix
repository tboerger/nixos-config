{ pkgs, lib, config, options, ... }:

{
  imports = [
    ./git.nix
    ./github.nix
    ./gopass.nix
    ./minio.nix
    ./netrc.nix
    ./shell.nix
    ./ssh.nix
    ./vscode.nix
  ];
}
