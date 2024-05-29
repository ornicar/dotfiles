{ ... }:

{
  programs.git = {
    enable = true;
    userName = "Thibault Duplessis";
    userEmail = "t@lichess.org";

    extraConfig = {
      core = {
        editor = "nvim";
        whitespace = "fix,-indent-with-non-tab,trailing-space,cr-at-eol";
      };
      delta = {
        enable = true;
        options = { "navigate" = true; };
      };
      web.browser = "google-chrome-stable";
      push.default = "tracking";
      push.autoSetupRemote = true;
      pull.rebase = false;
      rebase.autoStash = true;
      branch.autosetupmerge = true;
      init.defaultBranch = "master";
      rerere.enabled = true;
      color.ui = true;
      blame.date = "relative";
    };

    diff-so-fancy.enable = true;
    ignores = [
      ".idea"
      ".venv"
      ".bloop"
      ".metals"
      ".bsp"
      "project/metals.sbt"
      "project/project"
      "**/*.worksheet.sc"
    ];
  };
  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };
}
