{ pkgs, lib, config, options, ... }:

{
  config = with lib; {
    programs = {
      zsh = {
        enable = true;
      };
    };
  };
}
