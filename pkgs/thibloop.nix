{ stdenv, fetchurl, autoPatchelfHook, installShellFiles, makeWrapper, jre, lib
, zlib }:

stdenv.mkDerivation rec {
  pname = "thibloop";
  version = "1.6.0-2";

  platform = "x86_64-pc-linux";

  # bloop-bash = fetchurl {
  #   url =
  #     "https://github.com/scalacenter/bloop/releases/download/v${version}/bash-completions";
  #   sha256 = "sha256-2mt+zUEJvQ/5ixxFLZ3Z0m7uDSj/YE9sg/uNMjamvdE=";
  # };
  #
  # bloop-fish = fetchurl {
  #   url =
  #     "https://github.com/scalacenter/bloop/releases/download/v${version}/fish-completions";
  #   sha256 = "sha256-eFESR6iPHRDViGv+Fk3sCvPgVAhk2L1gCG4LnfXO/v4=";
  # };
  #
  # bloop-zsh = fetchurl {
  #   url =
  #     "https://github.com/scalacenter/bloop/releases/download/v${version}/zsh-completions";
  #   sha256 = "sha256-WNMsPwBfd5EjeRbRtc06lCEVI2FVoLfrqL82OR0G7/c=";
  # };

  thibloop-binary = fetchurl {
    url =
      "https://github.com/scalacenter/bloop/releases/download/v1.6.0/bloop-x86_64-pc-linux";
    sha256 = "sha256-f7ZmjDO8L3hcYkaxiwf5BBD44hBiBhNovylM4B308bI=";
  };

  dontUnpack = true;
  nativeBuildInputs = [ installShellFiles makeWrapper ]
    ++ lib.optional stdenv.isLinux autoPatchelfHook;
  buildInputs = [ stdenv.cc.cc.lib zlib ];
  propagatedBuildInputs = [ jre ];

  installPhase = ''
    runHook preInstall

    install -D -m 0755 ${thibloop-binary} $out/thibloop

    makeWrapper $out/thibloop $out/bin/thibloop

    #Install completions

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://scalacenter.github.io/bloop/";
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    license = licenses.asl20;
    description =
      "Scala build server and command-line tool to make the compile and test developer workflows fast and productive in a build-tool-agnostic way";
    mainProgram = "thibloop";
    platforms = [ "x86_64-linux" ];
    maintainers = with maintainers; [ kubukoz tomahna ];
  };
}
