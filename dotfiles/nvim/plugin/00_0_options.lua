vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

if vim.fn.has("wsl") == 1 and vim.fn.executable("win32yank.exe") then
    vim.g.clipboard = {
        name = "win32yank",
        copy = {
            ["+"] = "win32yank.exe -i --crlf",
            ["*"] = "win32yank.exe -i --crlf",
        },
        paste = {
            ["+"] = "win32yank.exe -o --lf",
            ["*"] = "win32yank.exe -o --lf",
        },
        cache_enabled = true,
    }
    vim.opt.clipboard = "unnamedplus"
elseif vim.fn.executable("pbcopy") then
    vim.opt.clipboard = "unnamedplus"
end

vim.opt.scrolloff = 12

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.signcolumn = "yes:2"

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.updatetime = 300

vim.opt.termguicolors = true

vim.opt.mouse = "a"

vim.keymap.set("n", "<leader><Esc>", "<Cmd>nohlsearch<CR>", { silent = true })
vim.keymap.set("t", "<Esc>", "<C-\\><C-N>", { silent = true })
