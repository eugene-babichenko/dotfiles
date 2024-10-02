require("leap").create_default_mappings()

local utils = require("config.utils")
local wk = require("which-key")
local gitsigns = require("gitsigns")

local function todo() return require("todo-comments") end

wk.add({
  {
    "<backspace>",
    function() vim.cmd.edit("#") end,
    desc = "Go to previous file",
  },

  { "[h", gitsigns.previous_hunk, desc = "Previous hunk" },
  { "[t", todo().jump_prev, desc = "Previous todo" },
  {
    "[d",
    "<cmd>Lspsaga diagnostic_jump_prev<cr>",
    desc = "Previous diagnostic",
  },

  { "]h", gitsigns.next_hunk, desc = "Next hunk" },
  { "]t", todo().jump_next, desc = "Next todo" },
  { "]d", "<cmd>Lspsaga diagnostic_jump_next<cr>", desc = "Next diagnostic" },

  { "<leader>?", wk.show, desc = "Show keybindings" },

  { "<leader>s", group = "split" },
  { "<leader>sh", vim.cmd.split, desc = "New horizontal split" },
  { "<leader>sv", vim.cmd.vsplit, desc = "New vertical split" },

  { "<leader>h", "<cmd>Telescope help_tags<cr>", desc = "Search help" },

  {
    "<leader>z",
    function() require("zen-mode").toggle() end,
    desc = "Toggle Zen mode",
  },

  { "<leader>g", group = "git" },
  {
    "<leader>gg",
    function() require("neogit").open() end,
    desc = "Open Neogit",
  },

  {
    "<leader>gb",
    "<cmd>Neogit branch delete<cr>",
    desc = "Branch",
  },

  { "<leader>gp", "<cmd>Neogit pull<cr>", desc = "Pull from remote" },
  { "<leader>gP", "<cmd>Neogit push<cr>", desc = "Pull from remote" },
  { "<leader>gc", "<cmd>Neogit commit<cr>", desc = "Commit" },

  { "<leader>gs", group = "stash" },
  { "<leader>gsp", "<cmd>Telescope git_stash<cr>", desc = "Unstash" },
  { "<leader>gss", "<cmd>Neogit stash<cr>", desc = "Stash" },

  { "<leader>gh", group = "hunk" },
  { "<leader>ghh", gitsigns.preview_hunk, desc = "Preview hunk" },
  { "<leader>ghs", gitsigns.stage_hunk, desc = "Stage hunk" },
  { "<leader>ghu", gitsigns.unstage_hunk, desc = "Unstage hunk" },
  { "<leader>ghr", gitsigns.reset_hunk, desc = "Reset hunk" },

  { "<leader>t", "<cmd>Trouble todo toggle<cr>", desc = "Show todos" },

  { "<leader>p", "<cmd>Telescope projects<cr>", desc = "Recent projects" },

  { "<leader>f", group = "file" },
  { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
  { "<leader>fb", "<cmd>Yazi<cr>", desc = "Browse files with Yazi" },
  { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Find in project" },
  {
    "<leader>fc",
    function() vim.cmd.edit(vim.fn.getenv("MYVIMRC")) end,
    desc = "Open init.lua",
  },
  { "<leader>fP", "<Plug>MarkdownPreview", desc = "Open markdown preview" },

  { "<leader>l", group = "lsp" },
  {
    "<leader>ld",
    "<cmd>Telescope lsp_definitions<cr>",
    desc = "Go to definition",
  },
  { "<leader>lr", "<cmd>Lspsaga finder<cr>", desc = "Show references" },
  { "<leader>ln", vim.lsp.buf.rename, desc = "Rename symbol" },
  { "<leader>la", "<cmd>Lspsaga code_action<cr>", desc = "Code actions" },
  {
    "<leader>le",
    "<cmd>Trouble diagnostics toggle<cr>",
    desc = "Show diagnostics",
  },
  {
    "<leader>lt",
    "<cmd>Telescope lsp_type_definitions<cr>",
    desc = "Show type definitions",
  },
  {
    "<leader>ls",
    "<cmd>Telescope lsp_document_symbols<cr>",
    desc = "Show document symbols",
  },

  {
    "<leader>F",
    function()
      local bufnr = vim.api.nvim_get_current_buf()
      utils.format(bufnr)
    end,
    desc = "Format current file",
  },

  { "<leader>b", "<cmd>Telescope buffers<cr>", desc = "List buffers" },

  { "<leader>L", "<cmd>Lazy<cr>", desc = "Oprn Lazy" },
})

-- quickly select buffers based on displayed numbers
for i = 1, 9 do
  wk.add({
    {
      string.format("%s", i),
      string.format("<cmd>BufferGoto %s<cr>", i),
      hidden = true,
    },
  })
end
