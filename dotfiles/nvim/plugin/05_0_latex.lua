vim.g.vimtex_complete_enabled = 0
vim.g.vimtex_compiler_enabled = 0
vim.g.vimtex_mappings_disable = { n = { "<localleader>lv" } }

vim.g.vimtex_view_method = "sioyek"
if vim.fn.has("wsl") == 1 then
	vim.g.vimtex_view_sioyek_exe = "sioyek.exe"
	vim.g.vimtex_callback_progpath = "wsl nvim"
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "tex", "bib" },
	callback = function()
		vim.keymap.set("n", "<localleader>v", "<cmd>LspTexlabForward<cr>", { buffer = true })
	end,
})

vim.pack.add({ "ghh://lervag/vimtex" })
