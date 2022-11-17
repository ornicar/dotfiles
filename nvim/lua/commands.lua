vim.cmd([[autocmd FileType markdown setlocal spell]])

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPre", {
  pattern = "*",
  callback = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "<buffer>",
      once = true,
      callback = function()
        vim.cmd(
          [[if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif]]
        )
      end,
    })
  end,
})

-- Fix conceallevel for json & help files
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "json", "jsonc", "help" },
  callback = function()
    vim.wo.spell = false
    vim.wo.conceallevel = 0
  end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.lua",
  callback = function(event)
    ---@type string
    local file = event.match
    local mod = file:match("/lua/(.*)%.lua")
    if mod then
      mod = mod:gsub("/", ".")
    end
    if mod then
      package.loaded[mod] = nil
      vim.notify("Reloaded " .. mod, vim.log.levels.INFO, { title = "nvim" })
    end
  end,
})

local base_group = vim.api.nvim_create_augroup("base", { clear = true })
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  pattern = { "*.md", "*.txt", "COMMIT_EDITMSG" },
  command = "set wrap linebreak nolist spell spelllang=en_us complete+=kspell",
  group = base_group,
})

-- Highlight on yank
vim.cmd("au TextYankPost * lua vim.highlight.on_yank {}")
