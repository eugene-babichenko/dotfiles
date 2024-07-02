-- !!!! This configuration requires git and ripgrep

-- basic options
vim.o.number = true -- show line numbers
vim.wo.relativenumber = true -- show relative numbers for quicker keyboard operations
vim.o.cursorline = true -- highlight the current line
vim.o.showtabline = 2 -- always show tabline
vim.o.clipboard = "unnamedplus" -- integrate with the native OS clipboard
vim.o.termguicolors = true -- 24-bit colors in terminal
vim.g.mapleader = " " -- set the <leader> key to <space>
vim.o.timeoutlen = 200 -- set the timeout before revealing prompts
vim.o.smarttab = true -- autodetect tab mode
vim.o.tabstop = 4 -- show tabs as four spaces
vim.o.scrolloff = 15 -- keep the cursor n lines away from the screen edge when scrolling

vim.o.title = true -- show title
vim.o.titlestring = "nvim %r%f" -- format title as "nvim [RO]/path/to/file"

vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()" -- fold using treesitter
vim.o.foldenable = false -- disable folds when opening a file
vim.o.foldlevelstart = 99 -- a sufficiently large number to not fold everythin automatically

vim.o.guifont = "IosevkaTerm Nerd Font:h14" -- the font to use in GUI

-- Brewfiles are written in Ruby
vim.filetype.add({
  filename = {
    ["Brewfile"] = "ruby",
  },
})

vim.lsp.inlay_hint.enable(true)

-- settings specific to Neovide GUI client
if vim.g.neovide then
  -- neovide starts with pwd == "/". $HOME is more practical
  vim.cmd.cd(vim.fn.environ()["HOME"])
end

-- install lazy.nvim if not present
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

-- configure plugins
require("lazy").setup({
  -- automatically check for plugin updates
  checker = {
    enabled = true,
    notify = true,
    frequency = 3600,
  },

  -- Manage key bindings and provide a nice popup with help. The keybindings are specified
  -- after the plugins setup. Press <space>? for full help.
  { "folke/which-key.nvim", opts = {} },

  -- general editor styling
  {
    "ellisonleao/gruvbox.nvim",
    config = function()
      require("gruvbox").setup({})
      vim.cmd.colorscheme("gruvbox")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {},
  },
  {
    "akinsho/bufferline.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "ellisonleao/gruvbox.nvim",
    },
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level)
          local icon = level:match("error") and "" or ""
          return " " .. icon .. " " .. count
        end,
        -- Show buffer numbers in the tabline. These are later used for <leader>[number]
        -- quick navigation.
        numbers = function(opts) return opts.ordinal end,
      },
    },
  },
  -- fancy command bar, search bar and notifications
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {},
  },
  -- distraction free code editing
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {},
  },

  -- proper project handling
  {
    "ahmedkhalf/project.nvim",
    config = function() require("project_nvim").setup({}) end,
  },

  -- code styling
  -- better code highlithing without LSP
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
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
      },
      highlight = {
        enable = true,
      },
    },
  },
  -- Highlight headers in markdown
  {
    "lukas-reineke/headlines.nvim",
    ft = "markdown",
    dependencies = "nvim-treesitter/nvim-treesitter",
    opts = {
      markdown = {
        -- disable bullets, display just raw headers
        bullet_highlights = {},
        bullets = {},
      },
    },
  },
  -- colored braces in code for better readability
  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function() require("rainbow-delimiters.setup").setup({}) end,
  },
  -- show indentation lines
  {
    "lukas-reineke/indent-blankline.nvim",
    name = "ibl",
    config = function() require("ibl").setup() end,
  },

  -- git support
  -- magit-inspired git ui
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = true,
  },
  -- git gutter and hunk manipulation
  { "lewis6991/gitsigns.nvim", opts = {} },

  -- tool management
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "prettier",
      },
    },
  },

  -- code editing
  -- automatic pairs for braces and other stuff
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
  -- guess the file indentation style and configure nvim accordingly
  "tpope/vim-sleuth",
  -- comment single line with gcc, multiple line with gc + motion, selected block with gb
  { "numToStr/Comment.nvim", event = "VeryLazy", opts = {} },
  -- LSP setup
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
      "folke/neodev.nvim",
      "linrongbin16/lsp-progress.nvim",
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
  },
  { "folke/trouble.nvim", cmd = "Trouble", opts = {} },
  -- autocompletions
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      local cmp = require("cmp")
      cmp.setup({
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
        },
        mapping = {
          -- Navigation: Tab will move you down, you can use arrows for navigations.
          ["<tab>"] = cmp.mapping(
            cmp.mapping.select_next_item({
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
          ["<down>"] = cmp.mapping(
            cmp.mapping.select_next_item({
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
  },
  -- specify alternative styling when LSP is not available or is insufficient
  {
    "stevearc/conform.nvim",
    lazy = true,
    opts = {
      formatters_by_ft = {
        lua = { "stylua" }, -- the most sane way to style Lua files
        markdown = { "prettier" }, -- the language server for markdown doesn't do formatting
      },
      formatters = {
        prettier = {
          -- wrap lines in markdown files at 80 symbols
          prepend_args = { "--prose-wrap", "always" },
        },
      },
    },
  },

  -- navigation
  -- Project tree
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup({
        view = { width = 40 },
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = true,
        },
      })

      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
  },
  -- different utilities for fuzzy searching and nice lists
  {
    "nvim-telescope/telescope.nvim",
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
            find_command = { "rg", "--files", "--hidden", "--glob=!**/.git/*" },
          },
        },
      })

      -- replace the default selection interface
      require("telescope").load_extension("ui-select")
    end,
  },
  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
  },
  "ggandor/leap.nvim",

  -- Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = "markdown",
    build = function() vim.fn["mkdp#util#install"]() end,
    config = function() vim.g.mkdp_theme = "dark" end,
  },
})

local function format(bufnr)
  require("conform").format({ bufnr = bufnr, lsp_fallback = true })
end

local function quit_confirm(callback)
  if vim.fn.confirm("Quit nvim?", "&Yes\n&No", 1) == 1 then
    callback()
  end
end

local open_settings = {
  function() vim.cmd.edit(vim.fn.getenv("MYVIMRC")) end,
  "Open init.lua",
}

require("leap").create_default_mappings()

-- format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(args) format(args.buf) end,
})

-- key bindings
local telescope_builtin = require("telescope.builtin")
-- Some keybindings are wrapped into functions for proper lazy loading.
-- Require happens at call time instead of the time of running init.lua.
local mappings = {
  -- disable horizontal scrolling
  ["<ScrollWheelRight>"] = { "<Nop>", "which_key_ignore" },
  ["<ScrollWheelLeft>"] = { "<Nop>", "which_key_ignore" },
  ["<S-ScrollWheelUp>"] = { "<Nop>", "which_key_ignore" },
  ["<S-ScrollWheelDown>"] = { "<Nop>", "which_key_ignore" },

  ["<D-,>"] = open_settings,
  ["<backspace>"] = {
    function() vim.cmd.edit("#") end,
    "Go to previous file",
  },
  ["<leader>"] = {
    ["?"] = { require("which-key").show, "Show available keybindings" },
    q = {
      function()
        if #vim.api.nvim_list_wins() == 1 then
          quit_confirm(vim.cmd.quit)
        else
          vim.cmd.quit()
        end
      end,
      "Quit current window",
    },
    s = {
      name = "split",
      h = { vim.cmd.split, "New horizontal split" },
      v = { vim.cmd.vsplit, "New vertical split" },
    },
    e = {
      function() quit_confirm(vim.cmd.quitall) end,
      "Quit Neovim",
    },
    h = { telescope_builtin.help_tags, "Search help" },
    m = { require("telescope").extensions.notify.notify, "Message history" },
    -- lazy
    z = { function() require("zen-mode").toggle({}) end, "Toggle Zen mode" },
    g = {
      name = "git",
      g = {
        -- lazy
        function() require("neogit").open() end,
        "Open Neogit",
      },
      h = {
        name = "hunk",
        s = { require("gitsigns").stage_hunk, "Stage hunk" },
        u = { require("gitsigns").undo_stage_hunk, "Undo stage hunk" },
        r = { require("gitsigns").reset_hunk, "Reset hunk" },
      },
      b = { telescope_builtin.git_branches, "Select git branch" },
      s = { telescope_builtin.git_stash, "Unstash" },
    },
    t = { vim.cmd.terminal, "Open terminal" },
    b = {
      name = "buffers",
      b = {
        function()
          vim.ui.input({ prompt = "Buffer number: " }, function(input)
            if input ~= nil then
              require("bufferline").go_to(input, true)
            end
          end)
        end,
        "Go to buffer by displayed number",
      },
      l = { telescope_builtin.buffers, "List buffers" },
      d = { vim.cmd.bd, "Delete buffer" },
      p = {
        function() require("bufferline").go_to(-1, false) end,
        "Previous buffer",
      },
      n = {
        function() require("bufferline").go_to(1, false) end,
        "Next buffer",
      },
    },
    ["<leader>"] = { vim.cmd.nohlsearch, "Remove search highlights" },
    l = {
      name = "lsp",
      d = { telescope_builtin.lsp_definitions, "Go to definition" },
      r = { telescope_builtin.lsp_references, "Show references" },
      n = { vim.lsp.buf.rename, "Rename" },
      a = { vim.lsp.buf.code_action, "Code actions" },
      f = {
        function()
          local bufnr = vim.api.nvim_get_current_buf()
          format(bufnr)
        end,
        "Format current file",
      },
      e = { "<cmd>Trouble diagnostics toggle<cr>", "Show diagnostics" },
      t = { telescope_builtin.lsp_type_definitions, "Show type definitions" },
    },
    f = {
      name = "file",
      c = open_settings,
      t = {
        -- lazy
        function() require("nvim-tree.api").tree.toggle({ find_file = true }) end,
        "Toggle project tree",
      },
      w = { vim.cmd.write, "Save file" },
      f = { telescope_builtin.find_files, "Find files" },
      g = { telescope_builtin.live_grep, "Find in project" },
      P = { "<Plug>MarkdownPreview", "Open markdown preview" },
    },
    p = {
      "<cmd>Telescope projects<cr>",
      "Recent projects",
    },
  },
}

-- quickly select buffers based on displayed numbers
for i = 1, 9 do
  mappings["<leader>"][tostring(i)] = {
    function() require("bufferline").go_to(i, true) end,
    string.format("Go to buffer %s", i),
  }
end

require("which-key").register(mappings)
