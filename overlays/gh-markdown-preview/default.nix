{ lib, fetchFromGitHub, buildGoModule }:

buildGoModule rec {
  pname = "gh-markdown-preview";
  version = "1.4.1";

  src = fetchFromGitHub {
    owner = "yusukebe";
    repo = "gh-markdown-preview";
    rev = "v${version}";
    sha256 = "sha256-Q+e3j+X/ZsLdkTBkuu028Rl4iw+oES2w6CDQiwN+CtU=";
  };

  vendorHash = "sha256-O6Q9h5zcYAoKLjuzGu7f7UZY0Y5rL2INqFyJT2QZJ/E=";

  ldflags = [
    "-s"
    "-w"
    "-X github.com/yusukebe/gh-markdown-preview/cmd.Version=${version}"
  ];

  doCheck = false;

  meta = with lib; {
    homepage = "https://github.com/yusukebe/gh-markdown-preview";
    description = "gh extension to preview markdown looks like GitHub";
    license = licenses.mit;
    maintainers = with maintainers; [ tboerger ];
  };
}
