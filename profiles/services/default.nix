{ pkgs, lib, config, options, ... }:

{
  imports = [
    ./blueman.nix
    ./caffeine.nix
    ./flameshot.nix
    ./mopidy.nix
    ./nmapplet.nix
    ./owncloud.nix
    ./udiskie.nix
  ];

  options = {
    profile = {
      services = { };
    };
  };
}
