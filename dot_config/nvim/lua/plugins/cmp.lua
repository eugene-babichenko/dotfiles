-- autocompletions
return {
  "hrsh7th/nvim-cmp",
  event = "VeryLazy",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "rafamadriz/friendly-snippets",
    "zbirenbaum/copilot.lua",
    "zbirenbaum/copilot-cmp",
    "onsails/lspkind.nvim",
  },
  config = function()
    require("copilot").setup({
      enabled = true,
      suggestion = { enabled = false },
      panel = { enabled = false },
    })
    require("copilot_cmp").setup()

    local cmp = require("cmp")

    local next_item = cmp.mapping(
      cmp.mapping.select_next_item({
        behavior = cmp.SelectBehavior.Select,
      }),
      { "i", "s" }
    )
    local prev_item = cmp.mapping(
      cmp.mapping.select_prev_item({
        behavior = cmp.SelectBehavior.Select,
      }),
      { "i", "s" }
    )

    cmp.setup({
      sources = {
        { name = "copilot" },
        { name = "nvim_lsp" },
      },
      snippet = {
        expand = function(args) vim.snippet.expand(args.body) end,
      },
      mapping = {
        ["<tab>"] = next_item,
        ["<down>"] = next_item,
        ["<S-Tab>"] = prev_item,
        ["<up>"] = prev_item,
        ["<cr>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Insert,
          select = false,
        }),
      },
      preselect = cmp.PreselectMode.None,
      formatting = {
        format = require("lspkind").cmp_format({
          symbol_map = {
            Copilot = "",
          },
        }),
      },
      sorting = {
        priority_weight = 2,
        comparators = {
          require("copilot_cmp.comparators").prioritize,
          -- Below is the default comparator list and order for nvim-cmp
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.score,
          cmp.config.compare.recently_used,
          cmp.config.compare.locality,
          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      },
    })
  end,
}
