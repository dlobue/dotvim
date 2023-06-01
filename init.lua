local fn = vim.fn

if vim.g.neovide then
  vim.g.neovide_remember_window_size = true
  -- vim.opt.guifont = "FiraCode Nerd Font:h10"
end

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path })
end

local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost',
  { command = 'source <afile> | PackerSync', group = packer_group, pattern = 'init.lua' })

require('packer').startup(function(use, use_rocks)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- misc important functionality
  use 'tpope/vim-sleuth' -- detect indentation settings
  use 'tpope/vim-surround' -- surround operator
  use 'tpope/vim-abolish' -- easily operate on multiple variants of a word
  use 'tpope/vim-repeat' -- support for repeat on many more plugins
  use 'tpope/vim-eunuch' -- unix helpers
  use 'tpope/vim-unimpaired' -- pairs of handy bracket mappings
  use 'tpope/vim-rsi' -- add readline keybindings to cmd line mode
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'mbbill/undotree'
  use 'AndrewRadev/linediff.vim'
  use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight

  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/playground'
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'nvim-treesitter/nvim-treesitter-context'
  use 'p00f/nvim-ts-rainbow'
  use 'andymass/vim-matchup'
  use { "windwp/nvim-ts-autotag" } -- Auto close tags
  use {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup {
        check_ts = true,
      }
      require('plugins/autopairs')
    end
  } -- Autoclose quotes, parentheses etc.
  use 'RRethy/nvim-treesitter-endwise' -- wisely add "end" in ruby, Lua, Vimscript, etc.
  use 'AndrewRadev/splitjoin.vim'
  -- use {
  --   'stevearc/aerial.nvim',
  --   config = function() require('aerial').setup() end
  -- }

  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  use {
    'TimUntersberger/neogit',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require('neogit').setup {}
    end,
  }

  -- git labels
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('gitsigns').setup()
    end
  }

  use {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      "folke/neodev.nvim"  -- used to be lua-dev.nvim which setup lua lsp for vim
  }
  use { 'j-hui/fidget.nvim',
    config = function()
      require('fidget').setup()
    end
  }
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'saadparwaiz1/cmp_luasnip'
  use {
    'L3MON4D3/LuaSnip',
    config = function()
      local types = require("luasnip.util.types")

      require'luasnip'.config.setup({
          ext_opts = {
              [types.choiceNode] = {
                  active = {
                      virt_text = {{"●", "GruvboxOrange"}}
                  }
              },
              [types.insertNode] = {
                  active = {
                      virt_text = {{"●", "GruvboxBlue"}}
                  }
              }
          },
      })
    end
  } -- Snippets plugin
  -- use {
  --   'doxnit/cmp-luasnip-choice',
  --   config = function()
  --     require('cmp_luasnip_choice').setup({
  --     })
  --   end,
  -- }
  use "rafamadriz/friendly-snippets" -- Snippets

  use { 'nvim-telescope/telescope.nvim', requires = { { 'nvim-lua/plenary.nvim' } } }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use 'nvim-telescope/telescope-ui-select.nvim'

  use {
    'kyazdani42/nvim-tree.lua',
    commit = '08ab346f0312433b3f10a4a10f4b69d98138d38f',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    }
  }
  -- use 'mfussenegger/nvim-jdtls'
  use 'mfussenegger/nvim-dap'
  use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }

  use {
    "someone-stole-my-name/yaml-companion.nvim",
    requires = {
      { "neovim/nvim-lspconfig" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
    },
    config = function()
      require("telescope").load_extension("yaml_schema")
    end,
  }

  --[[ use {
    'ray-x/navigator.lua',
    -- after = 'nvim-lspconfig',
    requires = {
      { 'ray-x/guihua.lua', run = 'cd lua/fzy && make' },
      { 'neovim/nvim-lspconfig' },
    },
    config = function()
      require('navigator').setup({
        lsp = {
          format_on_save = false,
        }
      })
    end
  } ]]

  -- Post-install/update hook with call of vimscript function with argument
  use {
    'glacambre/firenvim',
    opt = true,
    cond = function ()
      return vim.g.started_by_firenvim == true
    end,
    config = function()
      vim.opt.guifont = 'Fira Code:h9'
    end,
    setup = function()
      vim.g.firenvim_config = {
        localSettings = {
          ['.*'] = {
            takeover = 'never',
          }
        }
      }
    end,
    run = function() vim.fn['firenvim#install'](0) end
  }
  use {
    'NTBBloodbath/doom-one.nvim',
    setup = function()
        -- Add color to cursor
        vim.g.doom_one_cursor_coloring = true
        -- Set :terminal colors
        vim.g.doom_one_terminal_colors = true
        -- Enable italic comments
        vim.g.doom_one_italic_comments = true
        -- Enable TS support
        vim.g.doom_one_enable_treesitter = true
        -- Color whole diagnostic text or only underline
        vim.g.doom_one_diagnostics_text_color = true
        -- Enable transparent background
        vim.g.doom_one_transparent_background = false

        -- Pumblend transparency
        vim.g.doom_one_pumblend_enable = true
        vim.g.doom_one_pumblend_transparency = 20

        -- Plugins integration
        vim.g.doom_one_plugin_neorg = false
        vim.g.doom_one_plugin_barbar = false
        vim.g.doom_one_plugin_telescope = true
        vim.g.doom_one_plugin_neogit = true
        vim.g.doom_one_plugin_nvim_tree = true
        vim.g.doom_one_plugin_dashboard = false
        vim.g.doom_one_plugin_startify = false
        vim.g.doom_one_plugin_whichkey = true
        vim.g.doom_one_plugin_indent_blankline = true
        vim.g.doom_one_plugin_vim_illuminate = true
        vim.g.doom_one_plugin_lspsaga = true
    end,
    config = function()
        vim.cmd("colorscheme doom-one")
    end,


    -- config = function()
    --   require('doom-one').setup({
    --     cursor_coloring = true,
    --     terminal_colors = true,
    --     italic_comments = true,
    --     enable_treesitter = true,
    --     transparent_background = false,
    --     pumblend = {
    --       enable = true,
    --       transparency_amount = 20,
    --     },
    --     plugins_integrations = {
    --       neorg = true,
    --       barbar = true,
    --       bufferline = false,
    --       gitgutter = false,
    --       gitsigns = true,
    --       telescope = true,
    --       neogit = true,
    --       nvim_tree = true,
    --       dashboard = true,
    --       startify = true,
    --       whichkey = true,
    --       indent_blankline = true,
    --       vim_illuminate = true,
    --       lspsaga = false,
    --     },
    --   })
    -- end,
  }


  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

require('core/options')
require('core/keymaps')
require('core/autocmds')
require('plugins/nvim-tree')
require('plugins/nvim-treesitter')
require('plugins/nvim-cmp')
require('plugins/nvim-lspconfig')
require('plugins/telescope')
require('plugins/snippets')
