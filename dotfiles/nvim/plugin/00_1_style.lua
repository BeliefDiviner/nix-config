vim.pack.add({
	"ghh://ellisonleao/gruvbox.nvim",
	"ghh://nvim-tree/nvim-web-devicons",
	"ghh://nvim-lualine/lualine.nvim",
})

require("gruvbox").setup({ transparent_mode = true })
vim.cmd("colorscheme gruvbox")

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
