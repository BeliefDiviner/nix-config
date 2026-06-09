vim.pack.add({
	"ghh://nvim-tree/nvim-web-devicons",
	"ghh://ibhagwan/fzf-lua",
})

local fzf = require("fzf-lua")
vim.keymap.set("n", "<leader>ff", fzf.files)
vim.keymap.set("n", "<leader>fg", fzf.live_grep)
vim.keymap.set("n", "<leader>fb", fzf.buffers)
vim.keymap.set("n", "<leader>fm", fzf.marks)
vim.keymap.set("n", "<leader>fr", fzf.lsp_references)
vim.keymap.set("n", "<leader>fs", fzf.lsp_document_symbols)
vim.keymap.set("n", "<leader>fS", fzf.lsp_workspace_symbols)

local function open_dir_with_fzf(data)
	if vim.fn.isdirectory(data.file) ~= 1 then
		return
	end
	vim.cmd.bwipeout({ data.buf, bang = true })
	fzf.files({ cwd = data.file })
end

-- Handle initial launch differently to avoid race condition.
vim.api.nvim_create_autocmd("VimEnter", {
	group = vim.api.nvim_create_augroup("fzf_lua_explorer", { clear = true }),
	callback = open_dir_with_fzf,
})

vim.api.nvim_create_autocmd("BufEnter", {
	group = "fzf_lua_explorer",
	callback = function(data)
		if vim.v.vim_did_enter == 0 then
			return
		end
		open_dir_with_fzf(data)
	end,
})
