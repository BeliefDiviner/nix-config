vim.pack.add({
	"ghh://romus204/tree-sitter-manager.nvim",
	{ src = "ghh://nvim-treesitter/nvim-treesitter-textobjects", version = "main" },
})

require("tree-sitter-manager").setup({
	auto_install = true,
	noauto_install = { -- Built-in and alternatively managed parsers.
		"bibtex", -- Managed by VimTex
		"c",
		"latex", -- Managed by VimTex
		"lua",
		"markdown",
		"markdown_inline",
		"query",
		"vim",
		"vimdoc",
	},
	nohighlight = {
		"bibtex", -- Managed by VimTex
		"latex", -- Managed by VimTex
	},
})

-- Set up textobjects.
local textobjects = require("nvim-treesitter-textobjects.select")
vim.keymap.set({ "x", "o" }, "af", function()
	textobjects.select_textobject("@function.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "if", function()
	textobjects.select_textobject("@function.inner", "textobjects")
end)
