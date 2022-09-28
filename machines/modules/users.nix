{ pkgs, lib, config, options, ... }:
with lib;

{
  config = {
    users = {
      defaultUserShell = pkgs.zsh;
      mutableUsers = false;

      users = {
        root = {
          shell = pkgs.zsh;
          hashedPassword = "$6$yuwsoikF5utqohar$fdcvq0iXdmiioiRyBGeVZICzQm4nKlv6.pj9AWh13VRCsE07dN9StDnXV0aslIBb0SWRFC4dY5Um2MYiAMfmH0";
          openssh = {
            authorizedKeys = {
              keys = [
                "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINaQYR0/Oj6k1H03kshz2J7rlGCaDSuaGPhhOs9FcZfn thomas@osiris"
              ];
            };
          };
        };
        admin = {
          shell = pkgs.zsh;
          isNormalUser = true;
          uid = 1337;
          hashedPassword = "$6$yuwsoikF5utqohar$fdcvq0iXdmiioiRyBGeVZICzQm4nKlv6.pj9AWh13VRCsE07dN9StDnXV0aslIBb0SWRFC4dY5Um2MYiAMfmH0";
          openssh = {
            authorizedKeys = {
              keys = [
                "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINaQYR0/Oj6k1H03kshz2J7rlGCaDSuaGPhhOs9FcZfn thomas@osiris"
              ];
            };
          };
          extraGroups = [
            "wheel"
            "docker"
            "libvirtd"
          ];
        };
      };
    };
  };
}
