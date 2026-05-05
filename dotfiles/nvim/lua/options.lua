vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.o.clipboard = "unnamedplus"
if vim.fn.has("wsl") == 1 then
	vim.g.clipboard = {
		name = "WslClipboard",
		copy = {
			["+"] = "clip.exe",
			["*"] = "clip.exe",
		},
		paste = {
			["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
			["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
		},
		cache_enabled = 0,
	}
end

vim.o.scrolloff = 12

vim.o.number = true
vim.o.relativenumber = true

vim.o.signcolumn = "yes:2"

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true

vim.o.updatetime = 300

vim.o.termguicolors = true

vim.o.mouse = "a"

vim.keymap.set("n", "<leader><Esc>", "<Cmd>nohlsearch<CR>", { silent = true })
vim.keymap.set("t", "<Esc>", "<C-\\><C-N>", { silent = true })
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)
