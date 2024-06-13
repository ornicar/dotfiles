return {
  {
    "nvim-telescope/telescope.nvim",
    enabled = true,
    cmd = "Telescope",
    version = false, -- telescope did only one release, so use HEAD for now
    keys = function()
      -- local in_buffer_dir = function(builtin)
      --   return function()
      --     return LazyVim.telescope(builtin, { cwd = require("telescope.utils").buffer_dir() })()
      --   end
      -- end
      return {
        { "<leader>ms", LazyVim.pick("auto"), desc = "Find Files (Root Dir)" },
        { "<leader>mt", LazyVim.pick("auto", { root = false }), desc = "Find Files (cwd)" },
        { "<leader><space>s", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
        { "<leader><space>t", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
        { "<leader>S", LazyVim.pick("grep_string", { word_match = "-w" }), desc = "Word (Root Dir)" },
        { "<leader>T", LazyVim.pick("grep_string", { root = false, word_match = "-w" }), desc = "Word (cwd)" },
        -- {
        --   "<leader><space>R",
        --   LazyVim.telescope("live_grep", { cwd = false, no_ignore = true, hidden = true }),
        --   desc = "Live grep, no ignore",
        -- },
        -- {
        --   "<leader><space>b",
        --   LazyVim.telescope("live_grep", { grep_open_files = true }),
        --   desc = "Live grep in open buffers",
        -- },
        { "<leader>mb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Switch Buffer" },
        { "<leader>H", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
        { "<leader>mq", "<cmd>Telescope commands<cr>", desc = "Commands" },
        { "qq", "<cmd>Telescope command_history<cr>", desc = "Command History" },
        { "q/", "<cmd>Telescope search_history<cr>", desc = "Command History" },
        { "<leader>mn", "<cmd>Telescope man_pages<cr>", desc = "Man pages" },
        { "<leader>qf", "<cmd>Telescope quickfix<cr>", desc = "Quickfix List" },
        { "<leader>mm", "<cmd>Telescope resume<cr>", desc = "Resume" },
        { "<leader>mo", "<cmd>Telescope notify<cr>", desc = "Notifications" },
        -- lsp
        {
          "gd",
          function()
            require("telescope.builtin").lsp_definitions({ reuse_win = true })
          end,
          desc = "Goto Definition",
          has = "definition",
        },
        { "gr", "<cmd>Telescope lsp_references<cr>", desc = "References", nowait = true },
        { "<space>o", "<cmd>Telescope lsp_document_symbols<cr>", desc = "LSP document symboles" },
        -- {
        --   "<space>O",
        --   LazyVim.telescope("<cmd>Telescope lsp_dynamic_workspace_symbols<cr>"),
        --   desc = "LSP workspace symbols",
        -- },
        { "<space>i", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document Diagnostics" },
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
