{ pkgs, lib, config, options, ... }:

{
  imports = [
    ./blueman.nix
    ./caffeine.nix
    ./flameshot.nix
    ./mopidy.nix
    ./nextcloud.nix
    ./nmapplet.nix
    ./udiskie.nix
  ];

  options = {
    profile = {
      services = { };
    };
  };
}
