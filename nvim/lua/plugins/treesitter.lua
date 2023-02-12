require 'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all"
    ensure_installed = { "scala", "typescript", "scss", "rust", "python", "lua", "html", "css", "javascript", "bash", "vim",
        "yaml", "hocon", "dart", "haskell" },
    highlight = {
        enable = true,
        disable = function(_, bufnr) -- Disable in large buffers
          return vim.api.nvim_buf_line_count(bufnr) > 10000
        end,
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
}
