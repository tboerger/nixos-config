{ pkgs, inputs, system, lib, ... }:

let
  username = "thomas";
  fullname = "Thomas Boerger";

in
{
  imports = [
    ../modules
    ../programs
    ../services
  ];

  profile = {
    username = "${username}";

    programs = {
      starship = {
        enable = true;
      };
      zsh = {
        enable = true;
      };
    };

    services = { };
  };








  users = {
    users = {
      "${username}" = {
        description = "${fullname}";
        shell = pkgs.zsh;
        isNormalUser = true;
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
        ];
      };
    };
  };

  home-manager.users."${username}" = { config, ... }: {
    home = {
      homeDirectory = "/home/${username}";

      sessionPath = [
        "$HOME/.local/bin"
      ];
    };
  };
}
