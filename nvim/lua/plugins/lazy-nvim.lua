
require("lazy").setup({
  {
    "folke/which-key.nvim",
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

})
