return {
  -- yank ring
  {
    "gbprod/yanky.nvim",
    opts = {
      highlight = { timer = 200 },
    },
    keys = {
      { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" } },
      { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" } },
      { "<c-n>", "<Plug>(YankyCycleForward)" },
      { "<c-p>", "<Plug>(YankyCycleBackward)" },
      { "]p", "<Plug>(YankyPutIndentAfterLinewise)" },
      { "[p", "<Plug>(YankyPutIndentBeforeLinewise)" },
    },
  },
}
