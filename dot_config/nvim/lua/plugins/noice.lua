-- fancy command bar, search bar and notifications
return {
  "folke/noice.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  opts = {
    lsp = {
      progress = {
        enabled = false,
      },
    },
  },
}
