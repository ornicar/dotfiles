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

-- apply lua config (doesn't work lol)
--vim.api.nvim_create_autocmd("BufWritePost", {
--  pattern = "*.lua",
--  callback = function(event)
--    ---@type string
--    local file = event.match
--    local mod = file:match("/lua/(.*)%.lua")
--    if mod then
--      mod = mod:gsub("/", ".")
--    end
--    if mod then
--      package.loaded[mod] = nil
--      vim.notify("Reloaded " .. mod, vim.log.levels.INFO, { title = "nvim" })
--    end
--  end,
--})


vim.cmd([[
  " play2
  au BufRead,BufNewFile */conf/\(*\|\)routes set filetype=play2-routes
  au BufRead,BufNewFile */conf/*.conf setf hocon
]])
