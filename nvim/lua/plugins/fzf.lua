local function symbols_filter(entry, ctx)
  if ctx.symbols_filter == nil then
    ctx.symbols_filter = LazyVim.config.get_kind_filter(ctx.bufnr) or false
  end
  if ctx.symbols_filter == false then
    return true
  end
  return vim.tbl_contains(ctx.symbols_filter, entry.kind)
end

local fullscreen = { fullscreen = true, border = false }

local lsp_symbols_opts = {
  regex_filter = symbols_filter,
  winopts = fullscreen,
}

local function pick(command, opts)
  opts = opts or {}
  if not opts.winopts then
    opts.winopts = fullscreen
  end
  return LazyVim.pick(command, opts)
end

return {
  {
    "ibhagwan/fzf-lua",
    opts = {
      fzf_colors = true,
      fzf_opts = {
        ["--layout"] = "default",
        -- ["--no-scrollbar"] = false,
        ["--border"] = "none",
      },
      hls = {
        border = "Function",
        preview_border = "Function",
      },
      winopts = {
        -- width = 0.85,
        -- height = 0.8,
        border = "none",
        fullscreen = false,
        preview = {
          default = "bat", -- faster, no delay required
          scrollchars = { "┃", "" },
        },
      },
    },
    keys = function()
      return {
        {
          "<leader>mr",
          pick("files", { root = false }),
          desc = "Find Files (cwd)",
        },
        { "<leader>ms", pick("files"), desc = "Find Files (Root Dir)" },
        {
          "<leader>mt",
          function()
            pick("files", { cwd = vim.fn.expand("%:p:h") })()
          end,
          desc = "Find Files (Buffer dir)",
        },

        { "<leader><space>r", pick("live_grep", { root = false }), desc = "Grep (cwd)" },
        { "<leader><space>s", pick("live_grep"), desc = "Grep (Root Dir)" },
        {
          "<leader><space>t",
          function()
            pick("live_grep", { cwd = vim.fn.expand("%:p:h") })()
          end,
          desc = "Grep (Buffer dir)",
        },
        { "<leader>R", pick("grep_cword", { root = false }), desc = "Word (cwd)" },
        { "<leader>S", pick("grep_cword"), desc = "Word (Root Dir)" },
        {
          "<leader>T",
          function()
            pick("grep_cword", { cwd = vim.fn.expand("%:p:h") })()
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
        { "<leader>my", "<cmd>YankyRingHistory<cr>", desc = "Yank History" },
        { "qq", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
        -- { "q/", "<cmd>Telescope search_history<cr>", desc = "Command History" },
        { "<leader>mn", "<cmd>FzfLua man_pages<cr>", desc = "Man Pages" },
        { "<leader>qf", "<cmd>FzfLua quickfix<cr>", desc = "Quickfix List" },
        { "<leader>mm", "<cmd>FzfLua resume<cr>", desc = "Resume" },
        -- lsp
        {
          "<space>o",
          function()
            require("fzf-lua").lsp_document_symbols(lsp_symbols_opts)
          end,
          desc = "Goto Symbol",
        },
        {
          "<space>O",
          function()
            require("fzf-lua").lsp_live_workspace_symbols(lsp_symbols_opts)
          end,
          desc = "Goto Symbol (Workspace)",
        },
        { "<space>i", "<cmd>FzfLua diagnostics_document<cr>", desc = "Document Diagnostics" },
        { "<space>I", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Workspace Diagnostics" },
        { "<leader>mk", "<cmd>FzfLua keymaps<cr>", desc = "Key Maps" },
        -- git
        { "<leader>gc", "<cmd>FzfLua git_commits<CR>", desc = "Commits" },
        { "<leader>gs", "<cmd>FzfLua git_status<CR>", desc = "Status" },
      }
    end,
  },
}
