{ lib, python3Packages, fetchFromGitLab }:

python3Packages.buildPythonApplication rec {
  pname = "coolercontrol-cli";
  version = "1.2.2";

  src = fetchFromGitLab {
    owner = "coolercontrol";
    repo = "coolercontrol";
    rev = version;
    hash = "sha256-c+MM8MAM8WSKSKECSfy/Iw7KWiWHxG75YShtv9d2Sjc=";
  };

  meta = with lib; {
    description = "Coolercontrol python cli";
    homepage = "https://gitlab.com/coolercontrol/coolercontrol";
    license = licenses.gpl3Plus;
    platforms = [ "x86_64-linux" ];
  };
  pyproject = true;

  build-system = with python3Packages; [ setuptools ];

  dependencies = with python3Packages; [ requests ];
}
