-- autocompletions
return {
  "hrsh7th/nvim-cmp",
  event = "VeryLazy",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",
    "zbirenbaum/copilot.lua",
    "zbirenbaum/copilot-cmp",
  },
  config = function()
    require("copilot").setup({
      enabled = true,
      suggestion = { enabled = false },
      panel = { enabled = false },
    })
    require("copilot_cmp").setup()
    require("luasnip.loaders.from_vscode").lazy_load()
    local cmp = require("cmp")
    cmp.setup({
      sources = {
        { name = "copilot" },
        { name = "luasnip" },
        { name = "nvim_lsp" },
        { name = "path" },
      },
      mapping = {
        -- Navigation: Tab will move you down, you can use arrows for navigations.
        ["<tab>"] = cmp.mapping(
          cmp.mapping.select_next_item({
            behavior = cmp.SelectBehavior.Select,
          }),
          { "i", "s" }
        ),
        ["<down>"] = cmp.mapping(
          cmp.mapping.select_next_item({
            behavior = cmp.SelectBehavior.Select,
          }),
          { "i", "s" }
        ),
        ["<S-Tab>"] = cmp.mapping(
          cmp.mapping.select_prev_item({
            behavior = cmp.SelectBehavior.Select,
          }),
          { "i", "s" }
        ),
        ["<up>"] = cmp.mapping(
          cmp.mapping.select_prev_item({
            behavior = cmp.SelectBehavior.Select,
          }),
          { "i", "s" }
        ),
        -- Confirm on Enter. Requires selection first.
        ["<cr>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        }),
      },
    })
  end,
}
