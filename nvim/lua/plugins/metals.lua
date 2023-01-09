local map = vim.keymap.set

map('n', '<leader>mm', function() require "telescope".extensions.metals.commands() end)
map('n', '<leader>mc', function() require "metals".compile_cascade() end)

-- dap
map("n", "<leader>dc", function() require "dap".continue() end)
map("n", "<leader>dr", function() require "dap".repl.toggle() end)
map("n", "<leader>dK", function() require "dap.ui.widgets".hover() end)
map("n", "<leader>dt", function() require "dap".toggle_breakpoint() end)
map("n", "<leader>do", function() require "dap".step_over() end)
map("n", "<leader>di", function() require "dap".step_into() end)
map("n", "<leader>dl", function() require "dap".run_last() end)

local metals = require 'metals'
local metals_config = metals.bare_config()

metals_config.settings = {
  showImplicitArguments = true,
  excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
  serverProperties = { "-Xmx4g" }
}

metals_config.init_options.statusBarProvider = "on"

-- cmp integration
metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

local dap = require 'dap'
dap.configurations.scala = {
  {
    type = "scala",
    request = "launch",
    name = "RunOrTest",
    metals = {
      runType = "runOrTestFile",
    },
  },
  -- {
  --   type = "scala",
  --   request = "launch",
  --   name = "Test Target",
  --   metals = {
  --     runType = "testTarget",
  --   },
  -- },
  -- {
  --   type = "scala",
  --   request = "launch",
  --   name = "Run or test with input",
  --   metals = {
  --     runType = "runOrTestFile",
  --     args = function()
  --       local args_string = vim.fn.input("Arguments: ")
  --       return vim.split(args_string, " +")
  --     end,
  --   },
  -- }
}
dap.listeners.after["event_terminated"]["nvim-metals"] = function()
  -- vim.notify("Tests have finished!")
  dap.repl.open()
end

metals_config.on_attach = function(client, bufnr)
  require 'metals'.setup_dap()
  require 'lsp-format'.on_attach(client, bufnr)
end

-- Autocmd that will actually be in charge of starting the whole thing
local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "scala", "sbt", "java" },
  callback = function()
    metals.initialize_or_attach(metals_config)
  end,
  group = nvim_metals_group,
})
