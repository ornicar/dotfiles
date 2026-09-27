local large = {
  width = 0.95,
  height = 0.9,
}
local full = {
  width = 0,
  height = 0,
}
local layout_full = { layout = { fullscreen = true } }

return {
  {
    "simek/snacks.nvim",
    opts = {
      styles = {
        lazygit = full,
        blame_line = large,
        notification_history = large,
      },
      picker = {
        sources = {
          gh_issue = layout_full,
          gh_pr = layout_full,
          gh_diff = {
            ignore_whitespace = true,
            layout = { fullscreen = true },
          },
          git_diff = layout_full,
          explorer = {
            layout = {
              layout = {
                position = "right",
              },
            },
          },
        },
        -- wo = {
        --   winhighlight = "Normal:Normal,NormalFloat:NormalFloat",
        -- },
      },
      terminal = {
        wo = {
          winhighlight = "Normal:Normal",
        },
      },
      image = {},
      lazygit = {
        configure = true,
        config = {
          os = { editPreset = "nvim-remote" },
        },
      },
      gh = {
        wo = {
          winhighlight = "Normal:Normal",
        },
      },
      bigfile = {},
    },
    keys = {
      {
        "<space>e",
        function()
          Snacks.explorer.open({ cwd = LazyVim.root() })
        end,
        desc = "Explorer Snacks (root dir)",
      },
      {
        "<space>E",
        function()
          Snacks.explorer()
        end,
        desc = "Explorer Snacks (cwd)",
      },

      {
        "<leader>gi",
        function()
          Snacks.picker.gh_issue()
        end,
        desc = "GitHub Issues (open)",
      },
      {
        "<leader>gp",
        function()
          Snacks.picker.gh_pr({ draft = false })
        end,
        desc = "GitHub Pull Requests (open, non-draft)",
      },
      {
        "<leader>gP",
        function()
          Snacks.picker.gh_pr()
        end,
        desc = "GitHub Pull Requests (open, with draft)",
      },
    },
  },
}
