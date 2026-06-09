vim.pack.add({
	{ src = "ghh://nvim-treesitter/nvim-treesitter" },
	{ src = "ghh://nvim-treesitter/nvim-treesitter-textobjects" },
})

local blocklist = { "latex", "bibtex" }

-- Automatically install treesitter parser and enable it
vim.api.nvim_create_autocmd("FileType", {
	callback = function(ev)
		local lang = vim.treesitter.language.get_lang(ev.match)

		if vim.tbl_contains(blocklist, lang) then
			return
		end

		local available_langs = require("nvim-treesitter").get_available()
		local is_available = vim.tbl_contains(available_langs, lang)

		if is_available then
			require("nvim-treesitter").install(lang):wait()
			vim.treesitter.start()
			require("nvim-treesitter").indentexpr()
		end
	end,
})

-- Set up textobjects
local textobjects = require("nvim-treesitter-textobjects.select")
vim.keymap.set({ "x", "o" }, "af", function()
	textobjects.select_textobject("@function.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "if", function()
	textobjects.select_textobject("@function.inner", "textobjects")
end)
