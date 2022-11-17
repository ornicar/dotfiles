local map = vim.keymap.set

-- prevent gutter flicker on error
vim.opt.signcolumn = "yes"

-- LSP mappings, also see telescope.lua
map("n", "<leader>h", "<cmd>lua vim.lsp.buf.hover()<CR>")
map("n", "<leader>cl", [[<cmd>lua vim.lsp.codelens.run()<CR>]])
map("n", "<leader>sh", [[<cmd>lua vim.lsp.buf.signature_help()<CR>]])
map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>:w<cr>")
-- map("n", "<leader>f", "<cmd>lua vim.lsp.buf.format()<CR>")
map("n", "[c", vim.diagnostic.goto_prev)
map("n", "]c", vim.diagnostic.goto_next)

local lsp_format = require("lsp-format")
lsp_format.setup {}

local on_attach = function(client, bufnr)
  lsp_format.on_attach(client, bufnr)
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local lspconfig = require('lspconfig')

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'rust_analyzer', 'pyright', 'tsserver', 'cssls', 'dartls' }
for _, server in ipairs(servers) do
  lspconfig[server].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig.sumneko_lua.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = { diagnostics = { globals = { 'vim' }, }, },
    telemetry = { enable = false, },
  }
}
