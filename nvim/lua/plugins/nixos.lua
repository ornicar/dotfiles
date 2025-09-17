-- mason doesn't work on nixos
return {
  { "mason-org/mason-lspconfig.nvim", enabled = false },
  { "mason-org/mason.nvim", enabled = false },
  { "mfussenegger/nvim-dap", enabled = false },

  { "lukas-reineke/lsp-format.nvim", enabled = true },
}
