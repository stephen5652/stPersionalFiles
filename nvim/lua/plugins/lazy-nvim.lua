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
    tag = "*",
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
  version = "*", 
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()

    require("plugins.bufferline")
  end,
},

{
  "nvim-tree/nvim-tree.lua",
  version = "*",
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

})
