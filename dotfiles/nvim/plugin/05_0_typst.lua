vim.pack.add({
	{ src = "https://github.com/chomosuke/typst-preview.nvim", version = vim.version.range("1.*") },
})

require("typst-preview").setup({
	dependencies_bin = { -- Use binaries already in path.
		tinymist = "tinymist",
		websocat = "websocat",
	},
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "typst",
	group = vim.api.nvim_create_augroup("TypstPreviewKeymaps", { clear = true }),
	callback = function(ev)
		vim.keymap.set("n", "<localleader>v", "<cmd>TypstPreviewSyncCursor<cr>", {
			buffer = ev.buf,
			noremap = true,
			silent = true,
			desc = "Typst forward search",
		})
	end,
})
