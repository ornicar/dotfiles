vim.opt.completeopt = { "menu", "menuone", "noselect" }

local cmp = require'cmp'
local luasnip = require'luasnip'
local lspkind = require'lspkind'

cmp.setup {
  -- view = {            
  --   entries = "custom" -- can be "custom", "wildmenu" or "native"
  -- },
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "treesitter" },
    { name = "path" },
    { name = 'buffer', option = { keyword_length = 3 } }
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-e>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
    ['<CR>'] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false, },
    ['<C-Space>'] = cmp.mapping.complete{ behavior = cmp.ConfirmBehavior.Replace, select = true, },
    -- ["<C-n>"] = cmp.mapping.select_next_item(),
    -- ["<C-k>"] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        -- fallback()
      end
    end, { 'i', 's' }),
    ['<C-k>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        -- fallback()
      end
    end, { 'i', 's' }),
  }),
  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol_text",
      menu = ({
        buffer = "[Buf]",
        treesitter = "[Tree]",
        nvim_lsp = "[LSP]",
        luasnip = "[Snip]",
      })
    }),
  },
  -- formatting = {
  --   format = function(entry, vim_item)
  --     if vim.tbl_contains({ 'path' }, entry.source.name) then
  --       local icon, hl_group = require('nvim-web-devicons').get_icon(entry:get_completion_item().label)
  --       if icon then
  --         vim_item.kind = icon
  --         vim_item.kind_hl_group = hl_group
  --         return vim_item
  --       end
  --     end
  --     return lspkind.cmp_format({ with_text = false })(entry, vim_item)
  --   end
  -- },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
}

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline({
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
  }),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline({
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
  }),
  sources = cmp.config.sources({
    { name = 'buffer' },
    { name = 'path' },
    { name = 'cmdline' }
  })
})
