-- import mason-null-ls plugin safely
local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
	vim.notify("mason-null-ls config failed")
	return
end

mason_null_ls.setup({
	-- list of formatters & linters for mason to install
	ensure_installed = {
		"prettier", -- ts/js formatter
		"stylua", -- lua formatter
		"eslint_d", -- ts/js linter
		"shfmt", -- shell formatter
		"rubyfmt",
		"autopep8",
		"clang_format",
		"standardrb",
		"google_java_format",
	},
	-- auto-install configured formatters & linters (with null-ls)
	automatic_installation = true,
})

-- import null-ls plugin safely
local setup, null_ls = pcall(require, "null-ls")
if not setup then
	vim.notify("null-ls config failed")
	return
end

-- for conciseness
local formatting = null_ls.builtins.formatting -- to setup formatters
local diagnostics = null_ls.builtins.diagnostics -- to setup linters

-- to setup format on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- configure null_ls
null_ls.setup({
	-- debug = true, -- use for debug null_ls, nvim command: NullLsInfo
	-- setup formatters & linters
	sources = {
		--  to disable file types use
		--  "formatting.prettier.with({disabled_filetypes = {}})" (see null-ls docs)
		formatting.clang_format.with({
			extra_filetypes = { "objc" }, -- enable  Objective-C

			disabled_filetypes = { "java" },
		}), -- clang-format is formatter for C/C++/Java/JavaScript/JSON/Objective-C/Protobuf/C# code
		formatting.autopep8, -- formats Python code to conform to the PEP 8 style guide
		formatting.prettier, -- js/ts formatter
		formatting.stylua, -- lua formatter
		diagnostics.eslint_d.with({
			-- js/ts linter
			-- only enable eslint if root has .eslintrc.js (not in youtube nvim video)
			condition = function(utils)
				return utils.root_has_file(".eslintrc.js") -- change file extension if you use something else
			end,
		}),
		-- diagnostics.swiftlint,
		formatting.swiftlint,
		formatting.shfmt, -- bash formatter
		diagnostics.standardrb, -- linter your Ruby code!
		formatting.standardrb, -- formmatter your Ruby code!
		formatting.google_java_format,
	},
	-- configure format on save
	on_attach = function(current_client, bufnr)
		if current_client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,

				callback = function()
					vim.lsp.buf.format({
						filter = function(client)
							--  only use null-ls for formatting instead of lsp server
							return client.name == "null-ls"
						end,
						bufnr = bufnr,
					})
				end,
			})
		end
	end,
})
