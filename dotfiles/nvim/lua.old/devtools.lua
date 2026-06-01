return {
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
