{ ... }: {
  programs.lazygit = {
    enable = true;
    settings = {
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
          scrollUpMain = "E"; # main panel scroll up
          scrollDownMain = "N"; # main panel scroll down
          nextMatch = "j";
          prevMatch = "J";
          new = "<c-n>";
        };
      };
    };
  };
}
