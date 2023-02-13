return {
    -- auto completion
    {
        "hrsh7th/nvim-cmp",
        version = false, -- last release is way too old
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "ray-x/cmp-treesitter"
        },
        opts = function()
          local cmp = require("cmp")
          local lspkind = require 'lspkind'
          local cmp_buffer = require 'cmp_buffer'
          local get_bufnrs_unless_huge = function()
            local buf = vim.api.nvim_get_current_buf()
            if vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf)) > 1024 * 1024 then -- 1 Megabyte max
              return {}
            end
            return { buf }
          end
          return {
              completion = {
                  completeopt = "menu,menuone,noinsert",
              },
              mapping = cmp.mapping.preset.insert({
                  ["<C-e>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
                  ['<CR>'] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false, },
                  ['<C-Space>'] = cmp.mapping.complete { behavior = cmp.ConfirmBehavior.Replace, select = true, },
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
                    end
                  end, { 'i', 's' }),
              }),
              sources = {
                  { name = "nvim_lsp" },
                  { name = 'buffer', option = {
                      keyword_length = 2,
                      option = {
                          get_bufnrs = get_bufnrs_unless_huge
                      }
                  } },
                  -- { name = "treesitter" },
              },
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
              sorting = {
                  comparators = {
                      function(...) return cmp_buffer:compare_locality(...) end,
                      -- The rest of your comparators...
                  }
              },
              experimental = {
                  ghost_text = {
                      hl_group = "LspCodeLens",
                  },
              },
          }
        end
    }
}
