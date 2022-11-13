local map = vim.keymap.set

map('n', '<leader>mc', function() require "telescope".extensions.metals.commands() end)

-- dap
-- map("n", "<leader>dc", [[<cmd>lua require"dap".continue()<CR>]])
-- map("n", "<leader>dr", [[<cmd>lua require"dap".repl.toggle()<CR>]])
-- map("n", "<leader>dK", [[<cmd>lua require"dap.ui.widgets".hover()<CR>]])
-- map("n", "<leader>dt", [[<cmd>lua require"dap".toggle_breakpoint()<CR>]])
-- map("n", "<leader>do", [[<cmd>lua require"dap".step_over()<CR>]])
-- map("n", "<leader>di", [[<cmd>lua require"dap".step_into()<CR>]])
-- map("n", "<leader>dl", [[<cmd>lua require"dap".run_last()<CR>]])

local metals = require 'metals'
local metals_config = metals.bare_config()

metals_config.settings = {
  showImplicitArguments = true,
  excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
}

metals_config.init_options.statusBarProvider = "on"

-- cmp integration
metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

-- require 'dap'.configurations.scala = {
--   {
--     type = "scala",
--     request = "launch",
--     name = "RunOrTest",
--     metals = {
--       runType = "runOrTestFile",
--       --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
--     },
--   },
--   {
--     type = "scala",
--     request = "launch",
--     name = "Test Target",
--     metals = {
--       runType = "testTarget",
--     },
--   },
-- }

metals_config.on_attach = function(client, bufnr)
  -- require 'metals'.setup_dap()
  require 'lsp-format'.on_attach(client, bufnr)
end

-- Autocmd that will actually be in charging of starting the whole thing
local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "scala", "sbt", "java" },
  callback = function()
    metals.initialize_or_attach(metals_config)
  end,
  group = nvim_metals_group,
})
