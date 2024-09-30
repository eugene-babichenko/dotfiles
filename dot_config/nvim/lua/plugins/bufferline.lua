return {
  "akinsho/bufferline.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "ellisonleao/gruvbox.nvim",
  },
  opts = {
    options = {
      diagnostics = "nvim_lsp",
      ---@diagnostic disable-next-line: unused-local
      diagnostics_indicator = function(_count, _level, diagnostics_dict)
        local s = ""

        for level, count in pairs(diagnostics_dict) do
          local icon = level:match("error") and " "
            or (level:match("warning") and " " or "󰌵")
          s = s .. icon .. " " .. count .. " "
        end

        return string.gsub(s, "^(.-)%s*$", "%1")
      end,
      -- Show buffer numbers in the tabline. These are later used for <leader>[number]
      -- quick navigation.
      numbers = function(opts) return opts.ordinal end,
    },
  },
}
