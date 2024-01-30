{ lib, fetchFromGitHub, buildGoModule }:

buildGoModule rec {
  pname = "gh-dash";
  version = "3.7.9";

  src = fetchFromGitHub {
    owner = "dlvhdr";
    repo = "gh-dash";
    rev = "v${version}";
    sha256 = "sha256-loAtRXns7plBeVOM+d/euyRS86MG+NRhGB4WpHT7KlM=";
  };

  vendorHash = "sha256-0ySTcQDM7Dole6ojnhr7vwUWOM4p6kFN69VqMP0jAY0=";

  ldflags = [
    "-s"
    "-w"
    "-X main.Version=${version}"
  ];

  doCheck = false;

  meta = with lib; {
    homepage = "https://github.com/dlvhdr/gh-dash";
    description = "gh extension to show a dashboard on cli";
    license = licenses.mit;
    maintainers = with maintainers; [ tboerger ];
  };
}
