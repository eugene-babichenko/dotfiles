local utils = require("config.utils")

-- format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(args) utils.format(args.buf) end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "LspProgressStatusUpdated",
  callback = require("lualine").refresh,
})
