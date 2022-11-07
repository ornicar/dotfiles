vim.g.mapleader = ','

vim.opt.clipboard = 'unnamedplus' -- Alias unnamed register to the + register, which is the X Window clipboard.

vim.opt.history = 9000                  -- Sets how many lines of history VIM has to remember

vim.opt.undolevels = 2000               -- use many levels of undo
vim.opt.undofile = true                      -- persistent

vim.opt.showmode = false -- lightline shows the mode

vim.opt.wildmode = 'list:full'            -- Complete files like a shell.
vim.opt.wildignore = '.git,.hg,*.o,*.a,*.class,*.jar,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,*.pyc,*.pyo,**/cache/*,**/logs/*,**/target/*,*.hi,tags,**/dist/*,**/public/**/vendor/**,**/public/vendor/**,**/node_modules/**'

vim.opt.number = true                        -- Show line numbers.
vim.opt.ruler = true                         -- Show cursor position.
vim.opt.cursorline = true                         -- Show cursor position.

vim.opt.ignorecase = true                    -- Case-insensitive searching.
vim.opt.smartcase = true                     -- But case-sensitive if expression contains a capital letter.
vim.opt.showmatch = true                     -- Show matching char (like {})
vim.opt.wrapscan = true                      -- Circle search

vim.opt.wrap = false                        -- Turn off line wrapping.
vim.opt.scrolloff = 8                   -- Show 7 lines of context around the cursor.
vim.opt.sidescrolloff = 8


-- vim.opt.shortmess = vim.opt.shortmess .. 'c'  -- Do not show "match xx of xx" and other messages during auto-completion

vim.opt.backup = false                      -- Don't make a backup before overwriting a file.
vim.opt.writebackup = false                 -- And again.
vim.opt.swapfile = false                    -- Use an SCM instead of swap files

-- vim.opt.fillchars = 'fold:\ ,diff:⣿'

-- Tabs and indenting
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.smartindent = true

vim.opt.gdefault = true                      -- replace all occurences of the line

vim.opt.cmdwinheight = 12               -- Larger console window

-- save edit position
vim.cmd([[
  autocmd BufReadPost * if @% !~# '\.git[\/\\]COMMIT_EDITMSG$' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif 
  au BufRead,BufNewFile *.sbt,*.sc set filetype=scala
]])
