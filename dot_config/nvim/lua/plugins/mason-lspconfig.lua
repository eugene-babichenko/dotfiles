-- LSP setup
return {
  "williamboman/mason-lspconfig.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    "folke/neodev.nvim",
  },
  config = function()
    -- neodev brings completions to init.lua
    -- It has to be set up before setting up the LSP.
    require("neodev").setup({})

    require("mason-lspconfig").setup({
      ensure_installed = {
        "rust_analyzer",
        "lua_ls",
        "gopls",
        "templ", -- a template engine for go
        "marksman", -- a language server for markdown
        "ts_ls",
      },
    })

    -- enable LSP completions
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    require("mason-lspconfig").setup_handlers({
      -- default configuration for all servers
      function(server_name)
        require("lspconfig")[server_name].setup({
          capabilities = capabilities,
        })
      end,
    })
  end,
}
