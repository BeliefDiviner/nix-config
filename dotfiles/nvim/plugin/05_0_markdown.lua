vim.pack.add({
	"ghh://nvim-tree/nvim-web-devicons",
	"ghh://MeanderingProgrammer/render-markdown.nvim",
})

require("render-markdown").setup({
	file_types = { "markdown", "vimwiki" },
})
vim.treesitter.language.register("markdown", "vimwiki")
vim.keymap.set("n", "<localleader>p", require("render-markdown").toggle, { noremap = true })
