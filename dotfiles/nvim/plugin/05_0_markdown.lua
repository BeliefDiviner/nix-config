vim.pack.add({
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/MeanderingProgrammer/render-markdown.nvim",
})

require("render-markdown").setup({
	file_types = { "markdown", "vimwiki" },
})
vim.treesitter.language.register("markdown", "vimwiki")
vim.keymap.set("n", "<localleader>p", require("render-markdown").toggle, { noremap = true })
