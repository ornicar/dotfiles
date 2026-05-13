return {
  { "copilot.lua" },
  {
    "folke/sidekick.nvim",
    opts = {
      cli = {
        mux = {
          backend = "zellij",
          enabled = false,
        },
      },
    },
    keys = {
      {
        "<c-space>",
        function()
          if not require("sidekick").nes_jump_or_apply() then
            return require("sidekick.nes").update()
          end
        end,
        mode = { "i", "n" },
        expr = true,
        desc = "Goto/Apply Next Edit Suggestion",
      },
      {
        "<leader>aa",
        function()
          require("sidekick.cli").toggle()
        end,
        desc = "Sidekick Toggle CLI",
      },
    },
  },
}
