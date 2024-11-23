{ pkgs, lib, config, options, ... }:
with lib;

{
  programs = {
    zsh = {
      enable = true;
    };
  };

  users = {
    users = {
      thomas = {
        uid = 10000;
        description = "Thomas Boerger";
        shell = pkgs.zsh;
        isNormalUser = true;
        hashedPasswordFile = config.age.secrets."users/thomas/password".path;
        openssh = {
          authorizedKeys = {
            keys = [
              "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINaQYR0/Oj6k1H03kshz2J7rlGCaDSuaGPhhOs9FcZfn Thomas Boerger"
            ];
          };
        };
        extraGroups = [
          "wheel"
          "docker"
          "libvirtd"
          "audio"
          "video"
          "networkmanager"
        ];
      };
    };
  };

  age.secrets."users/thomas/password" = {
    file = ../../secrets/users/thomas/password.age;
  };
}
