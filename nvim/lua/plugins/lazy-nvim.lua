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
	{ -- statusline
		"nvim-lualine/lualine.nvim",
		config = function()
			require("plugins.lualine")
		end,
	},

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
		"kdheepak/lazygit.nvim",
		lazy = true,
	},
	{
		"tiagovla/scope.nvim",
		lazy = true,
	},

	{
		"szw/vim-maximizer",
	},

	{
		"akinsho/toggleterm.nvim",
		lazy = true,
		config = function()
			require("plugins.toggleterm")
		end,
	},

	{
		"nvim-lua/plenary.nvim",
	},

	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.1",
		-- or                              , branch = '0.1.1',
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("plugins.telescope")
		end,
	},

	{
		"akinsho/bufferline.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
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

	-- Use treesitter to autoclose and autorename html tag
	-- It work with html,tsx,vue,svelte,php,rescript.
	{
		"windwp/nvim-ts-autotag",
		after = "nvim-treesitter",
	}, -- autoclose tags

	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufNewFile", "BufReadPost" },
		build = ":TSUpdate",
		config = function()
			require("plugins.treesitter")
		end,
	},

	{
		"nvim-tree/nvim-web-devicons",
	},

	{
		"williamboman/mason.nvim",
		config = function()
			require("plugins.mason")
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
		config = function()
			require("cmp_nvim_lsp").setup()
		end,
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
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup()
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		config = function() end,
	},

	{
		"jose-elias-alvarez/typescript.nvim",
	}, -- additional functionality for typescript server (e.g. rename file & update imports)

	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"jose-elias-alvarez/null-ls.nvim",
		},
	},

	{
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("plugins.cmp.null-ls")
		end,
	},

	{
		"akinsho/flutter-tools.nvim",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim", -- optional for vim.ui.select
		},
		config = function()
			require("flutter-tools").setup({})
		end,
	},

	{
		"rcarriga/nvim-notify",
		lazy = true,
		config = function()
			require("plugins.vim-motify")
		end,
	},

	{
		"folke/tokyonight.nvim", -- color scheme
		lazy = true,
	},

	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},

	{
		"glepnir/lspsaga.nvim",
		branch = "main",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
		config = function()
			require("plugins.lsp.lspsaga")
		end,
	}, -- enhanced lsp uis

	{
		"tpope/vim-surround",
	}, -- add, delete, change surroundings (it's awesome)

	{
		"inkarkat/vim-ReplaceWithRegister", -- replace with register contents using motion (gr + motion)
		config = function()
			require("Comment").setup()
		end,
	},

	-- commenting with gc
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},

	{

		"lewis6991/gitsigns.nvim", -- show line modifications on left hand side
		config = function()
			require("gitsigns").setup()
		end,
	},

	{
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
		setup = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("indent_blankline").setup({
				-- for example, context is off by default, use this to turn it on
				show_current_context = true,
				show_current_context_start = true,
				show_end_of_line = true,
			})
		end,
	},

	{
		"kevinhwang91/nvim-hlslens",
		config = function()
			require("hlslens").setup()
		end,
	},
	{
		"simrat39/symbols-outline.nvim",
		config = function()
			require("plugins.symbols-outlin")
		end,
	},

	{
		"akinsho/toggleterm.nvim",
		tag = "*",
		config = function()
			require("plugins.toggleterm")
		end,
	},

	{
		"mfussenegger/nvim-jdtls",
	},
})
