local Util = require("lazyvim.util")

return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false, -- telescope did only one release, so use HEAD for now
    keys = {
      { "<leader>ms", Util.telescope("find_files"), {} },
      { "<leader>mr", Util.telescope("find_files"), { cwd = vim.fn.expand("%:p:h") } },
      { "<leader>a", Util.telescope("live_grep"), {} },
      -- { "<leader>mb", Util.telescope("buffers"), {} },
      { "<leader>mb", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
      { "<leader>H", Util.telescope("help_tags"), {} },
      { "<leader>za", Util.telescope("grep_string"), {} },
      { "Q", Util.telescope("commands"), {} },
      { "qq", Util.telescope("command_history"), {} },
      { "q/", Util.telescope("search_history"), {} },
      { "<leader>man", Util.telescope("man_pages"), {} },
      { "<leader>qf", Util.telescope("quickfix"), {} },
      { "<leader>qh", Util.telescope("quickfixhistory"), {} },
      { "<leader>b", Util.telescope("current_buffer_fuzzy_find"), {} },
      { "<leader>mp", ":Telescope yank_history<cr>" },
      -- lsp
      { "gd", Util.telescope("lsp_definitions") },
      { "gr", Util.telescope("lsp_references") },
      { "gi", Util.telescope("lsp_implementations") },
      { "<space>o", Util.telescope("lsp_document_symbols") },
      { "<space>s", Util.telescope("lsp_dynamic_workspace_symbols") },
      { "<space>d", Util.telescope("diagnostics") },
    },
    opts = function(_, opts)
      opts.defaults.mappings = {
        i = {
          ["<C-e>"] = "move_selection_previous",
          -- ["<esc>"] = "close",
          ["<C-t>"] = function(...)
            return require("trouble.providers.telescope").open_with_trouble(...)
          end,
        },
        n = {
          ["n"] = function(...)
            return require("telescope.actions").cycle_history_next(...)
          end,
          ["e"] = function(...)
            return require("telescope.actions").cycle_history_prev(...)
          end,
          -- ['<C-p>'] = require('telescope.actions.layout').toggle_preview,
          ["<C-c>"] = function(...)
            return require("telescope.actions").close(...)
          end,
        },
      }
      opts.defaults.scroll_strategy = "limit"
      opts.defaults.layout_config = {
        horizontal = {
          height = 0.95,
          preview_cutoff = 120,
          prompt_position = "bottom",
          width = 0.95,
        },
      }
      opts.defaults.dynamic_preview_title = true
    end,
    config = function(_, opts)
      local tel = require("telescope")
      tel.setup(opts)
      -- tel.load_extension("fzf")
      tel.load_extension("yank_history")
    end,
  },
}
