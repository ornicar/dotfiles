local map = vim.keymap.set
local builtin = require('telescope.builtin')

map('n', '<leader>ms', builtin.find_files, {})
map('n', '<leader>mr', function() builtin.find_files({ cwd = vim.fn.expand('%:p:h') }) end, {})
map('n', '<leader>a', builtin.live_grep, {})
map('n', '<leader>mb', builtin.buffers, {})
map('n', '<leader>H', builtin.help_tags, {})
map('n', '<leader>za', builtin.grep_string, {})
map('n', 'Q', builtin.commands, {})
map('n', 'qq', builtin.command_history, {})
map('n', 'q/', builtin.search_history, {})
map('n', '<leader>man', builtin.man_pages, {})
map('n', '<leader>qf', builtin.quickfix, {})
map('n', '<leader>qh', builtin.quickfixhistory, {})
map('n', '<leader>vo', builtin.vim_options, {})
map('n', '<leader>b', builtin.current_buffer_fuzzy_find, {})

-- lsp
map("n", "gd", builtin.lsp_definitions)
map("n", "gr", builtin.lsp_references)
map("n", "gi", builtin.lsp_implementations)
map("n", "<space>o", builtin.lsp_document_symbols)
map("n", "<space>s", builtin.lsp_dynamic_workspace_symbols)
map("n", "<space>d", builtin.diagnostics)

-- :help telescope.setup()
require 'telescope'.setup {
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
}
require 'telescope'.load_extension 'fzf'
