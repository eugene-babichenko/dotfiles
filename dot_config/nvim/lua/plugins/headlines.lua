-- Highlight headers in markdown
return {
  "lukas-reineke/headlines.nvim",
  ft = "markdown",
  dependencies = "nvim-treesitter/nvim-treesitter",
  opts = {
    markdown = {
      -- disable bullets, display just raw headers
      bullet_highlights = {},
      bullets = {},
    },
  },
}
