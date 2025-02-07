local function pick(command, opts)
  opts = opts or {}
  -- if not opts.winopts then
  --   opts.winopts = fullscreen
  -- end
  return LazyVim.pick(command, opts)
end

local layouts = require("snacks.picker.config.layouts")
layouts.full_horiz = {
  reverse = true,
  layout = {
    box = "horizontal",
    backdrop = false,
    fullscreen = true,
    border = "none",
    {
      box = "vertical",
      { win = "list", title = " Results ", title_pos = "center", border = "rounded" },
      { win = "input", height = 1, border = "rounded", title = "{title} {live} {flags}", title_pos = "center" },
    },
    {
      win = "preview",
      title = "{preview:Preview}",
      width = 0.45,
      border = "rounded",
      title_pos = "center",
    },
  },
}
layouts.full_vert = {
  layout = {
    backdrop = false,
    fullscreen = true,
    box = "vertical",
    border = "rounded",
    title = "{title} {live} {flags}",
    title_pos = "center",
    { win = "input", height = 1, border = "bottom" },
    { win = "list", border = "none" },
    { win = "preview", title = "{preview}", height = 0.4, border = "top" },
  },
}

return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        layout = {
          --- Use the default layout or vertical if the window is too narrow
          preset = function()
            return vim.o.columns >= 120 and "full_horiz" or "full_vert"
          end,
        },
        win = {
          -- input window
          input = {
            keys = {
              ["<Esc>"] = { "close", mode = "i" },
              ["<C-w>"] = { "<c-s-w>", mode = { "i" }, expr = true, desc = "delete word" },
            },
          },
        },
      },
    },
    keys = function()
      -- stylua: ignore
      return {
      { "<leader>mr", pick("files", { root = false }), desc = "Find Files (cwd)" },
      { "<leader>ms", pick("files"), desc = "Find Files (Root Dir)" },
      { "<leader>mt", function() pick("files", { cwd = vim.fn.expand("%:p:h") })() end, desc = "Find Files (Buffer dir)" },

      { "<leader><space>r", pick("live_grep", { root = false }), desc = "Grep (cwd)" },
      { "<leader><space>s", pick("live_grep"), desc = "Grep (Root Dir)" },
      { "<leader><space>t", function() pick("live_grep", { cwd = vim.fn.expand("%:p:h") })() end, desc = "Grep (Buffer dir)" },


      -- { "<leader>R", pick("grep_cword", { root = false }), desc = "Word (cwd)" },
      -- { "<leader>S", pick("grep_cword"), desc = "Word (Root Dir)" },
      { "<leader>R", pick("grep_word", { root = false }), desc = "Visual selection or word (cwd)", mode = { "n", "x" } },
      { "<leader>S", pick("grep_word"), desc = "Visual selection or word (Root Dir)", mode = { "n", "x" } },
      { "<leader>T", function() pick("grep_word", { cwd = vim.fn.expand("%:p:h") })() end, desc = "Word (Buffer dir)" },

      { "<leader>mv", function() Snacks.picker.smart() end, desc = "Smart picker" },
      { "<leader>mb", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>H", function() Snacks.picker.help() end, desc = "Help Pages" },
      { "<leader>mq", function() Snacks.picker.commands() end, desc = "Commands" },
      { "<leader>my", "<cmd>YankyRingHistory<cr>", desc = "Yank History" },
      { "qq", function() Snacks.picker.command_history() end, desc = "Command History" },
      -- { "q/", "<cmd>Telescope search_history<cr>", desc = "Command History" },
      { "<leader>mn", function() Snacks.picker.man() end, desc = "Man Pages" },
      { "<leader>qf", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
      { "<leader>mm", function() Snacks.picker.resume() end, desc = "Resume" },
      { "<leader>mu", function() Snacks.picker.undo() end, desc = "Undo tree" },
      { "<leader>ml", function() Snacks.picker.loclist() end, desc = "Location List" },
      { "<leader>mi", function() Snacks.picker.icons() end, desc = "Icons" },
      -- lsp
      { "<space>o", function() Snacks.picker.lsp_symbols({ filter = LazyVim.config.kind_filter }) end, desc = "LSP Symbols" },
      { "<space>O", function() Snacks.picker.lsp_workspace_symbols({ filter = LazyVim.config.kind_filter }) end, desc = "LSP Workspace Symbols" },
      -- {
      --   "<space>O",
      --   function()
      --     require("fzf-lua").lsp_live_workspace_symbols(lsp_symbols_opts)
      --   end,
      --   desc = "Goto Symbol (Workspace)",
      -- },
      { "<space>i", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
      { "<space>I", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Workspace Diagnostics" },
      { "<leader>mk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
      -- git
      { "<leader>gc", function() Snacks.picker.git_log() end, desc = "Git Log" },
      { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (hunks)" },
      { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
    }
    end,
  },
}
