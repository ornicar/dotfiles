local map = vim.keymap.set
local Util = require("util")

return {
    -- fuzzy finder
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        version = false, -- telescope did only one release, so use HEAD for now
        keys = {
            { '<leader>ms',  Util.telescope('find_files'),                   {} },
            { '<leader>mr',  Util.telescope('find_files'),                   { cwd = vim.fn.expand('%:p:h') } },
            { '<leader>a',   Util.telescope('live_grep'),                    {} },
            { '<leader>mb',  Util.telescope('buffers'),                      {} },
            { '<leader>H',   Util.telescope('help_tags'),                    {} },
            { '<leader>za',  Util.telescope('grep_string'),                  {} },
            { 'Q',           Util.telescope('commands'),                     {} },
            { 'qq',          Util.telescope('command_history'),              {} },
            { 'q/',          Util.telescope('search_history'),               {} },
            { '<leader>man', Util.telescope('man_pages'),                    {} },
            { '<leader>qf',  Util.telescope('quickfix'),                     {} },
            { '<leader>qh',  Util.telescope('quickfixhistory'),              {} },
            { '<leader>b',   Util.telescope('current_buffer_fuzzy_find'),    {} },
            { '<leader>mp',  ":Telescope yank_history<cr>" },
            -- lsp
            { "gd",          Util.telescope('lsp_definitions') },
            { "gr",          Util.telescope('lsp_references') },
            { "gi",          Util.telescope('lsp_implementations') },
            { "<space>o",    Util.telescope('lsp_document_symbols') },
            { "<space>s",    Util.telescope('lsp_dynamic_workspace_symbols') },
            { "<space>d",    Util.telescope('diagnostics') }
        },
        opts = {
            defaults = {
                -- Default configuration for telescope goes here:
                -- config_key = value,
                mappings = {
                    i = {
                        ["<C-e>"] = "move_selection_previous",
                        ["<esc>"] = "close",
                        -- ['<C-p>'] = require('telescope.actions.layout').toggle_preview,
                    }
                },
                scroll_strategy = 'limit',
                layout_config = {
                    horizontal = {
                        height = 0.95,
                        preview_cutoff = 120,
                        prompt_position = "bottom",
                        width = 0.95
                    }
                },
                dynamic_preview_title = true
            },
            pickers = {
            },
            extensions = {
                fzf = {
                    fuzzy = true, -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true, -- override the file sorter
                    case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                    -- the default case_mode is "smart_case"
                }
            }
        },
        config = function(_, opts)
          local tel = require 'telescope'
          tel.setup(opts)
          tel.load_extension 'fzf'
          tel.load_extension 'yank_history'
        end
    }
}
