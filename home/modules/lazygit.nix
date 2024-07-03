{ ... }: {
  programs.lazygit = {
    enable = true;
    settings = {
      git = {
        paging = {
          colorArg = "always";
          pager = "diff-so-fancy";
        };
        disableForcePushing = true;
      };
      gui = {
        language = "en";
        mouseEvents = false;
        sidePanelWidth = 0.3;
        mainPanelSplitMode =
          "flexible"; # one of "horizontal" | "flexible" | "vertical"
        showFileTree = false; # ` to toggle
        nerdFontsVersion = "3";
        commitHashLength = 6;
        showDivergenceFromBaseBranch = "arrowAndNumber";
      };
      quitOnTopLevelReturn = true;
      disableStartupPopups = true;
      promptToReturnFromSubprocess = false;
      os = {
        edit = "nvim";
        editAtLine = "{{editor}} +{{line}} {{filename}}";
      };
      keybinding = {
        files = {
          stashAllChanges = "<c-a>"; # instead of just 's' which I typod for 'c'
        };
        universal = {
          prevItem = "e";
          nextItem = "n";
          scrollUpMain = "<up>"; # main panel scroll up
          scrollDownMain = "<down>"; # main panel scroll down
          nextMatch = "j";
          prevMatch = "J";
          new = "<c-a>";
          edit = "<c-r>";
        };
      };
      # https://github.com/jesseduffield/lazygit/blob/master/docs/Custom_Command_Keybindings.md
      customCommands = [{
        key = "H";
        context = "commits";
        # or use "y u" to copy the url
        command = "gh browse {{.SelectedLocalCommit.Hash}}";
      }];
    };
  };
}
