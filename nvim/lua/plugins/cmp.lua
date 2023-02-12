vim.opt.completeopt = { "menu", "menuone", "noselect" }

local cmp = require 'cmp'
local cmp_buffer = require 'cmp_buffer'
local lspkind = require 'lspkind'

local get_bufnrs_unless_huge = function()
  local buf = vim.api.nvim_get_current_buf()
  if vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf)) > 1024 * 1024 then -- 1 Megabyte max
    return {}
  end
  return { buf }
end

cmp.setup {
  -- view = {
  --   entries = "custom" -- can be "custom", "wildmenu" or "native"
  -- },
  sources = {
    { name = "nvim_lsp" },
    { name = 'buffer', option = {
      keyword_length = 2,
      option = {
        get_bufnrs = get_bufnrs_unless_huge
      }
    } },
    -- { name = "treesitter" },
    -- { name = "path" },
  },
  sorting = {
    comparators = {
      function(...) return cmp_buffer:compare_locality(...) end,
      -- The rest of your comparators...
    }
  },
  mapping = cmp.mapping.preset.insert({
    -- ["<C-e>"] = cmp.mapping(function(fallback)
    --   if cmp.visible() then
    --     vim.api.nvim_command('write')
    --     cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
    --   else
    --     fallback()
    --   end
    -- end, { 'i', 's' }),
    ["<C-e>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
    ['<CR>'] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false, },
    ['<C-Space>'] = cmp.mapping.complete { behavior = cmp.ConfirmBehavior.Replace, select = true, },
    -- ["<C-n>"] = cmp.mapping.select_next_item(),
    -- ["<C-k>"] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_next_item()
      else
        -- fallback()
      end
    end, { 'i', 's' }),
    ['<C-k>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      else
        -- fallback()
      end
    end, { 'i', 's' }),
  }),
  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol_text",
      menu = ({
        nvim_lsp = "[LSP]",
        treesitter = "[Tree]",
        buffer = "[Buf]",
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
    expand = function()
      -- error('snippet engine is not configured.')
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
-- cmp.setup.cmdline({ '/', '?' }, {
--   mapping = cmp.mapping.preset.cmdline({
--     ["<C-k>"] = cmp.mapping.select_prev_item(),
--     ["<C-n>"] = cmp.mapping.select_next_item(),
--   }),
--   sources = {
--     { name = 'buffer' }
--   }
-- })

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline(':', {
--   mapping = cmp.mapping.preset.cmdline({
--     ["<C-k>"] = cmp.mapping.select_prev_item(),
--     ["<C-n>"] = cmp.mapping.select_next_item(),
--   }),
--   sources = cmp.config.sources({
--     { name = 'buffer' },
--     { name = 'path' },
--     { name = 'cmdline' }
--   })
-- })
