local servers = {
	-- Generic LSP wrapper for formatters.
	"efm",

	-- LaTeX
	"texlab",

	-- Lua
	"lua_ls",
	"stylua",

	-- Markdown & Writing
	"taplo",
	"markdown_oxide",
	"vale_ls",

	-- Nix Language
	"nil_ls",

	-- Python
	-- "pyright",
	-- "ruff",

	-- typst
	"tinymist",
}

-- Non-LSP formatters, to be wrapped with efm.
-- Typically only one is needed per language.
-- Also includes other tools like debuggers and a LaTeX compiler.
local tools = {
	"tectonic", -- LaTeX compiler
	"tex-fmt", -- LaTeX formatter
	"mdformat", -- Markdown
	"nixfmt", -- Nix Language
	"typstyle", -- typst
}

-- Per-server overrides (merged on top of nvim-lspconfig defaults)
local overrides = {
	-- <server lspconfig name> = {<language server options table>},
	efm = {
		init_options = { documentFormatting = true },
		filetypes = { "tex", "markdown", "nix" },
		settings = {
			rootMarkers = { ".git/", ".obsidian/" },
			languages = {
				-- <filetype> = {<formatter options table>},
				tex = {
					{
						formatCommand = "tex-fmt --stdin",
						formatStdin = true,
					},
				},
				markdown = {
					{
						formatCommand = 'prettierd "${INPUT}"',
						formatStdin = true,
					},
				},
				nix = {
					{
						formatCommand = "nixfmt",
						formatStdin = true,
					},
				},
			},
		},
	},
	texlab = {
		settings = {
			texlab = {
				build = {
					executable = "tectonic",
					args = {
						"-X",
						"compile",
						"%f",
						"--synctex",
						"--keep-logs",
						"--keep-intermediates",
					},
					onSave = true,
					forwardSearchAfter = true,
				},
				forwardSearch = {
					executable = "sioyek.exe",
					args = {
						"--reuse-window",
						"--execute-command",
						"turn_on_synctex",
						"--forward-search-file",
						"%f",
						"--forward-search-line",
						"%l",
						"%p",
					},
				},
			},
		},
	},
	tinymist = {
		settings = {
			formatterMode = "typstyle",
			exportPdf = "onSave",
			outputPath = "$root/target/$dir/$name",
			semanticTokens = "disable",
		},
	},
	vale_ls = {
		filetypes = { "asciidoc", "markdown", "text", "tex", "typst", "rst", "html", "xml" },
	},
}
for name, config in pairs(overrides) do
	vim.lsp.config(name, config)
end

-- Enable all servers unconditionally and configure defaults.
vim.pack.add({ "ghh://neovim/nvim-lspconfig" })
vim.lsp.enable(servers)

-- Mason setup only on non-NixOS
if vim.fn.isdirectory("/nix/store") == 0 then
	vim.pack.add({
		"ghh://mason-org/mason.nvim",
		"ghh://mason-org/mason-lspconfig.nvim",
		"ghh://WhoIsSethDaniel/mason-tool-installer.nvim",
	})
	require("mason").setup()
	require("mason-lspconfig").setup({
		ensure_installed = servers,
		automatic_enable = false,
	})
	require("mason-tool-installer").setup({
		ensure_installed = tools,
		integrations = {
			["mason-lspconfig"] = true, -- unsure if needed. lspconfig stuff is installed via mason-lspconfig
			["mason-null-ls"] = false,
			["mason-nvim-dap"] = false,
		},
	})
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("b.lsp", {}),
	callback = function(ev)
		local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
		local bufnr = ev.buf
		local opts = { noremap = true, buffer = bufnr }
		local bufmap = function(mode, keys, func)
			vim.keymap.set(mode, keys, func, opts)
		end
		local safe_bufmap = function(capability, mode, keys, func)
			if client:supports_method(capability) then
				bufmap(mode, keys, func)
			end
		end

		safe_bufmap("textDocument/declaration", "n", "grD", vim.lsp.buf.declaration)
		safe_bufmap("textDocument/definition", "n", "grd", vim.lsp.buf.definition)

		-- Virtual lines and text.
		bufmap("n", "<leader>dt", function()
			local current = vim.diagnostic.config().virtual_text
			vim.diagnostic.config({ virtual_text = not current })
		end)
		bufmap("n", "<leader>dl", function()
			local current = vim.diagnostic.config().virtual_lines
			vim.diagnostic.config({ virtual_lines = not current })
		end)

		-- Controlled auto-format on save.
		-- Report willSaveWaitUntil capability as missing. Ensures only our edit-on-save fires.
		local sync_capability = client.server_capabilities.textDocumentSync
		if type(sync_capability) == "table" then
			sync_capability.willSaveWaitUntil = false
		end
		if client:supports_method("textDocument/formatting") then
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = vim.api.nvim_create_augroup("b.lsp", { clear = false }),
				buffer = ev.buf,
				callback = function()
					local format = function()
						vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, async = false, timeout_ms = 1000 })
					end

					-- buf-local takes priority: nil means "no override, defer to global"
					if vim.b.lsp_format_enabled == true then
						format()
						return
					elseif vim.b.lsp_format_enabled == false then
						return
					end
					-- no buffer override, fall through to global
					if vim.g.lsp_format_enabled then
						format()
					end
				end,
			})
		end
	end,
})

vim.g.lsp_format_enabled = true
vim.api.nvim_create_user_command("LspFormat", function(opts)
	local enable = not opts.bang
	local scope = opts.args

	if scope == "buf" then
		vim.b.lsp_format_enabled = enable -- true = force on, false = force off
		vim.notify("LSP format on save " .. (enable and "enabled" or "disabled") .. " for buffer")
	elseif scope == "buf-reset" then
		vim.b.lsp_format_enabled = nil -- clear override, defer to global
		vim.notify("LSP format on save reset to global setting for buffer")
	else
		vim.g.lsp_format_enabled = enable
		vim.notify("LSP format on save " .. (enable and "enabled" or "disabled") .. " globally")
	end
end, {
	bang = true,
	nargs = "?",
	complete = function()
		return { "buf", "buf-reset" }
	end,
})
-- 	["pyright"] = function()
-- 		require("lspconfig").pyright.setup({
-- 			before_init = function(_, config)
-- 				config.settings.python.pythonPath = get_python_path(vim.fn.getcwd())
-- 			end,
-- 			on_attach = on_attach,
-- 			capabilities = capabilities,
-- 			settings = {
-- 				python = {
-- 					disableOrganizeImports = true,
-- 					analysis = {
-- 						indexing = true,
-- 						typeCheckingMode = "standard",
-- 						diagnosticMode = "workspace",
-- 						autoImportCompletions = false,
-- 						autoSearchPaths = false,
-- 						useLibraryCodeForTypes = true,
--
-- 						-- Additional rules that are not enabled as errors by default
-- 						reportPropertyTypeMismatch = "error",
-- 						reportImportCycles = "error",
-- 						reportWildcardImportFromLibrary = "error",
-- 						reportUntypedFunctionDecorator = "error",
-- 						reportUntypedClassDecorator = "error",
-- 					},
-- 				},
-- 			},
-- 		})
-- 	end,
-- })
