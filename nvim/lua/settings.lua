local opt = vim.opt

vim.g.mapleader = ','

opt.clipboard = 'unnamedplus' -- Alias unnamed register to the + register, which is the X Window clipboard.

opt.history = 9000 -- Sets how many lines of history VIM has to remember

opt.undolevels = 2000 -- use many levels of undo
opt.undofile = true -- persistent

opt.showmode = false -- lightline shows the mode

opt.wildmode = 'list:full' -- Complete files like a shell.
opt.wildignore = '.git,.hg,*.o,*.a,*.class,*.jar,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,*.pyc,*.pyo,**/cache/*,**/logs/*,**/target/*,*.hi,tags,**/dist/*,**/public/**/vendor/**,**/public/vendor/**,**/node_modules/**'
opt.wildignorecase = true

opt.number = true -- Show line numbers.
opt.ruler = true -- Show cursor position.
opt.cursorline = true -- Show cursor position.

opt.ignorecase = true -- Case-insensitive searching.
opt.smartcase = true -- But case-sensitive if expression contains a capital letter.
opt.showmatch = true -- Show matching char (like {})
opt.wrapscan = true -- Circle search

opt.wrap = false -- Turn off line wrapping.
opt.scrolloff = 8 -- Show 7 lines of context around the cursor.
opt.sidescrolloff = 8


-- opt.shortmess = 'filnxtToOFc' -- Do not show "match xx of xx" and other messages during auto-completion
vim.opt_global.shortmess:append("c")

opt.backup = false -- Don't make a backup before overwriting a file.
opt.writebackup = false -- And again.
opt.swapfile = false -- Use an SCM instead of swap files

opt.listchars = 'tab:╶─╴,lead:·,trail:▒,eol:↲,extends:►,precedes:◄'

-- Tabs and indenting
opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.shiftround = true
opt.smartindent = true

opt.gdefault = true -- replace all occurences of the line

opt.cmdwinheight = 12 -- Larger console window

opt.grepprg = 'rg --vimgrep --no-heading --smart-case'

local base_group = vim.api.nvim_create_augroup("base", { clear = true })
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  pattern = { "*.md", "*.txt", "COMMIT_EDITMSG" },
  command = "set wrap linebreak nolist spell spelllang=en_us complete+=kspell",
  group = base_group,
})
