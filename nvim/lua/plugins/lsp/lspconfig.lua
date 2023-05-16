-- import lspconfig plugin safely
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	vim.notify("lspconfig plugin start failed!")
	return
end

-- import cmp-nvim-lsp plugin safely
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
	vim.notify("cmp_nvim_lsp plugin start failed!")
	return
end

-- import typescript plugin safely
local typescript_setup, typescript = pcall(require, "typescript")
if not typescript_setup then
	vim.notify("typescript plugin start failed!")
	return
end

local npm_path = os.getenv("HOMEBREW_PREFIX") .. "/lib/node_modules/npm/bin"

-- services for mason to auto install
local services_map = {

	-- configure tsserver
	tsserver = {
		filetypes = {
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
		},
	},

	-- configure html server
	html = {},

	-- configure css server
	cssls = {},

	-- configure tailwindcss server
	tailwindcss = {},

	-- configure emmet language server
	emmet_ls = {
		filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
	},

	-- configure lua server (with special settings)
	lua_ls = {
		settings = { -- custom settings for lua
			Lua = {
				-- make the language server recognize "vim" global
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					-- make language server aware of runtime files
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.stdpath("config") .. "/lua"] = true,
					},
				},
			},
		},
	},

	yamlls = {},

	clangd = {},

	jsonls = {},

	marksman = {},

	pyright = {},

	standardrb = {},

	sqlls = {},

	wgsl_analyzer = {},

	volar = {
		filetypes = {
			"typescript",
			"javascript",
			"javascriptreact",
			"typescriptreact",
			"vue",
			"json",
		},
	},
}

local service_names = {} -- 用于承接键值对的数组
-- 将键值对存储在数组中
for key, _ in pairs(services_map) do
	table.insert(service_names, key)
end

require("mason").setup()
-- mason_lspconfig
require("mason-lspconfig").setup({
	-- list of servers for mason to install
	ensure_installed = service_names, -- auto-install configured servers (with lspconfig)
	automatic_installation = true, -- not the same as ensure_installed
})

-- enable keybinds only for when lsp server available
local on_attach = function(client, bufnr)
	local keybind_func = require("keyBinding.key_mapping").lsp_on_attach_mapping_func

	keybind_func(client, bufnr)
end

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

for ser_name, ser_conf in pairs(services_map) do
	local config = ser_conf
	if config == nil then
		config = {
			capabilities = capabilities,
			on_attach = on_attach,
		}
	else
		config.capabilities = capabilities
		config.on_attach = on_attach
	end

	lspconfig[ser_name].setup(config)
end

-- Change the Diagnostic symbols in the sign column (gutter)
-- (not in youtube nvim video)
local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- lsp service not installed bu mason
-- require("lspconfig").dartls.setup({})

-- configure typescript server with plugin
typescript.setup({
	server = {
		capabilities = capabilities,
		on_attach = on_attach,
	},
})
