return {
  "romgrk/barbar.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  event = "VeryLazy",
  opts = {
    animation = false,
    icons = {
      buffer_index = true,
      diagnostics = {
        [vim.diagnostic.severity.ERROR] = { enabled = true },
        [vim.diagnostic.severity.WARN] = { enabled = true },
        [vim.diagnostic.severity.INFO] = { enabled = true },
        [vim.diagnostic.severity.HINT] = { enabled = true },
      },
      separator = { left = "", right = "" },
      alternate = { separator = { left = "", right = "" } },
      current = { separator = { left = "", right = "" } },
      inactive = { separator = { left = "", right = "" } },
      visible = { separator = { left = "", right = "" } },
    },
  },
}
