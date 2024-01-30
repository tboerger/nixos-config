{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.develop;

  python310 = pkgs.python310.withPackages (p: with p; [
    boto3
    botocore
    passlib
    requests
  ]);

in
{
  options = {
    profile = {
      programs = {
        develop = {
          enable = mkEnableOption "Develop";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        python310

        ansible
        ansible-lint
        ansible-doctor
        ansible-later

        cfssl
        graphviz
        mediainfo
        neofetch
        reflex
        shellcheck
        silver-searcher
        tldr
        upx
        yamllint
      ];

      file = {
        ".local/bin/secrets-encrypt" = {
          executable = true;
          text = ''
            #!/usr/bin/env bash
            for FOLDER in $(find . -iname secrets -type d); do
                for FILE in $(find "$FOLDER" -type f -iname \*.txt); do
                    echo "-> decrypting $FILE"
                    echo bin/vault decrypt "$FILE"
                done
            done
          '';
        };
        ".local/bin/secrets-decrypt" = {
          executable = true;
          text = ''
            #!/usr/bin/env bash
            for FOLDER in $(find . -iname secrets -type d); do
                for FILE in $(find "$FOLDER" -type f -iname \*.txt); do
                    echo "-> decrypting $FILE"
                    echo bin/vault encrypt "$FILE"
                done
            done
          '';
        };

        ".local/bin/sort-requirements" = {
          executable = true;
          text = ''
            #!${pkgs.ruby}/bin/ruby
            require "yaml"

            if ARGV.length != 1
              puts "Usage: #{File.basename __FILE__} path/to/requirements.yml"
              exit 1
            end

            unless File.exist? ARGV.first
              puts "Error: Input file does not exist"
              exit 1
            end

            YAML.load_file(ARGV.first).tap do |yaml|
              if yaml.kind_of? Array
                yaml.sort! { |a, b| a["src"] <=> b["src"] }
              else
                if yaml.has_key? "roles"
                  yaml["roles"].sort! { |a, b| a["src"] <=> b["src"] }
                end

                if yaml.has_key? "collections"
                  yaml["collections"].sort! { |a, b| a["name"] <=> b["name"] }
                end
              end

              File.open(ARGV.first, "w+") do |file|
                file.write "# Standards: 1.2\n"
                if yaml.kind_of? Array
                  file.write yaml.to_yaml
                else
                  result = []

                  if yaml.has_key? "collections"
                    result.push({
                      "collections" => yaml["collections"]
                    }.to_yaml)
                  end

                  if yaml.has_key? "roles"
                    result.push({
                      "roles" => yaml["roles"]
                    }.to_yaml)
                  end

                  file.write result.join("\n")
                end

                file.write "\n...\n"
              end
            end
          '';
        };
      };
    };
  };
}
