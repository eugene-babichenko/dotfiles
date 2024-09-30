return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
  },
  branch = "0.1.x",
  config = function()
    -- reconfigure to show hidden files and dirs
    local telescope = require("telescope")
    local telescope_config = require("telescope.config")

    local vimgrep_arguments =
      { unpack(telescope_config.values.vimgrep_arguments) }
    table.insert(vimgrep_arguments, "--hidden")
    table.insert(vimgrep_arguments, "--glob")
    table.insert(vimgrep_arguments, "!**/.git/*")

    telescope.setup({
      initial_mode = "insert",
      defaults = {
        vimgrep_arguments = vimgrep_arguments,
      },
      pickers = {
        find_files = {
          hidden = true,
          find_command = {
            "rg",
            "--files",
            "--hidden",
            "--unrestricted", -- search gitingored files
            "--glob=!**/.git/*",
          },
        },
      },
    })

    -- replace the default selection interface
    require("telescope").load_extension("ui-select")
  end,
}
