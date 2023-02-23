local Util = require("lazyvim.util")

return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false, -- telescope did only one release, so use HEAD for now
    keys = function()
      local in_buffer_dir = function(builtin)
        return function()
          return Util.telescope(builtin, { cwd = require("telescope.utils").buffer_dir() })()
        end
      end
      return {
        { "<leader>mr", Util.telescope("files", { cwd = false }), desc = "Find Files in git root" },
        { "<leader>ms", Util.telescope("files"), desc = "Find files in LSP root" },
        { "<leader>mt", in_buffer_dir("files"), desc = "Find files in buffer directory" },
        { "<leader>r", Util.telescope("live_grep", { cwd = false }), desc = "Live grep in git root" },
        { "<leader>s", Util.telescope("live_grep"), desc = "Live grep in LSP root" },
        { "<leader>t", in_buffer_dir("live_grep"), desc = "Live grep in buffer directory" },
        { "<leader>mb", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
        { "<leader>H", Util.telescope("help_tags"), desc = "Help tags" },
        { "<leader>*", Util.telescope("grep_string"), desc = "Grep the string under cursor" },
        { "Q", Util.telescope("commands"), desc = "Commands" },
        { "qq", Util.telescope("command_history"), desc = "Command history" },
        { "q/", Util.telescope("search_history"), desc = "Search history" },
        { "<leader>mn", Util.telescope("man_pages"), desc = "Man pages" },
        { "<leader>qf", Util.telescope("quickfix"), desc = "Quickfix" },
        { "<leader>qh", Util.telescope("quickfixhistory"), desc = "Quickfix history" },
        { "<leader>b", Util.telescope("current_buffer_fuzzy_find"), desc = "Current buffer fuzzy find" },
        { "<leader>mp", ":Telescope yank_history<cr>", desc = "Yank history" },
        { "<leader>mm", Util.telescope("resume"), desc = "Resume" },
        { "<leader>mo", ":Telescope notify<cr>", desc = "Notifications" },
        -- lsp
        { "gd", Util.telescope("lsp_definitions"), desc = "LSP definitions" },
        { "gr", Util.telescope("lsp_references"), desc = "LSP references" },
        { "<space>o", Util.telescope("lsp_document_symbols"), desc = "LSP document symboles" },
        -- { "<space>s", Util.telescope("lsp_dynamic_workspace_symbols"), desc = "LSP workspace symbols" },
      }
    end,
    opts = function(_, opts)
      opts.defaults.mappings = {
        i = {
          ["<C-e>"] = "move_selection_previous",
          -- ["<esc>"] = "close",
          ["<C-t>"] = function(...)
            return require("trouble.providers.telescope").open_with_trouble(...)
          end,
          ["<a-i>"] = function()
            Util.telescope("find_files", { no_ignore = true })()
          end,
          ["<a-h>"] = function()
            Util.telescope("find_files", { hidden = true })()
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
      tel.load_extension("yank_history")
      tel.load_extension("fzf")
      tel.load_extension("notify")
    end,
  },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
}
