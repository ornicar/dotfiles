{ ... }:
{

  programs.git = {
    enable = true;
    settings = {
      user.name = "Thibault Duplessis";
      user.email = "t@lichess.org";

      alias = {
        l =
          let
            format = "%Cred%h%Creset %Cblue%ad%Creset %Cgreen%an%Creset %s";
          in
          ''log --pretty=format:"${format}"'';
      };

      core = {
        editor = "neovide";
        whitespace = "fix,-indent-with-non-tab,trailing-space,cr-at-eol";
      };
      merge.conflictStyle = "zdiff3";
      diff.tool = "meld";
      web.browser = "firefox";
      push.default = "tracking";
      push.autoSetupRemote = true;
      pull.rebase = false;
      rebase.autoStash = true;
      branch.autosetupmerge = true;
      init.defaultBranch = "master";
      rerere.enabled = true;
      color.ui = true;
      blame.date = "relative";
      paging.colorArg = "never";
    };

    lfs.enable = true;

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

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      navigate = false;
      syntax-theme = "none";
      features = "catppuccin-mocha";
      true-color = "always";
      catppuccin-mocha = {
        blame-palette = "#1e1e2e #181825 #11111b #313244 #45475a";
        commit-decoration-style = "#6c7086 bold box ul";
        dark = true;
        file-decoration-style = "#6c7086";
        file-style = "#cdd6f4";
        hunk-header-decoration-style = "#6c7086 box ul";
        hunk-header-file-style = "bold";
        hunk-header-line-number-style = "bold #a6adc8";
        hunk-header-style = "file line-number syntax";
        minus-emph-style = "bold syntax #694559";
        minus-style = "syntax #493447";
        plus-emph-style = "bold syntax #4e6356";
        plus-style = "syntax #394545";
        map-styles = ''
          bold purple => syntax "#5b4e74",
          bold blue => syntax "#445375",
          bold cyan => syntax "#446170",
          bold yellow => syntax "#6b635b"'';
      };
    };
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };

  programs.zsh.shellAliases = {
    "t" = "lazygit";
    "g" = "git";
    "gs" = "git status";
    "ga" = "git add -A";
    "gf" = "git fetch";
    "gp" = "git push";
    "gl" = "git pull";
    "glr" = "git pull --rebase";
    "gc" = "git commit -v";
    "gca" = "git commit --amend";
    "gch" = "git commit --amend -C HEAD";
    "gac" = "git commit -av";
    "gb" = "git branch -v";
    "gba" = "git branch -va";
    "gcp" = "git cherry-pick";
    "glo" = "git l";
    "gco" = "git checkout";
    "gm" = "git merge";
    "gmt" = "git mergetool --no-prompt";
    "gd" = "git diff";
    "gr" = "git remote -v";
    "gcf" = "git clean -f";
    "grh" = "git reset --hard";
    "grhh" = "git reset --hard HEAD";
  };
}
