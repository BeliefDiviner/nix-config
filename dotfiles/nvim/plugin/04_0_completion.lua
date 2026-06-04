vim.pack.add({
	"ghh://saghen/blink.cmp",
})

require("blink.cmp").setup({
	keymap = {
		preset = "enter",
		["<Tab>"] = { "snippet_forward", "fallback" },
		["<S-Tab>"] = { "snippet_backward", "fallback" },

		["<C-k>"] = { "select_prev", "fallback_to_mappings" },
		["<C-j>"] = { "select_next", "fallback_to_mappings" },

		["<C-b>"] = {
			function(cmp)
				return cmp.select_prev({ count = 4 })
			end,
			"fallback_to_mappings",
		},
		["<C-f>"] = {
			function(cmp)
				return cmp.select_next({ count = 4 })
			end,
			"fallback_to_mappings",
		},

		["<C-u>"] = { "scroll_documentation_up", "fallback" },
		["<C-d>"] = { "scroll_documentation_down", "fallback" },
	},

	appearance = { nerd_font_variant = "mono" },

	completion = {
		documentation = { auto_show = true },
		list = {
			selection = { preselect = true, auto_insert = false },
			cycle = { from_top = true },
		},
	},

	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},

	fuzzy = { implementation = "rust" },
})
