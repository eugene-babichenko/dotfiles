local function config()
  local header = {
    type = "text",
    val = {
      [[  |\__/,|   (`\  ]],
      [[  |_ _  |.--.) ) ]],
      [[  ( T   )     /  ]],
      [[ (((^_(((/(((_/  ]],
    },
    opts = {
      position = "center",
      hl = "Type",
    },
  }

  local version = vim.version()

  local section = {
    header = header,
    version = {
      type = "text",
      val = string.format(
        "NVIM v%s.%s.%s-%s %s",
        version.major,
        version.minor,
        version.patch,
        version.prerelease,
        version.build
      ),
      opts = {
        position = "center",
        hl = "Ignore",
      },
    },
    fortune = {
      type = "text",
      val = "", -- Set during config as we can't require alpha in lazy opts
      opts = {
        position = "center",
        hl = "Comment",
      },
    },
    lazy = {
      type = "text",
      val = "", -- Set by autocommand created in lazy config
      opts = {
        position = "center",
        hl = "Ignore",
      },
    },
  }

  local dashboard = {
    section = section,
    config = {
      layout = {
        { type = "padding", val = 1 },
        section.header,
        { type = "padding", val = 2 },
        section.version,
        { type = "padding", val = 1 },
        section.lazy,
        { type = "padding", val = 1 },
        section.fortune,
      },
    },
  }

  dashboard.section.fortune.val = require("alpha.fortune")(60)

  require("alpha").setup(dashboard.config)

  vim.api.nvim_create_autocmd("User", {
    pattern = "LazyVimStarted",
    once = true,
    callback = function()
      local stats = require("lazy").stats()
      local ms = math.floor(stats.startuptime * 100) / 100
      dashboard.section.lazy.val = "Lazy-loaded "
        .. stats.loaded
        .. " of "
        .. stats.count
        .. " plugins in "
        .. ms
        .. "ms"
      pcall(vim.cmd.AlphaRedraw)
    end,
  })
end

return {
  "goolord/alpha-nvim",
  config = config,
}
