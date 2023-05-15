local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "folke/which-key.nvim",
    config = function() 
      require("keyBinding/which-key")
    end, 
  },


  {
    "nvim-telescope/telescope-ui-select.nvim",
    lazy = true,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    lazy = true,
  },
  {
'kdheepak/lazygit.nvim',
lazy = true,
  },
{
  "tiagovla/scope.nvim",
lazy = true,
},

{
    "akinsho/toggleterm.nvim",
    lazy = true,
    config = function()
require("plugins.toggleterm")
    end,
  },



{
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
-- or                              , branch = '0.1.1',
      dependencies = {
        'nvim-lua/plenary.nvim',
'nvim-treesitter/nvim-treesitter',
      },
    config = function()
require("plugins.telescope")
      end,

    },


{
  'akinsho/bufferline.nvim', 
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()

    require("plugins.bufferline")
  end,
},

{
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons", 
  },
  config = function()
    require("plugins.nvim-tree")
  end,
},


  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufNewFile", "BufReadPost" },
    build = ":TSUpdate",
    config = function()
      require("plugins.treesitter")
    end,
  },



  {

"williamboman/mason.nvim",
    config = function()
require('plugins.mason')
    end,
  },

  {
"neovim/nvim-lspconfig",
    config = function()
require("plugins.lsp.lspconfig")
    end,
  },

  {
"hrsh7th/cmp-nvim-lsp",
  },

  {
"hrsh7th/nvim-cmp",
    config = function()
      require("plugins.cmp.cmp")
  end,
  },

  {
"onsails/lspkind.nvim",
  },

  {
"hrsh7th/cmp-buffer",
  },


  {
"hrsh7th/cmp-path",
  },

  {
"hrsh7th/cmp-cmdline",
  },

  {
"L3MON4D3/LuaSnip",
  },


  {
"saadparwaiz1/cmp_luasnip",
  },

  {
"rafamadriz/friendly-snippets",
  },

  {
"hrsh7th/cmp-vsnip",
  },

  {

    "williamboman/mason-lspconfig.nvim",
    config = function()

    end,
  },


})
