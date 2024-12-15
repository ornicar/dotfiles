local function symbols_filter(entry, ctx)
  if ctx.symbols_filter == nil then
    ctx.symbols_filter = LazyVim.config.get_kind_filter(ctx.bufnr) or false
  end
  if ctx.symbols_filter == false then
    return true
  end
  return vim.tbl_contains(ctx.symbols_filter, entry.kind)
end

return {
  -- metals still needs telescope
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>me",
        function()
          require("telescope").extensions.metals.commands()
        end,
        desc = "Metals commands",
      },
    },
  },
  {
    "ibhagwan/fzf-lua",
    opts = {
      fzf_colors = true,
      winopts = {
        width = 0.95,
        height = 0.9,
        border = false,
        fullscreen = true,
        preview = {
          scrollchars = { "┃", "" },
          delay = 20,
        },
      },
    },
    keys = function()
      return {
        { "<leader>mr", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
        { "<leader>ms", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
        {
          "<leader>mt",
          function()
            LazyVim.pick("files", { cmd = "ls", cwd = vim.fn.expand("%:p:h") })
          end,
          desc = "Find Files (Buffer dir)",
        },

        { "<leader><space>r", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
        { "<leader><space>s", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
        {
          "<leader><space>t",
          function()
            require("telescope.builtin").live_grep({ cwd = vim.fn.expand("%:p:h") })
          end,
          desc = "Grep (Buffer dir)",
        },
        { "<leader>R", LazyVim.pick("grep_cword", { root = false }), desc = "Word (cwd)" },
        { "<leader>S", LazyVim.pick("grep_cword"), desc = "Word (Root Dir)" },
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
        { "<leader>mv", "<cmd>FzfLua oldfiles<cr>", desc = "Recent files" },
        {
          "<leader>mb",
          "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>",
          desc = "Switch Buffer",
        },
        { "<leader>H", "<cmd>FzfLua help_tags<cr>", desc = "Help Pages" },
        { "<leader>mq", "<cmd>FzfLua commands<cr>", desc = "Commands" },
        -- { "qq", "<cmd>Telescope command_history<cr>", desc = "Command History" },
        -- { "q/", "<cmd>Telescope search_history<cr>", desc = "Command History" },
        { "<leader>mn", "<cmd>FzfLua man_pages<cr>", desc = "Man Pages" },
        { "<leader>qf", "<cmd>FzfLua quickfix<cr>", desc = "Quickfix List" },
        { "<leader>mm", "<cmd>FzfLua resume<cr>", desc = "Resume" },
        -- { "<leader>mo", "<cmd>Telescope notify<cr>", desc = "Notifications" },
        -- lsp
        {
          "<space>o",
          function()
            require("fzf-lua").lsp_document_symbols({
              regex_filter = symbols_filter,
            })
          end,
          desc = "Goto Symbol",
        },
        {
          "<space>O",
          function()
            require("fzf-lua").lsp_live_workspace_symbols({
              regex_filter = symbols_filter,
            })
          end,
          desc = "Goto Symbol (Workspace)",
        },
        { "<leader>i", "<cmd>FzfLua diagnostics_document<cr>", desc = "Document Diagnostics" },
        { "<leader>I", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Workspace Diagnostics" },
        { "<leader>mk", "<cmd>FzfLua keymaps<cr>", desc = "Key Maps" },
        -- git
        { "<leader>gc", "<cmd>FzfLua git_commits<CR>", desc = "Commits" },
        { "<leader>gs", "<cmd>FzfLua git_status<CR>", desc = "Status" },
      }
    end,
  },
}
