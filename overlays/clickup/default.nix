{ lib, fetchurl, appimageTools }:

appimageTools.wrapType2 rec {
  pname = "clickup";
  version = "3.1.2";

  src = fetchurl {
    url = "https://desktop.clickup.com/linux";
    sha256 = "sha256-Qkvs01L9qfvZ5E9BnLdw2oWYaL5tYR3faFjlv6pAY2Y=";
  };

  meta = with lib; {
    description = "All of your work in one place: Tasks, Docs, Chat, Goals, & more.";
    homepage = "https://clickup.com/";
    license = licenses.unfree;
    maintainers = with maintainers; [ tboerger ];
    platforms = platforms.linux;
  };
}
