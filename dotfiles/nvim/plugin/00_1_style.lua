vim.pack.add({
	"ghh://ellisonleao/gruvbox.nvim",
	"ghh://nvim-tree/nvim-web-devicons",
	"ghh://nvim-lualine/lualine.nvim",
})

require("gruvbox").setup({ transparent_mode = true })
vim.cmd("colorscheme gruvbox")

-- Make all floats consistently solud colour.
vim.api.nvim_set_hl(0, "NormalFloat", { link = "Pmenu" })
vim.api.nvim_set_hl(0, "FloatBorder", { link = "PmenuBorder" })
vim.api.nvim_set_hl(0, "@markup.raw.markdown_inline", { bg = "NONE" })

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "gruvbox",
	},
	sections = {
		lualine_b = {
			{
				function()
					return vim.g.remote_neovim_host and ("Remote: %s"):format(vim.uv.os_gethostname()) or ""
				end,
				padding = { right = 1, left = 1 },
				separator = { left = "", right = "" },
			},
		},
		lualine_c = { {
			"filename",
			path = 1,
		} },
	},
})
