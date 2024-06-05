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

    aliases = {
      a = "add";
      c = "commit";
      ca = "commit --amend";
      can = "commit --amend --no-edit";
      cl = "clone";
      cm = "commit -m";
      co = "checkout";
      cp = "cherry-pick";
      cpx = "cherry-pick -x";
      d = "diff";
      f = "fetch";
      fo = "fetch origin";
      fu = "fetch upstream";
      lol = "log --graph --decorate --pretty=oneline --abbrev-commit";
      lola = "log --graph --decorate --pretty=oneline --abbrev-commit --all";
      pl = "pull";
      pr = "pull -r";
      ps = "push";
      psf = "push -f";
      rb = "rebase";
      rbi = "rebase -i";
      r = "remote";
      ra = "remote add";
      rr = "remote rm";
      rv = "remote -v";
      rs = "remote show";
      st = "status";
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
