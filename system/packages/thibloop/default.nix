{ stdenv, fetchurl, autoPatchelfHook, installShellFiles, makeWrapper, jre, lib
, zlib }:

stdenv.mkDerivation rec {
  pname = "thibloop";
  version = "1.6.0";

  platform = if stdenv.isLinux && stdenv.isx86_64 then
    "x86_64-pc-linux"
  else if stdenv.isDarwin && stdenv.isx86_64 then
    "x86_64-apple-darwin"
  else
    throw "unsupported platform";

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

  thibloop-binary = fetchurl rec {
    url =
      "https://github.com/scalacenter/bloop/releases/download/1.6.0/bloop-${platform}";
    sha256 = if stdenv.isLinux && stdenv.isx86_64 then
      "sha256-gfmsroHyr/xrbQ72x6LNRvIYaxgUjBOxYsyKqc0c9Oo="
    else if stdenv.isDarwin && stdenv.isx86_64 then
      "sha256-fluOkbpVy895YyWisfTaDP2yXbqF+gToc1KbVL8Mon8="
    else
      throw "unsupported platform";
  };

  dontUnpack = true;
  nativeBuildInputs = [ installShellFiles makeWrapper ]
    ++ lib.optional stdenv.isLinux autoPatchelfHook;
  buildInputs = [ stdenv.cc.cc.lib zlib ];
  propagatedBuildInputs = [ jre ];

  installPhase = ''
    runHook preInstall

    install -D -m 0755 ${thibloop-binary} $out/.thibloop-wrapped

    makeWrapper $out/.thibloop-wrapped $out/bin/thibloop

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
    platforms = [ "x86_64-linux" "x86_64-darwin" ];
    maintainers = with maintainers; [ kubukoz tomahna ];
  };
}
