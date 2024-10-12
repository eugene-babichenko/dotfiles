return {
  "nvim-neotest/neotest",
  event = "VeryLazy",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "https://github.com/nvim-neotest/neotest-go",
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-go"),
      },
    })
  end,
}
