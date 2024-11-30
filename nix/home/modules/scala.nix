{ pkgs, ... }: {

  # https://scalacenter.github.io/bloop/docs/server-reference#custom-java-options
  home.file.".bloop/bloop.json".text = ''
    {
      "javaOptions": ["-Xms4g", "-Xmx14G", "-XX:+UseG1GC", "-Xss2m", "-XX:InitialCodeCacheSize=512m", "-XX:ReservedCodeCacheSize=512m"]
    }
  '';

  home.file = {
    "./.sbtrc".text = ''
      alias c=compile
      alias cc=~compile
      alias r=run
      alias l=reload
      alias p=project
      alias t=test
      alias tt=~testQuick
    '';
  };
}
