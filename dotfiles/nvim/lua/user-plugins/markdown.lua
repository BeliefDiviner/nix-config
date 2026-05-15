return {
	{
		"lukas-reineke/headlines.nvim",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = function()
			local fhls = {
				fat_headline_lower_string = "▔",
			}
			require("headlines").setup({
				markdown = fhls,
				rmd = fhls,
				org = fhls,
				norg = fhls,
			})
		end,
	},
	{
		"ellisonleao/glow.nvim",
		config = true,
		cmd = "Glow",
		keys = {
			{ "<localleader>p", "<Cmd>Glow<CR>", ft = "markdown" },
		},
	},
}
