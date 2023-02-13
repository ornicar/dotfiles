return {
    -- colorscheme
    {
        'folke/tokyonight.nvim',
        lazy = true,
        opts = {},
    },
    -- icons
    { "nvim-tree/nvim-web-devicons", lazy = true },
    -- status line
    {
        'nvim-lualine/lualine.nvim',
        opts = function(plugin)
          return {
              options = {
                  theme = 'tokyonight'
              },
              sections = {
                  lualine_a = { { 'mode', fmt = function(str) return str:sub(1, 1) end } },
                  lualine_b = { 'b:gitsigns_head', 'diff',
                      { 'diagnostics', sources = { 'nvim_diagnostic', 'nvim_lsp' } }
                  },
                  lualine_c = {
                      { 'filename', path = 3 },
                      -- 'buffers'
                  },
                  lualine_x = { 'g:metals_status' },
                  lualine_y = {},
                  lualine_z = { 'location' }
              }
          }
        end
    },
    -- Better `vim.notify()`
    {
        "rcarriga/nvim-notify",
        keys = {},
        opts = {
            timeout = 3000,
            max_height = function() return math.floor(vim.o.lines * 0.75) end,
            max_width = function() return math.floor(vim.o.columns * 0.75) end,
        },
    },
    -- scrollbar
    {
        'petertriho/nvim-scrollbar',
        opts = {
            show_in_active_only = true,
            max_lines = 10000, -- disables if no. of lines in buffer exceeds this
            excluded_buftypes = { "terminal", },
            excluded_filetypes = { "prompt", "TelescopePrompt", "noice", },
            handlers = {
                diagnostic = true,
                gitsigns = true, -- Requires gitsigns.nvim
            },
        },
        config = function(_, opts)
          require 'scrollbar'.setup(opts)
          require 'scrollbar.handlers.gitsigns'.setup()
        end
    },
}
