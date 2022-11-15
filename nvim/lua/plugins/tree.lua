-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
  sort_by = "name",
  open_on_setup = false,
  update_focused_file = {
    enable = true
  },
  view = {
    width = 25,
    adaptive_size = true,
    mappings = {
      custom_only = true,
      list = {
        { key = { "<CR>", "o", "<space>" }, action = "edit" },
        -- { key = "<C-e>", action = "edit_in_place" },
        -- { key = "O", action = "edit_no_picker" },
        { key = "<C-]>", action = "cd" },
        -- { key = "<C-v>", action = "vsplit" },
        -- { key = "<C-x>", action = "split" },
        -- { key = "<C-t>", action = "tabnew" },
        -- { key = "<", action = "prev_sibling" },
        -- { key = ">", action = "next_sibling" },
        { key = "P", action = "parent_node" },
        { key = "<BS>", action = "close_node" },
        { key = "p", action = "preview" },
        -- { key = "K", action = "first_sibling" },
        -- { key = "J", action = "last_sibling" },
        { key = "I", action = "toggle_git_ignored" },
        { key = "H", action = "toggle_dotfiles" },
        -- { key = "U", action = "toggle_custom" },
        { key = "R", action = "refresh" },
        { key = "a", action = "create" },
        { key = "d", action = "remove" },
        { key = "D", action = "trash" },
        { key = "r", action = "rename" },
        { key = "<C-r>", action = "full_rename" },
        { key = "x", action = "cut" },
        { key = "c", action = "copy" },
        { key = "v", action = "paste" },
        { key = "y", action = "copy_name" },
        { key = "Y", action = "copy_path" },
        { key = "gy", action = "copy_absolute_path" },
        -- { key = "[e", action = "prev_diag_item" },
        -- { key = "[c", action = "prev_git_item" },
        -- { key = "]e", action = "next_diag_item" },
        -- { key = "]c", action = "next_git_item" },
        { key = "-", action = "dir_up" },
        { key = "s", action = "system_open" },
        -- { key = "f", action = "live_filter" },
        -- { key = "F", action = "clear_live_filter" },
        { key = "q", action = "close" },
        -- { key = "W", action = "collapse_all" },
        -- { key = "E", action = "expand_all" },
        -- { key = "S", action = "search_node" },
        { key = ".", action = "run_file_command" },
        { key = "k", action = "toggle_file_info" },
        { key = "g?", action = "toggle_help" },
        { key = "m", action = "toggle_mark" },
        { key = "bmv", action = "bulk_move" },
      }
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
})

vim.keymap.set('n', '<leader>t', ':NvimTreeFocus<cr>')
