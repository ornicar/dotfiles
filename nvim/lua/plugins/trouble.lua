local map = vim.keymap.set
local trouble = require("trouble")
trouble.setup {
  height = 8,
  auto_open = false, -- automatically open the list when you have diagnostics
  auto_close = true, -- automatically close the list when you have no diagnostics
}
map("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { silent = true })
map("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { silent = true })
map("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", { silent = true })
map("n", "gr", "<cmd>TroubleToggle lsp_references<cr>", { silent = true })
map("n", "gd", "<cmd>TroubleToggle lsp_definitions<cr>", { silent = true })
map("n", "]x", function() trouble.next({ skip_groups = true, jump = true }) end)
map("n", "[x", function() trouble.previous({ skip_groups = true, jump = true }) end)
