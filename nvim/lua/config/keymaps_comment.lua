local map = vim.keymap.set

map("v", "'", function()
  local count = vim.v.count
  vim.cmd.norm((count > 0 and count or "") .. "gcc")
end)

map("n", "'", function()
  local count = vim.v.count
  vim.cmd.norm((count > 0 and count or "") .. "gcc")
end)

map("o", "'", function()
  local count = vim.v.count
  vim.cmd.norm((count > 0 and count or "") .. "gcc")
end)

map("x", "'", function()
  local count = vim.v.count
  vim.cmd.norm((count > 0 and count or "") .. "gcc")
end)

-- Duplicate line and comment the first line
map("n", "yc", '"yy" . v:count1 . "gcc\']p"', { remap = true, expr = true })
