{ ... }: {

  # https://scalacenter.github.io/bloop/docs/server-reference#custom-java-options

  home.file."./.sbtrc".text = ''
    alias c=compile
    alias cc=~compile
    alias r=run
    alias l=reload
    alias p=project
    alias t=test
    alias tt=~testQuick
  '';
}
