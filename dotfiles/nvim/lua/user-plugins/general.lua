return {
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = function()
			vim.cmd("colorscheme gruvbox")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
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
		end,
	},
}
