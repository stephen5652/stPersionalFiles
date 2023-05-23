local keymap = vim.keymap
local opts = { noremap = true, silent = true }

local common_key_setup = function()
	local builtin = require("telescope.builtin")

	-- use jk to enter normal mode
	keymap.set({ "i", "v", "c" }, "<leader>jk", "<ESC>")

	-- clear search highlights
	keymap.set("n", "<leader>nh", "<cmd>nohl<CR>")

	-- bufferline 左右Tab切换
	keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<CR>")
	keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<CR>")

	-- delete single character without copying into register
	keymap.set("n", "x", '"_x')

	keymap.set("i", "<C-h>", "<Left>", opts)
	keymap.set("i", "<C-j>", "<Down>", opts)
	keymap.set("i", "<C-k>", "<Up>", opts)
	keymap.set("i", "<C-l>", "<Right>", opts)

	keymap.set("i", "<C-b>", "<PageUp>", opts)
	keymap.set("i", "<C-f>", "PageDown>", opts)

	-- window management
	keymap.set("n", "<C-k>", "<c-w>k") -- focus the top window
	keymap.set("n", "<C-j>", "<c-w>j") -- focus the bottom window
	keymap.set("n", "<C-h>", "<c-w>h") -- focus the left window
	keymap.set("n", "<C-l>", "<c-w>l") -- focus the right window

	-- tab manager
	keymap.set("n", "<S-Up>", "<cmd>resize -2<CR>", opts)
	keymap.set("n", "<S-Down>", "<cmd>resize +2<CR>", opts)
	keymap.set("n", "<S-Left>", "<cmd>vertical resize -2<CR>", opts)
	keymap.set("n", "<S-Right>", "<cmd>vertical resize +2<CR>", opts)
	keymap.set("t", "<S-Up>", "<cmd>:resize +2<CR>", opts)
	keymap.set("t", "<S-Down>", "<cmd>:resize -2<CR>", opts)

	keymap.set({ "n", "i", "v" }, "<c-s>", "<cmd>w<CR>")

	-- terminal
	keymap.set("t", "<ESC>", "<c-\\><c-n>")

	-- 快速在buffer间跳转
	keymap.set("n", "<leader>1", "<cmd>BufferLineGoToBuffer 1<CR>", opts)
	keymap.set("n", "<leader>2", "<cmd>BufferLineGoToBuffer 2<CR>", opts)
	keymap.set("n", "<leader>3", "<cmd>BufferLineGoToBuffer 3<CR>", opts)
	keymap.set("n", "<leader>4", "<cmd>BufferLineGoToBuffer 4<CR>", opts)
	keymap.set("n", "<leader>5", "<cmd>BufferLineGoToBuffer 5<CR>", opts)
	keymap.set("n", "<leader>6", "<cmd>BufferLineGoToBuffer 6<CR>", opts)
	keymap.set("n", "<leader>7", "<cmd>BufferLineGoToBuffer 7<CR>", opts)
	keymap.set("n", "<leader>8", "<cmd>BufferLineGoToBuffer 8<CR>", opts)
	keymap.set("n", "<leader>9", "<cmd>BufferLineGoToBuffer 9<CR>", opts)
end

-- which key common keybings
local which_key_common_map_register = function()
	local status_ok, which_key = pcall(require, "which-key")
	-- 搜索(telescope)
	function _G.grep_string_the_file()
		require("telescope.builtin").grep_string({
			grep_open_files = true,
		})
	end

	function _G.live_grep_the_file()
		require("telescope.builtin").live_grep({
			grep_open_files = true,
		})
	end

	function _G.find_helps()
		require("telescope.builtin").help_tags()
	end

	-- terminal begin
	local Terminal = require("toggleterm.terminal").Terminal

	-- python terminal
	local pyterm = Terminal:new({
		cmd = "python3",
		direction = "horizontal",
	})

	function _G.python_toggle() -- python terminal
		pyterm:toggle()
	end

	-- common terminal
	local cuterm = Terminal:new()
	function _G.st_custome_toogle()
		cuterm:toggle()
	end

	-- float terminal
	local float_term = Terminal:new({
		direction = "float",
		float_opts = {
			border = "double",
		},
		-- function to run on opening the terminal
		on_open = function(term)
			vim.cmd("startinsert!")
			vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", opts)
		end,
	})

	function _G.st_custome_float_term()
		float_term:toggle()
	end

	local which_key_opts = { mode = "n", noremap = true, silent = true }
	local mappings = {
		["<leader>"] = {
			b = {
				name = "Buffer management",
				c = { "<cmd>bdelete %<CR>", "Delete current buffer", which_key_opts },
				p = { "<cmd>BufferLineCyclePrev<CR>", "Move cursor to pre tab", which_key_opts },
				n = { "<cmd>BufferLineCycleNext<CR>", "Move cursor to next tab", which_key_opts },
			},
			c = {
				name = "Code actions",
				S = {
					name = "Aerial Symbols window",
					o = { "<cmd>AerialOpen right<cr>", "Open", which_key_opts },
					c = { "<cmd>AerialClose<cr>", "Close", which_key_opts },
				},
				s = { "<cmd>SymbolsOutline<cr>", "Show code symbols", which_key_opts },
			},
			d = {
				name = "Debug functions",
				w = { "<cmd>lua require('dapui').toggle()<cr>", "Toogle debug window", which_key_opts },
				b = { "<cmd>lua require'dap'.toggle_breakpoint()<CR>j", "(<Leader>db)断点", which_key_opts },
				d = {
					"<cmd>lua require('dap').disconnect({ terminateDebuggee = true })<cr><cmd>lua require'dap'.close()<cr>",
					"结束",
					opts,
				},
				e = { "<cmd>lua require'dapui'.eval()<CR>", "(<Leader>de)查看变量信息", which_key_opts },
				g = {
					"<cmd>lua require'dap'.continue()<CR>",
					"(<Leader>dg)下一个断点",
					opts,
				},
				i = { "<cmd>lua require'dap'.step_into()<CR>", "(<Leader>di)进入", which_key_opts },
				n = { "<cmd>lua require'dap'.step_over()<CR>", "(<Leader>dn)下一行", which_key_opts },
				o = { "<cmd>lua require'dap'.step_out()<CR>", "(<Leader>do)退出", which_key_opts },
				p = { "<cmd>lua require'dap'.step_back()<CR>", "(<Leader>dp)上一行", which_key_opts },
				r = { "<cmd>lua require'dap'.run_last()<CR>", "(<Leader>dr)重新运行", which_key_opts },
				c = {
					"<cmd>lua require'dap'.run_to_cursor()<CR>",
					"(<Leader>rc)运行到当前光标处",
					which_key_opts,
				},
			},
			e = {
				name = "File explorer",
				e = { "<cmd>NvimTreeToggle<cr>", "Show file explorer", which_key_opts },
				f = { "<cmd>NvimTreeFindFile<cr>", "Foucus opened file in explorer", which_key_opts },
				s = { "<cmd>w<cr>", "Svae current opened file, same as <c-s>", which_key_opts },
				q = { "<cmd>q<cr>", "Quit current opened file", which_key_opts },
			},
			f = {
				name = "Find",
				f = { "<cmd>Telescope find_files<cr>", "Find File", which_key_opts },
				r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File", which_key_opts },
				s = { "<cmd>lua _G.live_grep_the_file()<cr>", "Find string in current file", which_key_opts },
				S = { "<cmd>Telescope live_grep<cr>", "Find string in workspace", which_key_opts },
				-- C = { "<cmd>Telescope grep_string<cr>", "Find cursor charactor in workspace", which_key_opts},
				-- c = { "<cmd>lua _G.grep_string_the_file()<cr>", "Find cursor charactor in cur file", which_key_opts},
				b = { "<cmd>Telescope buffers<cr>", "Show opened buffers", which_key_opts },
				h = { "<cmd>lua _G.find_helps()<cr>", "Find helps", which_key_opts },
				k = { "<cmd>Telescope keymaps<cr>", "Show all Keymaps", which_key_opts },
				["1"] = "which_key_ignore", -- special label to hide it in the popup
				-- b = {
				--   function()
				--     print("bar")
				--   end,
				--   "Foobar",
				-- }, -- you can also pass functions!
			},
			g = {
				name = "Git action",
				b = { "<cmd>Gitsigns toggle_current_line_blame<cr>", "Show current line blame", which_key_opts },
				d = { "<cmd>LazyGitFilterCurrentFile<cr>", "Show current file git history", which_key_opts },
				g = { "<cmd>LazyGitCurrentFile<cr>", "Toggle lazygit view", which_key_opts },
				h = {
					name = "Hunk actions",
					n = { "<cmd>Gitsigns next_hunk<CR>", "Next hunk", which_key_opts },
					p = { "<cmd>Gitsigns prev_hunk<cr>", "Pre hunk", which_key_opts },
					v = { "<cmd>Gitsigns preview_hunk<CR>", "Show hunk preview", which_key_opts },
				},
			},
			l = {
				name = "Develop languages info [lsp treesitter mason]",
				l = {
					name = "Lsp management",
					i = { "<cmd>LspInfo<cr>", "Lsp service info", which_key_opts },
					s = { "<cmd>LspRestart<CR>", "Restart lsp if necessary", which_key_opts },
				},
				m = {
					name = "Mason management",
					t = { "<cmd>Mason<cr>", "Toggle Mason", which_key_opts },
				},
				t = {
					name = "Treesitter management",
					l = { "<cmd>TSInstallInfo<cr>", "Treesitter list supported languages", which_key_opts },
					m = { "<cmd>TSModuleInfo<cr>", "Treesitter show installed info", which_key_opts },
				},
			},
			s = {
				name = "service",
				l = { "<cmd>LiveServer<cr>", "Open / Close live server", which_key_opts },
			},
			t = {
				name = "Terminal",
				p = { "<Cmd>lua _G.python_toggle()<CR>", "Open one python terminal", which_key_opts },
				c = { "<Cmd>lua _G.st_custome_toogle()<CR>", "Open one python terminal", which_key_opts },
				f = { "<cmd>lua _G.st_custome_float_term()<CR>", "Open one float terminal", which_key_opts },
			},
			w = {
				name = "window management",
				a = {
					"<cmd>lua require'telescope.builtin'.colorscheme()<cr>",
					"Appearance colorscheme list",
					which_key_opts,
				},
				b = { "<c-w>v", "Vertically split window", which_key_opts },
				v = { "<c-w>s", "Horizontally split window", which_key_opts },
				d = { "<c-c><cmd>Startup display<cr>", "Show Dashboard", which_key_opts },
				e = { "<c-w>=", "Make split windows equal width & height", which_key_opts },
				c = { "<cmd>close<cr>", "Close current split window", which_key_opts },
				h = { "<C-w><c-h>", "Foucus the left split window", which_key_opts },
				l = { "<C-w><c-l>", "Foucus the right split window", which_key_opts },
				k = { "<C-w><c-k>", "Foucus the top split window", which_key_opts },
				j = { "<C-w><c-j>", "Foucus the bottom split window", which_key_opts },
				o = { "<C-w><c-o>", "Close other split windows", which_key_opts },
				m = { "<cmd>MaximizerToggle<cr>", "Make split window maximization", which_key_opts },
				n = { "<cmd>tabnew %<cr>", "Make current cursor tab to new", which_key_opts },
			},
		},
		{
			prefix = "<leader>",
		},
	}

	return mappings
end

-- typescript specific keymaps (e.g. rename file and update imports)
local function which_key_java_typescript_register_func()
	local mapping = {
		["<leader>"] = {
			j = {
				name = "Java Script action",
				r = { ":TypescriptRenameFile<cr>", "Typescript rame file and upate import" },
				o = { ":TypescriptOrganizeImports<CR>", "Typescript origanize imports" },
				u = { ":TypescriptRemoveUnused<CR>", "Typescript remove unused variables" },
			},
			{
				prefix = "<leader>",
			},
		},
	}

	return mapping
end

local function lsp_on_attach_mapping_func(client, bufnr)
	local opts = { noremap = true, silent = false, buffer = bufnr }
	keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts) -- show definition, references
	keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- got to declaration
	keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
	keymap.set("n", "gp", "<Cmd>Lspsaga goto_definition<cr>", opts)
	keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
	keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
	keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
	keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
	keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
	keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
	keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
	keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
	keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts) -- see outline on right hand side
	keymap.set("n", "<leader>cm", "<cmd>echo 'jdtls say hello'<cr>", opts)
end

return {
	common_key_setup = common_key_setup,
	which_key_common_map_register = which_key_common_map_register,
	lsp_on_attach_mapping_func = lsp_on_attach_mapping_func,
	which_key_java_typescript_register_func = which_key_java_typescript_register_func,
}
