local M = {}

M.format = function(bufnr)
  require("conform").format({ bufnr = bufnr, lsp_fallback = true })
end

return M
