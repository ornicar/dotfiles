vim.opt.completeopt = { "menu", "menuone", "noselect" }

local cmp = require("cmp")
local lspkind = require('lspkind')
cmp.setup {
  view = {            
    entries = "custom" -- can be "custom", "wildmenu" or "native"
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "treesitter" },
    { name = "path" },
    { name = "luasnip" },
  }, {
    { name = 'buffer', option = { keyword_length = 3 } }
  },
  mapping = {
    -- ['<C-n>'] = cmp.mapping.scroll_docs(1),
    -- ['<C-k>'] = cmp.mapping.scroll_docs(-1),
    -- ["<C-e>"] = cmp.mapping.confirm({ select = false }),
    -- ['<CR>'] = cmp.mapping.confirm({ select = true })
  },
  -- formatting = {
  --   format = lspkind.cmp_format({
  --     mode = "symbol",
  --     menu = ({
  --       buffer = "[Buffer]",
  --       nvim_lsp = "[LSP]",
  --       luasnip = "[Snip]",
  --     })
  --   }),
  -- },
  formatting = {
    format = function(entry, vim_item)
      if vim.tbl_contains({ 'path' }, entry.source.name) then
        local icon, hl_group = require('nvim-web-devicons').get_icon(entry:get_completion_item().label)
        if icon then
          vim_item.kind = icon
          vim_item.kind_hl_group = hl_group
          return vim_item
        end
      end
      return lspkind.cmp_format({ with_text = false })(entry, vim_item)
    end
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
}

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline({ '/', '?' }, {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = {
--     { name = 'buffer' }
--   }
-- })

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline(':', {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = cmp.config.sources({
--     { name = 'path' }
--   }, {
--     { name = 'cmdline' }
--   })
-- })
