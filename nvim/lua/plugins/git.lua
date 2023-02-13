local map = vim.keymap.set

return {
    -- gutter/scrollbar git icons
    {
        'lewis6991/gitsigns.nvim',
        keys = {
            { '<leader>gb', ':Gitsigns toggle_current_line_blame<cr>' }
        }
    },

    -- lazygit launcher
    {
        'kdheepak/lazygit.nvim',
        cmd = 'LazyGit',
        config = function(_, opts)
          vim.g.lazygit_floating_window_scaling_factor = 1
          vim.g.lazygit_floating_window_use_plenary = 1
          map('n', '<leader>gg', ':LazyGit<cr>', { silent = true })
        end
    },

    -- github gist maker
    { 'mattn/vim-gist' },

    -- git browse (<leader>gh)
    { 'ruanyl/vim-gh-line' },
}
