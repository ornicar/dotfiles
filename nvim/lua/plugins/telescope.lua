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
        { "<leader>mb", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
        { "<leader><space>r", Util.telescope("live_grep", { cwd = false }), desc = "Live grep in git root" },
        { "<leader><space>s", Util.telescope("live_grep"), desc = "Live grep in LSP root" },
        { "<leader><space>t", in_buffer_dir("live_grep"), desc = "Live grep in buffer directory" },
        { "<leader>R", Util.telescope("grep_string", { cwd = false }), desc = "Grep cursor in git root" },
        { "<leader>S", Util.telescope("grep_string"), desc = "Grep cursor in LSP root" },
        { "<leader>T", in_buffer_dir("grep_string"), desc = "Grep cursor in buffer directory" },
        { "<leader>H", Util.telescope("help_tags"), desc = "Help tags" },
        { "<leader><space>b", Util.telescope("current_buffer_fuzzy_find"), desc = "Current buffer fuzzy find" },
        { "Q", Util.telescope("commands"), desc = "Commands" },
        { "qq", Util.telescope("command_history"), desc = "Command history" },
        { "q/", Util.telescope("search_history"), desc = "Search history" },
        { "<leader>mn", Util.telescope("man_pages"), desc = "Man pages" },
        { "<leader>qf", Util.telescope("quickfix"), desc = "Quickfix" },
        { "<leader>qh", Util.telescope("quickfixhistory"), desc = "Quickfix history" },
        { "<leader>mp", ":Telescope yank_history<cr>", desc = "Yank history" },
        { "<leader>mm", Util.telescope("resume"), desc = "Resume" },
        { "<leader>mo", ":Telescope notify<cr>", desc = "Notifications" },
        -- lsp
        { "gd", Util.telescope("lsp_definitions"), desc = "LSP definitions" },
        { "gr", Util.telescope("lsp_references"), desc = "LSP references" },
        { "<space>o", Util.telescope("lsp_document_symbols"), desc = "LSP document symboles" },
        { "<space>O", Util.telescope("lsp_dynamic_workspace_symbols"), desc = "LSP workspace symbols" },
        { "<space>i", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
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
          ["<esc>"] = function(...)
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
