{ pkgs, lib, config, options, ... }:

{
  imports = [

  ];

  options = with lib; {
    profile = {
      username = mkOption {
        type = types.str;
      };
    };
  };
}
