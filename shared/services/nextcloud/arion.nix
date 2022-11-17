{ pkgs, lib, config, options, ... }:

{
  config = {
    services = {
      nextcloud = {
        nixos = {
          configuration = {
            services = {
              nextcloud = {
                enable = true;
              };
            };
          };
        };
      };
    };
  };
}
