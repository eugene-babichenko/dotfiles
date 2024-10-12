local function git_status()
  local status = { ahead = 0, behind = 0 }
  local job = require("plenary.job")
  job
    :new({
      command = "git",
      args = { "rev-list", "--left-right", "--count", "HEAD...@{upstream}" },
      on_exit = function(j, code)
        if code ~= 0 then
          return
        end

        local res = j:result()[1]
        if type(res) ~= "string" then
          return
        end

        local ok, ahead, behind = pcall(string.match, res, "(%d+)%s+(%d+)")
        if not ok then
          return
        end
        status = { ahead = tonumber(ahead), behind = tonumber(behind) }
      end,
    })
    :sync()

  local ahead = status.ahead > 0 and "↑" .. status.ahead or ""
  local behind = status.behind > 0 and "↓" .. status.behind or ""
  return ahead .. behind
end

return {
  "nvim-lualine/lualine.nvim",
  dependencies = "nvim-tree/nvim-web-devicons",
  opts = {
    options = {
      component_separators = "|",
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff", git_status },
      lualine_c = {
        {
          "diagnostics",
          sources = { "nvim_workspace_diagnostic" },
        },
      },
      lualine_x = {
        require("lsp-progress").progress,
      },
      lualine_y = {
        {
          require("lazy.status").updates,
          cond = require("lazy.status").has_updates,
        },
        "encoding",
        "fileformat",
        "filetype",
      },
      lualine_z = {
        {
          "location",
          left_padding = 2,
        },
      },
    },
  },
}
