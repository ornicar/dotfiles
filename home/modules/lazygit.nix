{ ... }: {
  programs.lazygit = {
    enable = true;
    settings = {
      git = {
        paging = {
          colorArg = "always";
          pager = "diff-so-fancy";
        };
      };
      gui = {
        language = "en";
        mouseEvents = false;
        sidePanelWidth = 0.333;
        mainPanelSplitMode =
          "horizontal"; # one of "horizontal" | "flexible" | "vertical"
        showFileTree = false; # ` to toggle
      };
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
          new = "<c-n>";
        };
      };
    };
  };
}
