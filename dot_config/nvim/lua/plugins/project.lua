-- proper project handling
return {
  "ahmedkhalf/project.nvim",
  event = "VeryLazy",
  config = function() require("project_nvim").setup({}) end,
}
