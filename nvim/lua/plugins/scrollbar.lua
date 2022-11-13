require 'scrollbar'.setup({
  show_in_active_only = true,
  max_lines = 10000, -- disables if no. of lines in buffer exceeds this
  excluded_buftypes = {
    "terminal",
  },
  excluded_filetypes = {
    "prompt",
    "TelescopePrompt",
    "noice",
  },
  handlers = {
    diagnostic = true,
    search = true, -- Requires hlslens to be loaded
    gitsigns = true, -- Requires gitsigns.nvim
  },
})
require 'gitsigns'.setup()
require 'scrollbar.handlers.gitsigns'.setup()
require 'scrollbar.handlers.search'.setup({
  -- hlslens config overrides
})
