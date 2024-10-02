return {
  "romgrk/barbar.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  event = "VeryLazy",
  opts = {
    animation = false,
    exclude_ft = {},
    exclude_name = {},
    icons = {
      buffer_index = true,
      diagnostics = {
        [vim.diagnostic.severity.ERROR] = { enabled = true },
        [vim.diagnostic.severity.WARN] = { enabled = true },
        [vim.diagnostic.severity.INFO] = { enabled = true },
        [vim.diagnostic.severity.HINT] = { enabled = true },
      },
      preset = "powerline",
    },
    insert_at_end = true,
  },
}
