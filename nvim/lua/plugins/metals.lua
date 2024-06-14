return {

  -- scala lsp
  {
    "scalameta/nvim-metals",
    ft = { "scala", "sbt", "java" },
    -- stylua: ignore
    keys = {
      {'<leader>me', function() require "telescope".extensions.metals.commands() end, desc="Metals commands"},
      {'<leader>mc', function() require "metals".compile_cascade() end, desc="Metals compile cascade"},
    },
    config = function()
      local metals = require("metals")
      local config = metals.bare_config()

      config.init_options.statusBarProvider = "on"
      config.settings = {
        showImplicitArguments = true,
        excludedPackages = { "akka.actor.typed.javadsl" },
        serverProperties = { "-Xmx2g" },
        serverVersion = "latest.snapshot",
      }

      config.capabilities = require("cmp_nvim_lsp").default_capabilities()

      config.on_attach = function(client, bufnr)
        -- metals.setup_dap()
        require("lsp-format").on_attach(client, bufnr)
      end

      -- Autocmd that will actually be in charge of starting the whole thing
      local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "scala", "sbt", "java" },
        callback = function()
          metals.initialize_or_attach(config)
        end,
        group = nvim_metals_group,
      })
    end,
  },
}
