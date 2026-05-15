local on_attach = function(client, bufnr)
	local bufmap = function(keys, func)
		vim.keymap.set("n", keys, func, { buffer = bufnr })
	end

	bufmap("<leader>r", vim.lsp.buf.rename)
	bufmap("<leader>a", vim.lsp.buf.code_action)

	bufmap("gd", vim.lsp.buf.definition)
	bufmap("gD", vim.lsp.buf.declaration)
	bufmap("gI", vim.lsp.buf.implementation)
	bufmap("<leader>D", vim.lsp.buf.type_definition)

	bufmap("gr", require("telescope.builtin").lsp_references)
	bufmap("<leader>s", require("telescope.builtin").lsp_document_symbols)
	bufmap("<leader>S", require("telescope.builtin").lsp_dynamic_workspace_symbols)

	bufmap("K", vim.lsp.buf.hover)

	-- LSP Signature Help
	require("lsp_signature").on_attach({
		bind = true,
		handler_opts = {
			border = "rounded",
		},
		floating_window = true,
		hint_enable = false,
		hint_prefix = "^ ",
		hint_inline = function()
			return false
		end,
		toggle_key = "<C-k>",
		toggle_key_flip_floatwin_setting = true,
		select_signature_key = "<C-l>",
		zindex = 1,
		timer_interval = 30,
	}, bufnr)
	bufmap("<leader>k", function()
		require("lsp_signature").toggle_float_win()
	end)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Python
local path = require("lspconfig.util").path
local function get_python_path(workspace)
	-- Use activated virtualenv.
	if vim.env.VIRTUAL_ENV then
		return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
	end

	-- Find and use virtualenv in workspace directory.
	for _, pattern in ipairs({ "*", ".*" }) do
		-- Check if there's a pyenv.
		local match_pyenv = vim.fn.glob(path.join(workspace, pattern, "pyvenv.cfg"))
		if match_pyenv ~= "" then
			return path.join(path.dirname(match_pyenv), "bin", "python")
		end

		-- Check if a default poetry env is built.
		local match_poetry = vim.fn.glob(path.join(workspace, pattern, "poetry.lock"))
		if match_poetry ~= "" then
			local res = vim.fn.systemlist({ "poetry", "env", "info", "--executable" })[1]
			if res ~= "bin/python" then
				return res
			end
		end
	end

	-- Fallback to system Python.
	return "python"
end

-- mason
require("mason").setup()
require("mason-lspconfig").setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})
	end,

	["lua_ls"] = function()
		require("neodev").setup()
		require("lspconfig").lua_ls.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				Lua = {
					workspace = { checkThirdParty = false },
					telemetry = { enable = false },
				},
			},
		})
	end,

	["pyright"] = function()
		require("lspconfig").pyright.setup({
			before_init = function(_, config)
				config.settings.python.pythonPath = get_python_path(vim.fn.getcwd())
			end,
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				python = {
					disableOrganizeImports = true,
					analysis = {
						indexing = true,
						typeCheckingMode = "standard",
						diagnosticMode = "workspace",
						autoImportCompletions = false,
						autoSearchPaths = false,
						useLibraryCodeForTypes = true,

						-- Additional rules that are not enabled as errors by default
						reportPropertyTypeMismatch = "error",
						reportImportCycles = "error",
						reportWildcardImportFromLibrary = "error",
						reportUntypedFunctionDecorator = "error",
						reportUntypedClassDecorator = "error",
					},
				},
			},
		})
	end,
})
