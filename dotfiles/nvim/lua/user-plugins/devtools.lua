return {
	-- Language Server Protocol config helpers.
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",

	-- LSP, linter, formatter tool installer.
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		config = function()
			require("mason-tool-installer").setup({
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

	-- LSP Language Servers.
	"neovim/nvim-lspconfig",

	-- Signature Help
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		opts = {},
		config = function(_, opts)
			require("lsp_signature").setup(opts)
		end,
	},

	-- LSP Linters.
	"mfussenegger/nvim-lint",

	-- LSP Formatters.
	"stevearc/conform.nvim",

	-- Developer tools.
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},
	"lewis6991/gitsigns.nvim",
	"sindrets/diffview.nvim",
	"folke/lsp-colors.nvim",

	-- Code highlighting.
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	"HiPhish/jinja.vim",
}
