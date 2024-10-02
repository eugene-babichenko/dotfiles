-- basic options
vim.o.number = true -- show line numbers
vim.wo.relativenumber = true -- show relative numbers for quicker keyboard operations
vim.o.cursorline = true -- highlight the current line
vim.o.showtabline = 2 -- always show tabline
vim.o.clipboard = "unnamedplus" -- integrate with the native OS clipboard
vim.o.termguicolors = true -- 24-bit colors in terminal
vim.o.timeoutlen = 200 -- set the timeout before revealing prompts
vim.o.smarttab = true -- autodetect tab mode
vim.o.tabstop = 4 -- show tabs as four spaces
vim.o.scrolloff = 15 -- keep the cursor n lines away from the screen edge when scrolling
vim.o.completeopt = "menu,preview,menuone,noselect"
vim.o.mousescroll = "ver:3,hor:0" -- disable horizontal scroll
vim.o.signcolumn = "yes" -- show sign column to avoid text shifting

vim.o.title = true -- show title
vim.o.titlestring = "nvim %r%f" -- format title as "nvim [RO]/path/to/file"

vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()" -- fold using treesitter
vim.o.foldenable = false -- disable folds when opening a file
vim.o.foldlevelstart = 99 -- a sufficiently large number to not fold everythin automatically

-- Brewfiles are written in Ruby
vim.filetype.add({
  filename = {
    ["Brewfile"] = "ruby",
  },
})

vim.lsp.inlay_hint.enable(true)

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = "󰌵",
      [vim.diagnostic.severity.HINT] = "󰌵",
    },
  },
})

vim.o.guifont = "IosevkaTerm Nerd Font:h14" -- the font to use in GUI
-- settings specific to Neovide GUI client
if vim.g.neovide then
  -- neovide starts with pwd == "/". $HOME is more practical
  vim.cmd.cd(vim.fn.environ()["HOME"])
end
