-- mason doesn't work on nixos
return {
  { "williamboman/mason-lspconfig.nvim", enabled = false },
  { "williamboman/mason.nvim", enabled = false },
  { "mfussenegger/nvim-dap", enabled = false },

  { "lukas-reineke/lsp-format.nvim", enabled = true }
}
