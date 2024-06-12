return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false, -- telescope did only one release, so use HEAD for now
    keys = function()
      local in_buffer_dir = function(builtin)
        return function()
          return LazyVim.telescope(builtin, { cwd = require("telescope.utils").buffer_dir() })()
        end
      end
      return {
        { "<leader>mr", LazyVim.telescope("files", { cwd = false }), desc = "Find Files in git root" },
        { "<leader>ms", LazyVim.telescope("files"), desc = "Find files in LSP root" },
        { "<leader>mt", in_buffer_dir("files"), desc = "Find files in buffer directory" },
        { "<leader>mb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Switch Buffer" },
        { "<leader><space>r", LazyVim.telescope("live_grep", { cwd = false }), desc = "Live grep in git root" },
        {
          "<leader><space>R",
          LazyVim.telescope("live_grep", { cwd = false, no_ignore = true, hidden = true }),
          desc = "Live grep, no ignore",
        },
        { "<leader><space>s", LazyVim.telescope("live_grep"), desc = "Live grep in LSP root" },
        { "<leader><space>t", in_buffer_dir("live_grep"), desc = "Live grep in buffer directory" },
        {
          "<leader><space>b",
          LazyVim.telescope("live_grep", { grep_open_files = true }),
          desc = "Live grep in open buffers",
        },
        { "<leader>R", LazyVim.telescope("grep_string", { cwd = false }), desc = "Grep cursor in git root" },
        { "<leader>S", LazyVim.telescope("grep_string"), desc = "Grep cursor in LSP root" },
        { "<leader>T", in_buffer_dir("grep_string"), desc = "Grep cursor in buffer directory" },
        { "<leader>H", LazyVim.telescope("help_tags"), desc = "Help tags" },
        { "<leader>mq", LazyVim.telescope("commands"), desc = "Commands" },
        { "qq", LazyVim.telescope("command_history"), desc = "Command history" },
        { "q/", LazyVim.telescope("search_history"), desc = "Search history" },
        { "<leader>mn", LazyVim.telescope("man_pages"), desc = "Man pages" },
        { "<leader>qf", LazyVim.telescope("quickfix"), desc = "Quickfix" },
        { "<leader>qh", LazyVim.telescope("quickfixhistory"), desc = "Quickfix history" },
        -- { "<leader>ma", ":Telescope macros<cr>", desc = "Macros" },
        { "<leader>mm", LazyVim.telescope("resume"), desc = "Resume" },
        { "<leader>mo", ":Telescope notify<cr>", desc = "Notifications" },
        -- lsp
        {
          "gd",
          function()
            require("telescope.builtin").lsp_definitions({ reuse_win = true })
          end,
          desc = "Goto Definition",
        },
        -- { "gd", LazyVim.telescope("lsp_definitions"), desc = "LSP definitions" },
        { "gr", LazyVim.telescope("lsp_references"), desc = "LSP references" },
        { "<space>o", LazyVim.telescope("lsp_document_symbols"), desc = "LSP document symboles" },
        { "<space>O", LazyVim.telescope("lsp_dynamic_workspace_symbols"), desc = "LSP workspace symbols" },
        { "<space>i", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
      }
    end,
    opts = function(_, opts)
      opts.defaults.mappings = {
        i = {
          -- ["<esc>"] = "close",
          ["<C-t>"] = function(...)
            return require("trouble.providers.telescope").open_with_trouble(...)
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
      -- tel.load_extension("macros")
    end,
  },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
}
