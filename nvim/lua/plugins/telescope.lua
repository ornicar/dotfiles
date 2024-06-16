return {
  {
    "nvim-telescope/telescope.nvim",
    enabled = true,
    cmd = "Telescope",
    keys = function()
      return {
        { "<leader>mr", LazyVim.pick("auto", { root = false }), desc = "Find Files (Root Dir)" },
        { "<leader>ms", LazyVim.pick("auto", { root = true }), desc = "Find Files (cwd)" },
        {
          "<leader>mt",
          function()
            require("telescope.builtin").find_files({ cwd = vim.fn.expand("%:p:h") })
          end,
          desc = "Find Files (Buffer dir)",
        },
        {
          "<leader><space>r",
          function()
            require("telescope.builtin").live_grep()
          end,
          desc = "Grep (Root Dir)",
        },
        { "<leader><space>s", LazyVim.pick("live_grep", { root = true }), desc = "Grep (cwd)" },
        {
          "<leader><space>t",
          function()
            require("telescope.builtin").live_grep({ cwd = vim.fn.expand("%:p:h") })
          end,
          desc = "Grep (Buffer dir)",
        },
        {
          "<leader>R",
          function()
            require("telescope.builtin").grep_string({ word_match = "-w" })
          end,
          desc = "Word (Root Dir)",
        },
        { "<leader>S", LazyVim.pick("grep_string", { root = true, word_match = "-w" }), desc = "Word (cwd)" },
        {
          "<leader>T",
          function()
            require("telescope.builtin").grep_string({
              word_match = "-w",
              cwd = require("telescope.utils").buffer_dir(),
            })
          end,
          desc = "Word (Buffer dir)",
        },
        { "<leader>mv", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
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
        { "<space>o", "<cmd>Telescope lsp_document_symbols<cr>", desc = "LSP document symboles" },
        {
          "<space>O",
          function()
            require("telescope.builtin").lsp_dynamic_workspace_symbols({
              symbols = require("lazyvim.config").get_kind_filter(),
            })
          end,
          desc = "Goto Symbol (Workspace)",
        },
        { "<space>i", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document Diagnostics" },
        { "<leader>mk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
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
    end,
  },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
}
