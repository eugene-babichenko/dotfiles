-- specify alternative styling when LSP is not available or is insufficient
return {
  "stevearc/conform.nvim",
  lazy = true,
  opts = {
    formatters_by_ft = {
      lua = { "stylua" }, -- the most sane way to style Lua files
      markdown = { "prettier" }, -- the language server for markdown doesn't do formatting
    },
    formatters = {
      prettier = {
        -- wrap lines in markdown files at 80 symbols
        prepend_args = { "--prose-wrap", "always" },
      },
    },
  },
}
