-- better code highlithing without LSP
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require("nvim-treesitter.configs").setup({
      sync_install = false,
      auto_install = false,
      ensure_installed = {
        "lua",
        "vimdoc",
        "rust",
        "go",
        "markdown_inline",
        "json",
        "yaml",
        "toml",
        "make",
        "templ",
        "ruby",
        "dockerfile",
        "fish",
        "typescript",
        "sql",
      },
      highlight = {
        enable = true,
      },
      ignore_install = {},
      textobjects = {
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]f"] = {
              query = "@call.outer",
              desc = "Next function call start",
            },
            ["]m"] = {
              query = "@function.outer",
              desc = "Next method/function def start",
            },
            ["]c"] = { query = "@class.outer", desc = "Next class start" },
            ["]i"] = {
              query = "@conditional.outer",
              desc = "Next conditional start",
            },
            ["]l"] = { query = "@loop.outer", desc = "Next loop start" },

            ["]s"] = {
              query = "@scope",
              query_group = "locals",
              desc = "Next scope",
            },
            ["]z"] = {
              query = "@fold",
              query_group = "folds",
              desc = "Next fold",
            },
          },
          goto_next_end = {
            ["]F"] = { query = "@call.outer", desc = "Next function call end" },
            ["]M"] = {
              query = "@function.outer",
              desc = "Next method/function def end",
            },
            ["]C"] = { query = "@class.outer", desc = "Next class end" },
            ["]I"] = {
              query = "@conditional.outer",
              desc = "Next conditional end",
            },
            ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
          },
          goto_previous_start = {
            ["[f"] = {
              query = "@call.outer",
              desc = "Prev function call start",
            },
            ["[m"] = {
              query = "@function.outer",
              desc = "Prev method/function def start",
            },
            ["[c"] = { query = "@class.outer", desc = "Prev class start" },
            ["[i"] = {
              query = "@conditional.outer",
              desc = "Prev conditional start",
            },
            ["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
          },
          goto_previous_end = {
            ["[F"] = { query = "@call.outer", desc = "Prev function call end" },
            ["[M"] = {
              query = "@function.outer",
              desc = "Prev method/function def end",
            },
            ["[C"] = { query = "@class.outer", desc = "Prev class end" },
            ["[I"] = {
              query = "@conditional.outer",
              desc = "Prev conditional end",
            },
            ["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
          },
        },
      },
    })
  end,
}
