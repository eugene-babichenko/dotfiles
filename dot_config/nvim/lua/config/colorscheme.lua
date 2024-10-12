vim.cmd.colorscheme("gruvbox")

vim.api.nvim_set_hl(0, "StatusLine", { link = "Normal" })
vim.api.nvim_set_hl(0, "StatusLineNC", { link = "Normal" })
vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

local buffer_states = { "Alternate", "Current", "Inactive", "Visible" }
for _, state in ipairs(buffer_states) do
  local prefix = "Buffer" .. state
  vim.api.nvim_set_hl(0, prefix .. "Mod", { link = prefix })
end
