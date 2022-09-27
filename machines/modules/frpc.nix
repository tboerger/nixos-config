{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.services.frpc;

in
{
  options.services.frpc = {
    enable = mkEnableOption "frpc";

    user = mkOption {
      type = types.str;
      default = "frpc";
      description = ''
        User under which frpc runs.
      '';
    };

    group = mkOption {
      type = types.str;
      default = "frpc";
      description = ''
        Group under which frpc runs.
      '';
    };

    package = mkOption {
      type = types.package;
      default = pkgs.frp;
      defaultText = "pkgs.frp";
      description = ''
        The frp package to use.
      '';
    };





    # debug = mkOption {
    #   type = types.bool;
    #   default = false;
    #   description = ''
    #     Turns on more logs.
    #   '';
    # };

    # interval = mkOption {
    #   type = types.str;
    #   default = "2m";
    #   description = ''
    #     How often apps are polled, recommended 1m to 5m
    #   '';
    # };

    # startDelay = mkOption {
    #   type = types.str;
    #   default = "1m";
    #   description = ''
    #     Files are queued at least this long before extraction
    #   '';
    # };

    # retryDelay = mkOption {
    #   type = types.str;
    #   default = "5m";
    #   description = ''
    #     Failed extractions are retried after at least this long
    #   '';
    # };

    # maxRetries = mkOption {
    #   type = types.int;
    #   default = 3;
    #   description = ''
    #     Times to retry failed extractions. `0` = unlimited.
    #   '';
    # };

    # parallel = mkOption {
    #   type = types.int;
    #   default = 1;
    #   description = ''
    #     Concurrent extractions, 1 is recommended.
    #   '';
    # };

    # fileMode = mkOption {
    #   type = types.str;
    #   default = "0644";
    #   description = ''
    #     Extracted files are written with this mode
    #   '';
    # };

    # dirMode = mkOption {
    #   type = types.str;
    #   default = "0755";
    #   description = ''
    #     Extracted folders are written with this mode
    #   '';
    # };

    # folder = {
    #   path = mkOption {
    #     type = types.str;
    #     default = "";
    #     description = ''
    #       folder path, not for Starr apps.
    #     '';
    #   };
    #   extractPath = mkOption {
    #     type = types.str;
    #     default = "";
    #     description = ''
    #       Where to extract to, Defaults to <option>services.unpackerr.folder.path</option>.
    #     '';
    #   };
    #   deleteAfter = mkOption {
    #     type = types.str;
    #     default = "";
    #     example = "10m";
    #     description = ''
    #       Delete extracted files and/or archives after this duration, `0` to disable.
    #     '';
    #   };
    #   deleteOrginal = mkOption {
    #     type = types.bool;
    #     default = false;
    #     description = ''
    #       Delete archives after extraction
    #     '';
    #   };
    #   deleteFiles = mkOption {
    #     type = types.bool;
    #     default = false;
    #     description = ''
    #       Delete extracted files after successful extraction
    #     '';
    #   };
    #   moveBack = mkOption {
    #     type = types.bool;
    #     default = false;
    #     description = ''
    #       Move extracted items back into original folder
    #     '';
    #   };
    # };

    # extraConfig = mkOption {
    #   type = types.attrs;
    #   default = {};
    #   description = ''
    #     Extra environment variables
    #   '';
    #   example = {
    #     UN_WEBHOOK_0_URL = "http://example.com";
    #   };
    # };





  };

  config = mkIf cfg.enable {





    # users.groups = mkIf (cfg.group == "frpc") {
    #   frpc = { };
    # };

    # users.users = mkIf (cfg.user == "frpc") {
    #   frpc = {
    #     group = cfg.group;
    #     shell = pkgs.bashInteractive;
    #     createHome = false;
    #     description = "frpc user";
    #     isSystemUser = true;
    #   };
    # };

    # systemd.services.frpc = {
    #   wantedBy = [ "multi-user.target" ];
    #   after = [ "network.target" ];
    #   description = "frpc system service";





    #   environment = filterAttrs (n: v: stringLength v > 0) {
    #     # General options
    #     UN_DEBUG = "${toString cfg.debug}";
    #     UN_INTERVAL = "${cfg.interval}";
    #     UN_START_DELAY = "${cfg.startDelay}";
    #     UN_RETRY_DELAY = "${cfg.retryDelay}";
    #     UN_MAX_RETRIES = "${toString cfg.maxRetries}";
    #     UN_PARALLEL = "${toString cfg.parallel}";
    #     UN_FILE_MODE = "${cfg.fileMode}";
    #     UN_DIR_MODE = "${cfg.dirMode}";

    #     # Sonarr
    #     UN_SONARR_0_URL = "${cfg.sonarr.url}";
    #     UN_SONARR_0_API_KEY = "${cfg.sonarr.apiKey}";
    #     UN_SONARR_0_PATHS_0 = "${cfg.sonarr.paths}";
    #     UN_SONARR_0_PROTOCOLS = "${cfg.sonarr.protocols}";
    #     UN_SONARR_0_TIMEOUT = "${cfg.sonarr.timeout}";
    #     UN_SONARR_0_DELETE_ORIG = "${toString cfg.sonarr.deleteOrginal}";
    #     UN_SONARR_0_DELETE_DELAY = "${cfg.sonarr.deleteDelay}";

    #     # Radarr
    #     UN_RADARR_0_URL = "${cfg.radarr.url}";
    #     UN_RADARR_0_API_KEY = "${cfg.radarr.apiKey}";
    #     UN_RADARR_0_PATHS_0 = "${cfg.radarr.paths}";
    #     UN_RADARR_0_PROTOCOLS = "${cfg.radarr.protocols}";
    #     UN_RADARR_0_TIMEOUT = "${cfg.radarr.timeout}";
    #     UN_RADARR_0_DELETE_ORIG = "${toString cfg.radarr.deleteOrginal}";
    #     UN_RADARR_0_DELETE_DELAY = "${cfg.radarr.deleteDelay}";

    #     # Lidarr
    #     UN_LIDARR_0_URL = "${cfg.lidarr.url}";
    #     UN_LIDARR_0_API_KEY = "${cfg.lidarr.apiKey}";
    #     UN_LIDARR_0_PATHS_0 = "${cfg.lidarr.paths}";
    #     UN_LIDARR_0_PROTOCOLS = "${cfg.lidarr.protocols}";
    #     UN_LIDARR_0_TIMEOUT = "${cfg.lidarr.timeout}";
    #     UN_LIDARR_0_DELETE_ORIG = "${toString cfg.lidarr.deleteOrginal}";
    #     UN_LIDARR_0_DELETE_DELAY = "${cfg.lidarr.deleteDelay}";

    #     # Readarr
    #     UN_READARR_0_URL = "${cfg.readarr.url}";
    #     UN_READARR_0_API_KEY = "${cfg.readarr.apiKey}";
    #     UN_READARR_0_PATHS_0 = "${cfg.readarr.paths}";
    #     UN_READARR_0_PROTOCOLS = "${cfg.readarr.protocols}";
    #     UN_READARR_0_TIMEOUT = "${cfg.readarr.timeout}";
    #     UN_READARR_0_DELETE_ORIG = "${toString cfg.readarr.deleteOrginal}";
    #     UN_READARR_0_DELETE_DELAY = "${cfg.readarr.deleteDelay}";

    #     # Folder
    #     UN_FOLDER_0_PATH = "${cfg.folder.path}";
    #     UN_FOLDER_0_EXTRACT_PATH = "${cfg.folder.extractPath}";
    #     UN_FOLDER_0_DELETE_AFTER = "${cfg.folder.deleteAfter}";
    #     UN_FOLDER_0_DELETE_ORIGINAL = "${toString cfg.folder.deleteOrginal}";
    #     UN_FOLDER_0_DELETE_FILES = "${toString cfg.folder.deleteFiles}";
    #     UN_FOLDER_0_MOVE_BACK = "${toString cfg.folder.moveBack}";
    #   } // cfg.extraConfig;




    #   serviceConfig = {
    #     User = cfg.user;
    #     Group = cfg.group;
    #     Type = "simple";
    #     Restart = "on-failure";
    #     ExecStart = "${cfg.package}/bin/frpc -c ";
    #   };
    # };
  };
}
