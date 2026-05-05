require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"cmake",
		"cpp",
		"cuda",
		"dockerfile",
		"gitignore",
		"json",
		"latex",
		"lua",
		"markdown",
		"python",
		"sql",
		"toml",
		"vim",
		"vimdoc",
	},

	auto_install = false,

	highlight = {
		enable = true,
		disable = { "latex" },
	},

	indent = { enable = true },

	modules = {},

	sync_install = true,

	ignore_install = {},
})
