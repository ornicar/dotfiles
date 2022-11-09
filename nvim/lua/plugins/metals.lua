local map = vim.keymap.set

map('n', '<leader>mc', '<cmd>lua require"telescope".extensions.metals.commands()<CR>')

local metals = require'metals'
local metals_config = metals.bare_config()

-- Example of settings
metals_config.settings = {
  showImplicitArguments = true,
  excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
}

metals_config.init_options.statusBarProvider = "on"

-- cmp integration
metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

-- metals_config.on_attach = function(client, bufnr)
--   require("metals").setup_dap()
-- end

-- Autocmd that will actually be in charging of starting the whole thing
local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "scala", "sbt", "java" },
  callback = function()
    metals.initialize_or_attach(metals_config)
  end,
  group = nvim_metals_group,
})
