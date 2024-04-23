return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = function()
      return {
        {
          "<space>e",
          function()
            require("neo-tree.command").execute({ toggle = false, dir = LazyVim.root() })
          end,
          desc = "Explorer NeoTree (root dir)",
        },
        {
          "<space>E",
          function()
            require("neo-tree.command").execute({ toggle = false, dir = vim.uv.cwd() })
          end,
          desc = "Explorer NeoTree (cwd)",
        },
      }
    end,
    opts = function(_, opts)
      opts.use_default_mappings = false
      opts.window.mappings = {
        -- ["<space>"] = "toggle_node",
        ["<cr>"] = "open",
        ["<esc>"] = "revert_preview",
        ["P"] = { "toggle_preview", config = { use_float = true } },
        ["l"] = "focus_preview",
        -- ["S"] = "open_split",
        -- ["s"] = "open_vsplit",
        -- ["t"] = "open_tabnew",
        -- ["w"] = "open_with_window_picker",
        ["C"] = "close_node",
        ["z"] = "close_all_nodes",
        ["a"] = {
          "add",
          -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
          -- some commands may take optional config options, see `:h neo-tree-mappings` for details
          config = {
            show_path = "none", -- "none", "relative", "absolute"
          },
        },
        ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
        ["d"] = "delete",
        ["r"] = "rename",
        ["y"] = "copy_to_clipboard",
        ["x"] = "cut_to_clipboard",
        ["p"] = "paste_from_clipboard",
        ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
        ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
        ["q"] = "close_window",
        ["R"] = "refresh",
        ["?"] = "show_help",
        ["<"] = "prev_source",
        [">"] = "next_source",
        ["H"] = "toggle_hidden",
      }
      opts.filesystem.filtered_items = { always_show = { "application.conf" } }
      opts.filesystem.group_empty_dirs = true -- when true, empty folders will be grouped together
      opts.sort_case_insensitive = true
    end,
  },
}
