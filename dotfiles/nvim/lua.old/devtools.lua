return {
	-- Language Server Protocol config helpers.
	"williamboman/mason.nvim",
    {
        "williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"bibtex-tidy",
					"black",
					"cmake-language-server",
					"djlint",
					"docker-compose-language-service",
					"dockerfile-language-server",
					"isort",
					"jinja-lsp",
					"latexindent",
					"lua-language-server",
					"mdformat",
					"pyright",
					"ruff",
					"selene",
					"stylua",
					"taplo",
					"vale",
				},
			})
		end,
    },

	-- LSP Linters.
	"mfussenegger/nvim-lint",

	"sindrets/diffview.nvim",

	-- Code highlighting.
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	-- "HiPhish/jinja.vim",
}
