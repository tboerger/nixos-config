let
  thomas = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINaQYR0/Oj6k1H03kshz2J7rlGCaDSuaGPhhOs9FcZfn";
  users = [ thomas ];

  chnum = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFmxTCjjLZL+pFZU1A8ylZbMPF8SD5NtkJ001z2mx0i4";
  niflheim = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPnWrIfgpMSyCOwEEb1onBYyJ/+NOTm+FXAacYoYKba9";
  midgard = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICGC6aSeeKiMO9y3NMxPOh2JvvGYcyS4za+0+hSqI3Bj";
  asgard = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE2yYJUssGAmPBv5QBQJTZfwyl0HSgYMQjssG2hjk63+";
  utgard = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDv7Ua1agDUdEo+0uSr99qlhFGsyte+jgf1Z3M+veuq7";
  systems = [ chnum niflheim midgard asgard utgard ];
in
{
  "services/acme/credentials.age".publicKeys = users ++ systems;
  "services/mopidy/jellyfin.age".publicKeys = users ++ systems;
  "services/nixbuild/sshkey.age".publicKeys = users ++ systems;
  "services/tailscale/authkey.age".publicKeys = users ++ systems;

  "users/media/password.age".publicKeys = users ++ systems;
  "users/media/smbpasswd.age".publicKeys = users ++ systems;

  "users/printer/password.age".publicKeys = users ++ systems;
  "users/printer/smbpasswd.age".publicKeys = users ++ systems;

  "users/root/password.age".publicKeys = users ++ systems;
  "users/admin/password.age".publicKeys = users ++ systems;

  "users/thomas/password.age".publicKeys = users ++ systems;
  "users/anna/password.age".publicKeys = users ++ systems;
  "users/adrian/password.age".publicKeys = users ++ systems;
  "users/tabea/password.age".publicKeys = users ++ systems;

  "users/thomas/hackthebox.age".publicKeys = users ++ systems;
}
